//
//  NetworkService.swift
//  MovieApp
//
//  Created by Izuchukwu Dennis on 05.09.2022.
//

import UIKit

protocol NetworkServiceProtocol: AnyObject {
  associatedtype E
  func parseData<T: Codable>(data: Data, modelType: T.Type) -> Result<T, Error>
  func networkRequest<T: Codable>(
    from endpoint: E,
    modelType: T.Type,
    completion: @escaping (Result<T, Error>) -> Void
  )
}

final class NetworkService<E: EndPointProtocol>: NetworkServiceProtocol {
  func networkRequest<T: Codable>(
    from endpoint: E,
    modelType: T.Type,
    completion: @escaping (Result<T, Error>) -> Void
  ) {
    guard let url = URL(string: "\(endpoint.completeURL)") else {
      completion(.failure(NSError(domain: "empty", code: 0, userInfo: [:])))
      return
    }

    let task = URLSession.shared.dataTask(with: url) { data, _, error in
      if let error = error {
//                debugPrint(error.localizedDescription)
        completion(.failure(error))
      }

      guard let data = data else {
        completion(.failure(NSError(domain: "data is empty", code: 0, userInfo: [:])))
        return
      }

      completion(self.parseData(data: data, modelType: T.self))
    }
    task.resume()
  }

  func parseData<T: Codable>(data: Data, modelType: T.Type) -> Result<T, Error> {
    let decoder = JSONDecoder()

    do {
      let result = try decoder.decode(T.self, from: data)
      return .success(result)
    } catch {
//            print("error while decoding data", error)
      return .failure(error)
    }
  }
}
