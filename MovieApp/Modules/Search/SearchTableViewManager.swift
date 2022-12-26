//
//  SearchTableViewManager.swift
//  MovieApp
//
//  Created by Izuchukwu Dennis on 14.10.2022.
//

import UIKit

protocol SearchTableViewManagerProtocol {
    func setUpTableView(tableView: UITableView, for contentType: ContentType)
    func setUpSearchresults(withMovies movies: [Movie]?, series: [Series]?)
    func updateContentType(with type: ContentType)
}


class SearchTableViewManager: NSObject {
    weak var tableView: UITableView?
    var movies: [Movie] = []
    var series: [Series] = []
    weak var delegate: SearchTableViewManagerDelegate?
    var contentType: ContentType = .movies
}


extension SearchTableViewManager: SearchTableViewManagerProtocol {
    func setUpSearchresults(withMovies movies: [Movie]?, series: [Series]?) {
        switch movies {
        case .none:
            break
        case .some(let movies):
            self.movies = movies
        }
        
        switch series {
        case .none:
            break
        case .some(let series):
            self.series = series
        }
        DispatchQueue.main.async { [weak self] in
            self?.tableView?.reloadData()
        }
    }
    
    func setUpTableView(tableView: UITableView, for contentType: ContentType) {
        self.tableView = tableView
        self.tableView?.delegate = self
        self.tableView?.dataSource = self
        tableView.register(TitleTableViewCell.self, forCellReuseIdentifier: TitleTableViewCell.identifier)
        self.contentType = contentType
    }
    func updateContentType(with type: ContentType) {
        self.contentType = type
    }
        
}

extension SearchTableViewManager: UITableViewDelegate {
    
}

extension SearchTableViewManager: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        switch contentType{
        case .movies:
            return movies.count
        case .series:
            return series.count
        }
        
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        switch contentType{
        case .movies:
            guard let cell = tableView.dequeueReusableCell(withIdentifier: TitleTableViewCell.identifier, for: indexPath) as? TitleTableViewCell,  let title = movies[indexPath.row].title else {
                return UITableViewCell()
            }
            
            cell.configure(withTitle: title, posterPath: movies[indexPath.row].poster_path ?? "")
            return cell
        case .series:
            guard let cell = tableView.dequeueReusableCell(withIdentifier: TitleTableViewCell.identifier, for: indexPath) as? TitleTableViewCell,  let title = series[indexPath.row].name else {
                return UITableViewCell()
            }
            
            cell.configure(withTitle: title, posterPath: series[indexPath.row].poster_path ?? "")
            return cell
        }
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        switch contentType {
        case .movies:
            delegate?.cellClicked(movie: movies[indexPath.row])

        case .series:
            delegate?.cellClicked(series: series[indexPath.row])
        }

    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        100
    }
    
    
}
