import Foundation
import SwiftUI

@MainActor
class NowPlayingViewModel: ObservableObject {
    @Published var currentTrack: Track?
    @Published var isLoading = false
    @Published var error: Error?
    
    private let username = "tom_planche"
    private let apiKey: String
    
    init() {
        // Get API key from environment
        guard let apiKey = ProcessInfo.processInfo.environment["LASTFM_API_KEY"] else {
            fatalError("LASTFM_API_KEY environment variable not set")
        }
        self.apiKey = apiKey
    }
    
    func fetchNowPlaying() async {
        isLoading = true
        defer { isLoading = false }
        
        let urlString = "https://ws.audioscrobbler.com/2.0/?method=user.getRecentTracks&format=json&user=\(username)&limit=1&api_key=\(apiKey)"
        
        guard let url = URL(string: urlString) else { return }
        
        do {
            let (data, _) = try await URLSession.shared.data(from: url)
            let response = try JSONDecoder().decode(LastFMResponse.self, from: data)
            
            if let track = response.recenttracks.track.first, track.isNowPlaying {
                currentTrack = track
            } else {
                currentTrack = nil
            }
        } catch {
            self.error = error
        }
    }
} 