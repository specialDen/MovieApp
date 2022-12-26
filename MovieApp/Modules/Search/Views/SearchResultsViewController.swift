//
//  SearchResultsViewController.swift
//  MovieApp
//
//  Created by Izuchukwu Dennis on 14.10.2022.
//

import UIKit


class SearchResultsViewController: UITableViewController {
//    var moviesPresenter: SearchPresenter?
    weak var searchPresenter: SearchPresenter?
    var searchResults: [String] = []
    var contentType: ContentType = .movies
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemBackground
//        title = "Genres"
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "cell")
        
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
       
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
        cell.accessoryType = .disclosureIndicator
        cell.textLabel?.text = searchResults[indexPath.row]
        cell.textLabel?.font = UIFont(descriptor: .preferredFontDescriptor(withTextStyle: .body), size: 14)
//        cell.textLabel?.adjustsFontSizeToFitWidth = true
        return cell
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        searchResults.count
    }
    override func numberOfSections(in tableView: UITableView) -> Int {
        super.numberOfSections(in: tableView)
        return 1
    }
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        let searchString = searchResults[indexPath.row].replacingOccurrences(of: " ", with: "%20")
        if contentType == .movies {
            searchPresenter?.interactor?.getMovies(with: searchString)
        } else {
            searchPresenter?.interactor?.getSeries(with: searchString)
        }
    }
    
    func configureSugestions(with suggestions: [String]) {
        self.searchResults = suggestions
        DispatchQueue.main.async {
            self.tableView.reloadData()
        }
    }
    public func updateContentType(with type: ContentType) {
        contentType = type
    }
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        view.bounds.height / 25
    }
}
