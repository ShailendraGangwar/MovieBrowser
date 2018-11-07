//
//  MBMovieAPIService.swift
//  MovieBrowser
//
//  Created by Shailendra Gangwar on 05/11/18.
//  Copyright © 2018 Shailendra Gangwar. All rights reserved.
//

import Foundation

class MBMovieAPIService {
    
    static let shared = MBMovieAPIService()
    
    private init() {}
    
    func movieSearch(keyword: String) {
        MBMovieHttpHandler.movieSearch(keyword: keyword) { (error, movies) in
            MBMoviesListDataManager.shared.saveMoviesList(moviesList: movies!, error: error)
        }
    }
    
    func featureMovieSearch(keyword: String) {
        MBMovieHttpHandler.featureMovieSearch(keyword: keyword) { (error, movies) in
            MBMoviesListDataManager.shared.saveFeaturedList(featuredList: movies!, error: error)
        }
    }
    
    func titleSearch(keyword: String, completion: @escaping (Error?, MBMovie?) -> Void) {
        MBMovieHttpHandler.titleSearch(keyword: keyword) { (error, movie) in
            completion(error, movie)
        }
    }
}
