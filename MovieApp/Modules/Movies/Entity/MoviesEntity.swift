//
//  MoviesEntity.swift
//  MovieApp
//
//  Created by Izuchukwu Dennis on 03.02.2022.
//

import Foundation

struct MoviesData: Codable {
  let results: [Movie]
}

struct Movie: Codable {
//    swiftLint: disable identifier_name
  let id: Int?
  //    swiftLint: disable: identifier_name
  let vote_average: Double?
  let title: String?
  let release_date: String?
  let overview: String?
  let poster_path: String?
//    let name: String?
}

struct VideoData: Codable {
  let id: Int
  let results: [Results]
}

struct Results: Codable {
  let key: String
  let site: String
  let official: Bool
  let id: String
}

struct InformationData {
  let id: Int?
  let vote_average: Double?
  let title: String?
  let release_date: String?
  let overview: String?
  let poster_path: String?
  var isSaved: Bool?
  let saveLocation: Int?
}

struct Genres: Codable {
  let genres: [GenreModel]
}

struct GenreModel: Codable {
  let id: Int
  let name: String
}

enum MovieLists {
  case trendingMovies(_ movies: MoviesData)
  case upcomingMovies(_ movies: MoviesData)
  case latestMovies(_ movies: MoviesData)
  case topRatedMovies(_ movies: MoviesData)
  case popularMovies(_ movies: MoviesData)

  static var allCases: [MovieLists] {
    let mockMovie = Movie(
      id: nil,
      vote_average: nil,
      title: nil,
      release_date: nil,
      overview: nil,
      poster_path: nil
    )

    let mockMovieData = MoviesData(results: [mockMovie])
    return [
      .trendingMovies(mockMovieData),
      .topRatedMovies(mockMovieData),
      .upcomingMovies(mockMovieData),
      .latestMovies(mockMovieData),
      .popularMovies(mockMovieData)
    ]
  }

  var items: [Movie] {
    switch self {
    case let .latestMovies(items),
         let .trendingMovies(items),
         let .popularMovies(items),
         let .topRatedMovies(items),
         let .upcomingMovies(items):
      return items.results
    }
  }

  var count: Int {
    return items.count
  }

  var title: String {
    switch self {
    case .trendingMovies:
      return "Trending Movies"
    case .upcomingMovies:
      return "Upcoming Movies"
    case .latestMovies:
      return "Latest Movies"
    case .topRatedMovies:
      return "Top rated Movies"
    case .popularMovies:
      return "Popular Movies"
    }
  }
}
