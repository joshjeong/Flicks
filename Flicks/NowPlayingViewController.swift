//
//  NowPlayingViewController.swift
//  Flicks
//
//  Created by Josh Jeong on 3/29/17.
//  Copyright © 2017 JoshJeong. All rights reserved.
//

import UIKit
import AFNetworking

class NowPlayingViewController: UIViewController {
    
    @IBOutlet weak var tableView: UITableView!
    
    var movies: [Movie] = []

    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.register(UINib(nibName: "ListTableViewCell", bundle: nil), forCellReuseIdentifier: "ListTableViewCell")
        tableView.rowHeight = 100
        Movie.fetchNowPlayingMovies(successCallBack: {movies in
            self.movies = movies
            self.tableView.reloadData()
        }, errorCallBack: nil)
    }
    
}

extension NowPlayingViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return movies.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "ListTableViewCell", for: indexPath) as! ListTableViewCell
        let movie = movies[indexPath.row]
        if let posterPath = movie.posterPath {
            let baseURL = "http://image.tmdb.org/t/p/w185"
            print(baseURL + posterPath)
            cell.thumbnailImageView.setImageWith(URL(string: baseURL + posterPath)!)
            cell.thumbnailImageView.contentMode = .scaleAspectFit
        }
        cell.titleLabel.text = movie.originalTitle
        cell.descriptionLabel.text = movie.overview
        return cell
    }
}

