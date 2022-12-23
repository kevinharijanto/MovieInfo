//
//  Movie.swift
//  MovieInfo
//
//  Created by Kevin Harijanto on 25/11/22.
//

import Foundation

// MARK: - Wrapper
struct MoviesResponse: Decodable {
    let results: [Movie]
}

// MARK: - Movie Model
struct Movie: Decodable, Identifiable, Hashable {
    static func == (lhs: Movie, rhs: Movie) -> Bool {
        lhs.id == rhs.id
    }
    
    func hash(into hasher: inout Hasher) {
        hasher.combine(id)
    }
    
    let id: Int
    let title: String
    let backdropPath: String?
    let posterPath: String?
    let overview: String
    let voteAverage: Double?
    let voteCount: Int?
    let runtime: Int?
    let releaseDate: String?

    let genres: [MovieGenre]?
    let videos: MovieVideoResponse?

    static private let yearFormatter: DateFormatter = {
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy"
        return formatter
    }()

    static private let durationFormatter: DateComponentsFormatter = {
        let formatter = DateComponentsFormatter()
        formatter.unitsStyle = .short
        formatter.allowedUnits = [.hour, .minute]
        return formatter
    }()

    var backdropURL: String {
        return "https://image.tmdb.org/t/p/w500\(backdropPath ?? "")"
    }

    var posterURL: String {
        return "https://image.tmdb.org/t/p/w500\(posterPath ?? "")"
    }

    var genreText: String {
        genres.map { genre in
            genre.map{ $0.name }
                .joined(separator: " | ")
        }!
    }

    var ratingText: String {
        let rating = voteAverage?.oneDigit
        return "\(rating)"
    }

    var yearText: String {
        guard let releaseDate = self.releaseDate, let date = Utils.dateFormatter.date(from: releaseDate) else {
            return "n/a"
        }
        return Movie.yearFormatter.string(from: date)
    }

    var durationText: String {
        guard let runtime = self.runtime, runtime > 0 else {
            return "n/a"
        }
        return Movie.durationFormatter.string(from: TimeInterval(runtime) * 60) ?? "n/a"
    }

    var youtubeTrailers: [MovieVideo]? {
        videos?.results.filter { $0.youtubeURL != nil }
    }
}


struct MovieGenre: Decodable {
    let name: String
}

struct MovieVideoResponse: Decodable {
    let results: [MovieVideo]
}

struct MovieVideo: Decodable, Identifiable {
    
    let id: String
    let key: String
    let name: String
    let site: String
    
    var youtubeURL: URL? {
        guard site == "YouTube" else {
            return nil
        }
        return URL(string: "www.youtube.com/watch?v=\(key)")
    }
}

extension Movie {
    static var data: [Movie] = {[
        Movie(id: 0, title: "", backdropPath: "", posterPath: "", overview: "", voteAverage: 0.0, voteCount: 0, runtime: 0, releaseDate: "", genres: genre, videos: videoA[0])
    ]}()
    
    static var genre: [MovieGenre] = {[
        MovieGenre(name: "")
    ]}()
    
    static var videoA: [MovieVideoResponse] = {[
        MovieVideoResponse(results: video)
    ]}()
    
    static var video: [MovieVideo] = {[
        MovieVideo(id: "", key: "", name: "", site: "")
    ]}()
}
