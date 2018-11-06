//
//  MBMoviesListDataManager.swift
//  MovieBrowser
//
//  Created by Shailendra Gangwar on 05/11/18.
//  Copyright © 2018 Shailendra Gangwar. All rights reserved.
//

import Foundation

protocol MBMoviesUpdateDelegate: class {
    func moviesListUpdated(error: Error?)
    func featuredListUpdated(error: Error?)
}

class MBMoviesListDataManager: NSObject {
    
    public var moviesList = [MBMovie]()
    public var featuredList = [MBMovie]()
    weak var moviesListUpdateDelegate: MBMoviesUpdateDelegate?
    
    static let shared = MBMoviesListDataManager()
    
    private override init(){}
    
    func saveMoviesList(moviesList: [MBMovie], error: Error?) {
        self.moviesList = moviesList
        moviesListUpdateDelegate?.moviesListUpdated(error: error)
    }
    
    func saveFeaturedList(featuredList: [MBMovie], error: Error?) {
        self.featuredList = featuredList
        moviesListUpdateDelegate?.featuredListUpdated(error: error)
    }
}
