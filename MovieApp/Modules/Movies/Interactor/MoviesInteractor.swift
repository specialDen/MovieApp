//
//  MoviesInteractor.swift
//  MovieApp
//
//  Created by Izuchukwu Dennis on 03.02.2022.
//

import Foundation

protocol MoviesInteractorProtocol {
  var presenter: MoviesPresenterInput? { get set }
  var apiManager: NetworkService<MoviesEndpoint>? { get }
  func getMovies()
  func getGenres()
  func getGenreMovies(withGenre genre: GenreModel)
  func getVideo(forMovieid id: Int, completion: @escaping (String) -> Void)
}

class MoviesInteractor: MoviesInteractorProtocol {
  weak var presenter: MoviesPresenterInput?
  var apiManager: NetworkService<MoviesEndpoint>? = NetworkService()

  func getMovies() {
    for movieCategory in MovieLists.allCases {
      switch movieCategory {
      case .trendingMovies:
        performNetworkRequest(.getTrendingMovies)
      case .upcomingMovies:
        performNetworkRequest(.getUpcomingMovies)
      case .latestMovies:
        performNetworkRequest(.getLatest)
      case .topRatedMovies:
        performNetworkRequest(.getTopRated)
      case .popularMovies:
        performNetworkRequest(.getPopularMovies)
      }
    }
  }

  func getGenres() {
    performNetworkRequest(.getGenres)
  }

  func getVideo(forMovieid id: Int, completion: @escaping (String) -> Void) {
    apiManager?.networkRequest(from: MoviesEndpoint.getVideo(forMovieid: id), modelType: VideoData.self) { result in
      switch result {
      case let .success(videos):
        guard let key = videos.results.first?.key else {
          return
        }
        print("gotten")
        completion(key)
      case let .failure(error):
        print(error.localizedDescription)
      }
    }
  }

  func getGenreMovies(withGenre genre: GenreModel) {
    performNetworkRequest(.getMovies(withGenre: genre))
  }

  private func processData(_ movieData: MoviesData, endpoint: MoviesEndpoint) {
    switch endpoint {
    case .getTrendingMovies:
      presenter?.apiFetchSuccess(movies: .trendingMovies(movieData))
    case .getUpcomingMovies:
      presenter?.apiFetchSuccess(movies: .upcomingMovies(movieData))
    case .getLatest:
      presenter?.apiFetchSuccess(movies: .latestMovies(movieData))
    case .getTopRated:
      presenter?.apiFetchSuccess(movies: .topRatedMovies(movieData))
    case .getPopularMovies:
      presenter?.apiFetchSuccess(movies: .popularMovies(movieData))
    case .getVideo:
      break
    case .getGenres:
      break
    case .searchForMovies:
      break
    case .getMovies:
      break
    }
  }

  private func performNetworkRequest(_ endpoint: MoviesEndpoint) {
    switch endpoint {
    case .getLatest:
      apiManager?.networkRequest(from: endpoint, modelType: Movie.self, completion: { [weak self] result in
        switch result {
        case let .success(movieData):
          self?.presenter?.apiFetchSuccess(movies: .latestMovies(MoviesData(results: [movieData])))
        case let .failure(error):
          print(error.localizedDescription)
        }
      })
    case .getGenres:
      apiManager?.networkRequest(from: endpoint, modelType: Genres.self, completion: { [weak self] result in
        switch result {
        case let .success(genres):
          self?.presenter?.genresFetchSuccess(genres: genres)
        case let .failure(error):
          print(error.localizedDescription)
        }

      })
    case let .getMovies(genre):
      apiManager?.networkRequest(from: endpoint, modelType: MoviesData.self, completion: { [weak self] result in
        switch result {
        case let .success(movies):
          self?.presenter?.genresMoviesFetchSuccess(movies: movies.results, genre: genre.name)
        case let .failure(error):
          print(error.localizedDescription)
        }

      })

    default:
      apiManager?.networkRequest(from: endpoint, modelType: MoviesData.self, completion: { [weak self] result in
        switch result {
        case let .success(movieData):
          self?.processData(movieData, endpoint: endpoint)
        case let .failure(error):
          print(error.localizedDescription)
        }
      })
    }
  }

  deinit {
    print("movies interactor deinit")
  }
}
