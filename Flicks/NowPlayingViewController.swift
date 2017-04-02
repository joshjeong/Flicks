//
//  NowPlayingViewController.swift
//  Flicks
//
//  Created by Josh Jeong on 3/29/17.
//  Copyright © 2017 JoshJeong. All rights reserved.
//

import UIKit
import AFNetworking
import MBProgressHUD

class NowPlayingViewController: UIViewController {
    
    @IBOutlet weak var tableView: UITableView!
    
    var movies: [Movie] = []

    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.register(UINib(nibName: "ListTableViewCell", bundle: nil), forCellReuseIdentifier: "ListTableViewCell")
        tableView.rowHeight = 150
        
        let refreshControl = UIRefreshControl()
        refreshControl.addTarget(self, action: #selector(self.refreshData(_:)), for: UIControlEvents.valueChanged)
        tableView.insertSubview(refreshControl, at: 0)
        
        refreshData(refreshControl)
        tableView.delegate = self
        tableView.dataSource = self
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        self.navigationController?.setNavigationBarHidden(true, animated: animated)
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        
        self.navigationController?.setNavigationBarHidden(false, animated: animated)
    }
    
    func refreshData(_ refreshControl: UIRefreshControl) {
        MBProgressHUD.showAdded(to: self.view, animated: true)
        
        Movie.fetchNowPlayingMovies(successCallBack: {movies in
            self.movies = movies
            self.tableView.reloadData()
            refreshControl.endRefreshing()
            MBProgressHUD.hide(for: self.view, animated: true)
        }, errorCallBack: { error in
            if let error = error {
                print(error)
            }
            
            self.showError(message: "Can't connect to the internet. Please try again later.")
            
            refreshControl.endRefreshing()
            MBProgressHUD.hide(for: self.view, animated: true)
        })
    }
    
    func showError(message: String) {
        let alert = UIAlertController(title: "Error", message: message, preferredStyle: UIAlertControllerStyle.alert)
        alert.addAction(UIAlertAction(title: "Ok", style: UIAlertActionStyle.default, handler: nil))
        self.present(alert, animated: true, completion: nil)
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
            
            cell.thumbnailImageView.setImageWith(URL(string: baseURL + posterPath)!)
            cell.thumbnailImageView.contentMode = .scaleAspectFit
        }
        cell.titleLabel.text = movie.originalTitle
        cell.descriptionLabel.text = movie.overview
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let vc = storyboard?.instantiateViewController(withIdentifier: "MovieDetailViewController") as! MovieDetailViewController
        vc.movie = movies[indexPath.row]
        navigationController?.pushViewController(vc, animated: true)
        tableView.deselectRow(at: indexPath, animated:true)
    }
}

