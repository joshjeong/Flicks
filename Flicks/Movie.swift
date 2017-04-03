//
//  Movie.swift
//  Flicks
//
//  Created by Josh Jeong on 3/29/17.
//  Copyright © 2017 JoshJeong. All rights reserved.
//

import Foundation

class Movie {
    var movies = [Movie]()
    var adult: Bool?
    var backdropPath: String?
    var genreIds: [Int]?
    var id: Int?
    var originalLanguage: String?
    var originalTitle: String?
    var overview: String?
    var popularity: Float?
    var posterPath: String?
    var releaseDate: String?
    var title: String?
    var video: Bool?
    var voteAvg: Float?
    var voteCount: Float?
    
    init?(json: [String: Any]) {
        
        guard let adult = json["adult"] as? Bool,
            let backdropPath = json["backdrop_path"] as? String,
            let genreIds = json["genre_ids"] as? [Int],
            let id = json["id"] as? Int,
            let originalLanguage = json["original_language"] as? String,
            let originalTitle = json["original_title"] as? String,
            let overview = json["overview"] as? String,
            let popularity = json["popularity"] as? Float,
            let posterPath = json["poster_path"] as? String,
            let releaseDate = json["release_date"] as? String,
            let title = json["title"] as? String,
            let video = json["video"] as? Bool,
            let voteAvg = json["vote_average"] as? Float,
            let voteCount = json["vote_count"] as? Float
            else {
                print("Incorrect JSON")
                return nil
            }
        
        self.backdropPath = backdropPath
        self.genreIds = genreIds
        self.id = id
        self.originalLanguage = originalLanguage
        self.originalTitle = originalTitle
        self.overview = overview
        self.popularity = popularity
        self.posterPath = posterPath
        self.releaseDate = releaseDate
        self.title = title
        self.video = video
        self.voteAvg = voteAvg
        self.voteCount = voteCount
    }
}


extension Movie {
    
    static func fetchNowPlayingMovies(endpoint: String, successCallBack: @escaping ([Movie]) -> (), errorCallBack: ((Error?) -> ())?) {
        let apiKey = "47809af88c3a5d4813ca5f235604fea6"
        let url = URL(string: "https://api.themoviedb.org/3/movie/\(endpoint)?api_key=\(apiKey)")!
        let request = URLRequest(url: url, cachePolicy: .reloadIgnoringLocalCacheData, timeoutInterval: 10)
        let session = URLSession(configuration: .default, delegate: nil, delegateQueue: OperationQueue.main)
        let task: URLSessionDataTask = session.dataTask(with: request) { (data: Data?, response: URLResponse?, error: Error?) in
            var movies: [Movie] = []
            if let error = error {
                errorCallBack?(error)
            } else if let data = data,
                
            let json = try? JSONSerialization.jsonObject(with: data, options: []) as? NSDictionary {
                
                if let results = json?["results"] as? [[String: AnyObject]] {   
                    for result in results {
                        if let movie = Movie(json: result) {
                            movies.append(movie)
                        }
                    }
                }

                successCallBack(movies)
            }
        }
        task.resume()
    }
    
}



