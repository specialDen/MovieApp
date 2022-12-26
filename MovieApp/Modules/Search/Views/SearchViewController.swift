//
//  SearchViewController.swift
//  MovieApp
//
//  Created by Izuchukwu Dennis on 14.10.2022.
//

import UIKit

class SearchViewController: UIViewController {
    
    var presenter: SearchPresenterProtocol?
    var searchResultsVC: SearchResultsViewController?
    var contentType: ContentType?
    override func viewDidLoad() {
        super.viewDidLoad()
        contentType = .movies
        setUpUI()
        searchController.searchResultsUpdater = self
        presenter?.viewNeedsMovies()
        self.presenter?.collectionManager?.setUpTableView(tableView: tableView, for: contentType!)
        navigationItem.rightBarButtonItems = [.init(customView: moviesButton),.init(customView: seriesButton)]
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        let width  = view.frame.width / 6
        let height = width * 0.5
        moviesButton.frame = CGRect(x: 0, y: 0, width: width, height: height)
        seriesButton.frame = CGRect(x: 0, y: 0, width: width, height: height)
        tableView.frame = view.bounds
        moviesButton.addTarget(self, action: #selector(didSelectMovies), for: .touchUpInside)
        seriesButton.addTarget(self, action: #selector(didSelectSeries), for: .touchUpInside)
    }
    @objc private func didSelectMovies() {
        self.contentType = .movies
        moviesButton.layer.borderColor = UIColor.systemPurple.cgColor
        seriesButton.layer.borderColor = UIColor.clear.cgColor
        searchResultsVC?.updateContentType(with: contentType!)
        searchController.searchBar.placeholder = "Search Movies"
        self.presenter?.collectionManager?.updateContentType(with: contentType!)
        self.presenter?.viewNeedsMovies()
    }
    
    @objc private func didSelectSeries() {
        self.contentType = .series
        seriesButton.layer.borderColor = UIColor.systemPurple.cgColor
        moviesButton.layer.borderColor = UIColor.clear.cgColor
        searchResultsVC?.updateContentType(with: contentType!)
        searchController.searchBar.placeholder = "Search Series"
        self.presenter?.collectionManager?.updateContentType(with: contentType!)
        self.presenter?.viewNeedsSeries()
    }
    private func toggleContentType() {
        switch contentType {
        case .none:
            break
        case .some(let content):
            switch content {
            case .movies:
                self.contentType = .series
            case .series:
                self.contentType = .movies
            }
        }
    }
    private lazy var moviesButton: UIButton = {
        let button = UIButton(frame: .zero)
        button.setTitle("Movies", for: .normal)
        button.setTitleColor(.systemGray, for: .normal)
        button.layer.borderWidth = 2
        button.layer.borderColor = UIColor.systemPurple.cgColor
        button.layer.cornerRadius = 8
        return button
    }()
    
    private lazy var seriesButton: UIButton = {
        let button = UIButton(frame: .zero)
        button.setTitle("Series", for: .normal)
        button.setTitleColor(.systemGray, for: .normal)
        button.layer.borderColor = UIColor.clear.cgColor
        button.layer.borderWidth = 2
        button.layer.cornerRadius = 8
        return button
    }()
    
    private lazy var tableView: UITableView = {
        let tableView = UITableView(frame: .zero)
        tableView.keyboardDismissMode = .interactive
        tableView.backgroundColor = .clear
        return tableView
    }()
    
    private lazy var searchController: UISearchController = {
        let searchController = UISearchController(searchResultsController: searchResultsVC)
        searchController.obscuresBackgroundDuringPresentation = true
        searchController.searchBar.placeholder = "Search Movies"
        return searchController
    }()
    
    private func setUpUI() {
        title = "Search"
        navigationController?.navigationBar.prefersLargeTitles = true
        view.backgroundColor = .systemBackground
        view.addSubview(tableView)
        navigationItem.searchController = searchController
        
    }
    
}

extension SearchViewController: UISearchResultsUpdating{
    func updateSearchResults(for searchController: UISearchController) {
        guard var text = searchController.searchBar.text else {
            return
        }
        text = text.replacingOccurrences(of: " ", with: "%20")
        presenter?.fetchSuggestions(with: text, contentType: contentType!)
    }
    
    
}
