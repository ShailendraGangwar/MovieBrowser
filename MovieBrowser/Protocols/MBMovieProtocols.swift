//
//  MBMovieProtocols.swift
//  MovieBrowser
//
//  Created by Shailendra Gangwar on 06/11/18.
//  Copyright © 2018 Shailendra Gangwar. All rights reserved.
//

import Foundation
import UIKit

// MARK: - MBHomeViewPresenterProtocol
// MARK: -

/**
 ## MBHomeViewPresenterProtocol provides implemetation for setting:
 - Movies list
 - Featured Movies List
 */
protocol MBHomeViewPresenterProtocol: class {
    
    /**
     Setting movies list.
     - Parameter movies: Movies list.
     */
    func setMoviesList(movies: [MBMovie])
    
    /**
     Setting featured movie list.
     - Parameter movies: Featured movies.
     */
    func setFeaturedList(movies: [MBMovie])
}

// MARK: - MBMovieDetailsPresenterProtocol
// MARK: -

/**
 ## MBMovieDetailsPresenterProtocol provides implemetation for setting:
 - Movies details.
 */
protocol MBMovieDetailsPresenterProtocol: class {
    
    /**
     Setting the movie details.
     - Parameter movie: The movie being presented.
     */
    func setMovie(movie: MBMovie)
}

// MARK: - MBMovieHelperProtocol
// MARK: -

/**
 ## MBMovieHelperProtocol provides implemetation for showing/hiding.
 - Loader
 - Error message
 */
protocol MBMovieHelperProtocol: class {
    
    /**
     Show loader.
     */
    func startLoading()
    
    /**
     Stop loader.
     */
    func finishLoading()
    
    /**
     Show error message.
     - Parameter error: error being presented.
     */
    func showErrorMessage(error: Error)
}

// MARK: - MBRouterProtocol
// MARK: -

/**
 ## MBRouterProtocol provides implemetation for setting
 - Presenter for Home view
 - Pushing to detail screen
 */
protocol MBRouterProtocol: class {
    
    /**
     Show detail screen for Movie.
     - Parameter movie: The movie being presented.
     - Parameter movieImage: The movie image being presented.
     - Parameter view: View controller from which detail are being pushed.
     */
    func pushToMovieDetailsWith(movie: MBMovie?, movieImage: UIImage?, view: UIViewController)
    
    /**
     Atttach presenter to Home view.
     - Parameter homeView: Home view controller.
     */
    static func attachHomePresenter(homeView: MBHomeViewController)
}

// MARK: - MBFeaturedListActionProtocol
// MARK: -

/**
 ## MBFeaturedListActionProtocol provides implemetation for action.
 - Selecting an item in featured list.
 */
protocol MBFeaturedListActionProtocol: class {
    
    /**
     Invokes when item is selected in featured list
     - Parameter movie: The movie being presented.
     - Parameter movieImage: The movie image being presented.
     */
    func itemSelectedWith(movie: MBMovie?, movieImage: UIImage?)
}

// MARK: - MBMoviesUpdateDelegate
// MARK: -

/**
 ## MBMoviesUpdateDelegate provides implemetation for notifying.
 - receiving of featured list.
 - receiving of movies list
 */
protocol MBMoviesUpdateDelegate: class {
    
    /**
     Invokes when item is selected in featured list
     - Parameter error: error
     */
    func moviesListUpdated(error: Error?)
    
    /**
     Invokes when item is selected in featured list
     - Parameter error: error.
     */
    func featuredListUpdated(error: Error?)
}

