//
//  MBMovieAPIService.swift
//  MovieBrowser
//
//  Created by Shailendra Gangwar on 05/11/18.
//  Copyright © 2018 Shailendra Gangwar. All rights reserved.
//

import Foundation

/**
 ## MBMovieAPIService responsible for:
 - Getting Movies list
 - Getting featured movies list
 - Getting movie details
 */
class MBMovieAPIService {
    
    /// shared variable
    static let shared = MBMovieAPIService()
    /// http handler
    var movieHttpHandler: MBMovieHttpHandler?
    /**
     Initializer
     */
    private init() {
        movieHttpHandler = MBMovieHttpHandler(session: URLSession.shared)
    }
    
    /**
     Get movies list.
     - Parameter topic: Topic to be searched.
     */
    func getMoviesList(topic: String) {
        movieHttpHandler?.getMovies(topic: topic) { (error, movies) in
            MBMoviesListDataManager.shared.saveMoviesList(moviesList: movies!, error: error)
        }
    }
    
    /**
     Get featured movies list.
     - Parameter topic: Topic to be searched.
     */
    func getfeatureMoviesList(topic: String) {
        movieHttpHandler?.getFeatureMovies(topic: topic) { (error, movies) in
            MBMoviesListDataManager.shared.saveFeaturedList(featuredList: movies!, error: error)
        }
    }
    
    /**
     Get details for Movie.
     - Parameter movieTitle: movie title.
     - Parameter completion: Completion block.
     */
    func getDetailsFor(movieTitle: String, completion: @escaping (Error?, MBMovie?) -> Void) {
        movieHttpHandler?.getDetailsFor(movie: movieTitle) { (error, movie) in
            completion(error, movie)
        }
    }
}
