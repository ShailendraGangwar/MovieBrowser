//
//  MBMoviesListDataManager.swift
//  MovieBrowser
//
//  Created by Shailendra Gangwar on 05/11/18.
//  Copyright © 2018 Shailendra Gangwar. All rights reserved.
//

import Foundation

/**
 ## MBMoviesListDataManager responsible for:
 - Notify presenter on receiving movies list
 - Notify presenter on receiving featured movies list
 */
class MBMoviesListDataManager: NSObject {
    
    /// Movies list
    public var moviesList = [MBMovie]()
    /// Featured movies list
    public var featuredList = [MBMovie]()
    /// Delegate
    weak var moviesListUpdateDelegate: MBMoviesUpdateDelegate?
    /// shared variable
    static let shared = MBMoviesListDataManager()
    
    /**
     Initializer
     */
    private override init(){}
    
    /**
     Save movies list and notify.
     - Parameter moviesList: movies list.
     - Parameter error: error.
     */
    func saveMoviesList(moviesList: [MBMovie], error: Error?) {
        self.moviesList = moviesList
        moviesListUpdateDelegate?.moviesListUpdated(error: error)
    }
    
    /**
     Get featured movies list.
     - Parameter topic: Topic to be searched.
     */
    func saveFeaturedList(featuredList: [MBMovie], error: Error?) {
        self.featuredList = featuredList
        moviesListUpdateDelegate?.featuredListUpdated(error: error)
    }
}
