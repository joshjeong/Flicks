//
//  MovieDetailViewController.swift
//  Flicks
//
//  Created by Josh Jeong on 3/31/17.
//  Copyright © 2017 JoshJeong. All rights reserved.
//

import UIKit

class MovieDetailViewController: UIViewController {
    @IBOutlet weak var posterImageView: UIImageView!
    @IBOutlet weak var scrollView: UIScrollView!
    @IBOutlet weak var containerView: UIView!

    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var dateLabel: UILabel!
    @IBOutlet weak var ratingLabel: UILabel!
    @IBOutlet weak var overviewLabel: UILabel!
    
    @IBOutlet weak var containerViewHeight: NSLayoutConstraint!
    @IBOutlet weak var containerViewTopConstraint: NSLayoutConstraint!
    
    var movie: Movie?
    
    override func viewDidLoad() {
        super.viewDidLoad()
  
        let baseURL = "http://image.tmdb.org/t/p/original"
        if let posterPath = movie?.posterPath {
            posterImageView.setImageWith(URL(string: baseURL + posterPath)!)
        }
        
        generateView()
    }
    
    func generateView() {
        if let movie = movie {
            if let title = movie.title {
                titleLabel.text = title
            }
            
            if let date = movie.releaseDate {
                dateLabel.text = formatDate(date: date)
            }
            
            if let rating = movie.popularity {
                ratingLabel.text = "\(Int(rating))%"
            }
            
            if let overview = movie.overview {
                overviewLabel?.text = overview
                overviewLabel?.sizeToFit()
            }
        }
        containerViewHeight.constant = overviewLabel.frame.height + 150
        containerViewTopConstraint.constant = view.bounds.height - 250
    }
    
    func formatDate(date: String) -> String {

        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd"
        
        guard let date = dateFormatter.date(from: date) else {
            assert(false, "no date from string")
            return ""
        }
        
        dateFormatter.dateFormat = "MMM dd, yyyy"
        let timeStamp = dateFormatter.string(from: date)
        
        return timeStamp
    }
}
