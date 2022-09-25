//
//  SeriesViewController.swift
//  MovieApp
//
//  Created by Izuchukwu Dennis on 03.02.2022.
//

import UIKit

class SomeViewController: UIViewController {
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    private let tableView: UITableView = {
        let tableView  = UITableView()
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "cell")
        return tableView
    }()
    
    
}

