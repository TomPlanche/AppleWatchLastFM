//
//  ContentView.swift
//  AppleWatchLastFMDisplay Watch App
//
//  Created by Tom Planche on 16/02/2025.
//

import SwiftUI

struct ContentView: View {
    @StateObject private var viewModel = NowPlayingViewModel()
    
    var body: some View {
        Group {
            if let track = viewModel.currentTrack {
                ZStack {
                    // Album artwork
                    if let imageUrl = track.image.first(where: { $0.size == "extralarge" })?.url {
                        AsyncImage(url: URL(string: imageUrl)) { image in
                            image
                                .resizable()
                                .aspectRatio(contentMode: .fill)
                        } placeholder: {
                            ProgressView()
                        }
                    }
                    
                    // Track info
                    VStack(spacing: 4) {
                        Spacer()
                        
                        Text(track.name)
                            .font(.headline)
                            .lineLimit(1)
                        
                        Text(track.artist.text)
                            .font(.subheadline)
                            .lineLimit(1)
                        
                        Text(track.album.text)
                            .font(.caption)
                            .lineLimit(1)
                        
                        Spacer()
                    }
                    .padding()
                    .frame(
                        maxWidth: .infinity,
                        maxHeight: .infinity,
                        alignment: .center
                    )
                    .background(
                        Color.black
                            .opacity(0.3)
                    )
                    
                }
            } else {
                Text("Nothing playing")
            }
        }
        .task {
            await viewModel.fetchNowPlaying()
        }
    }
}

#Preview {
    ContentView()
}
