//
//  DiscoverMoviesService.swift
//  MovieApp
//
//  Created by Izuchukwu Dennis on 08.02.2022.
//

//import Foundation
//
//class DiscoverMoviesService {
//
//      func fetchMovies() -> MoviesData?{
//
//        guard let movieData = getData() else {
//            return nil
//        }
//        guard let decodedData = decodeData(data: movieData) else {
//            return nil
//        }
//        saveData(data: decodedData)
//
//         return decodedData
//
//    }
//
//    private func decodeData(data: Data) -> MoviesData? {
//        let decoder = JSONDecoder()
//
//        do{
//            let decodedMoviesData = try decoder.decode(MoviesData.self, from: data)
//            return decodedMoviesData
//        }
//        catch {
//            print("could not parse Json---\(error)")
//            return nil
//        }
//    }
//
//
//    private func getData() -> Data? {
//        let completeQueryURL = EndPoints.discoverMovies.baseUrl + Keys.clientID
//        var dataToReturn : Data?
//        guard let url = URL(string: completeQueryURL) else {
//            return nil}
//
////        let session = URLSession(configuration: .default)
//        let task = URLSession.shared.dataTask(with: url) {  (data, _, error) in
//            guard let safeData = data, error == nil else {
//                print("Newtwork Problem \(error!)")
//                return
//            }
//         dataToReturn =  safeData
//        }
//        task.resume()
//
//       return dataToReturn
//    }
//
//    private func saveData(data: MoviesData) {
//
//    }
//
//}
