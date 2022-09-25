//
//  GenresVC.swift
//  MovieApp
//
//  Created by Izuchukwu Dennis on 25.09.2022.
//

import UIKit

class GenresViewController: UITableViewController {
    var presenter: MoviesPresenter?
    var genres: [GenreModel] = []
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "Genres"
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "cell")
        
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
       
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
        cell.textLabel?.text = genres[indexPath.row].name
        return cell
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        genres.count
    }
    override func numberOfSections(in tableView: UITableView) -> Int {
        super.numberOfSections(in: tableView)
        return 1
    }
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        presenter?.getMovies(withGenreId: genres[indexPath.row].id)
    }
    
    func configureGenres(with genres: [GenreModel]) {
        self.genres = genres
        tableView.reloadData()
    }
}


