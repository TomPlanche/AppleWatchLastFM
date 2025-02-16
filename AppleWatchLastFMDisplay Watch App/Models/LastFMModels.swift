import Foundation

struct LastFMResponse: Codable {
    let recenttracks: RecentTracks
}

struct RecentTracks: Codable {
    let track: [Track]
}

struct Track: Codable {
    let artist: Artist
    let name: String
    let album: Album
    let image: [Image]
    let attributes: Attributes?
    
    var isNowPlaying: Bool {
        return attributes?.nowplaying == "true"
    }
    
    enum CodingKeys: String, CodingKey {
        case artist, name, album, image
        case attributes = "@attr"
    }
}

struct Artist: Codable {
    let text: String
    
    enum CodingKeys: String, CodingKey {
        case text = "#text"
    }
}

struct Album: Codable {
    let text: String
    
    enum CodingKeys: String, CodingKey {
        case text = "#text"
    }
}

struct Image: Codable {
    let size: String
    let url: String
    
    enum CodingKeys: String, CodingKey {
        case size
        case url = "#text"
    }
}

struct Attributes: Codable {
    let nowplaying: String?
} 