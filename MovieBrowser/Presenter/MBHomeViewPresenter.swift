//
//  MBHomeViewPresenter.swift
//  MovieBrowser
//
//  Created by Shailendra Gangwar on 05/11/18.
//  Copyright © 2018 Shailendra Gangwar. All rights reserved.
//

import Foundation
import UIKit
/**
 - MBHomeViewPresenter is responsible for presenting data to Home View Controller.
 - It interacts with MBMoviesListDataManager to get data.
 - It interacts with MBMovieAPIService to make http request
 - It asks router to push details view controller.
 */
class MBHomeViewPresenter {
    
    // MARK: - Variables
    // MARK: -
    
    /// Data store to get movies data
    var moviesListDataStore = MBMoviesListDataManager.shared
    /// Home view presenter protocol
    weak var homeViewPresenter: MBHomeViewPresenterProtocol?
    /// Home view helper protocol
    weak var homeViewHelper: MBMovieHelperProtocol?
    /// Home view router protocol
    var homeViewRouter: MBRouterProtocol?
    
    // MARK: - Initializer
    // MARK: -
    
    /**
     Initializer
     */
    init() {
        self.moviesListDataStore.moviesListUpdateDelegate = self
    }
    
    // MARK: - Methods
    // MARK: -
    
    /**
     Get movies list for table list.
     */
    func getMoviesForTableList() {
        self.homeViewHelper?.startLoading()
        MBMovieAPIService.shared.getMoviesList(topic: MBStringConstants.movieListTopic)
    }
    
    /**
     Get featured movies list for featured list.
     */
    func getFeaturedMovies() {
        self.homeViewHelper?.startLoading()
        MBMovieAPIService.shared.getfeatureMoviesList(topic: MBStringConstants.featuredListTopic)
    }
    
    /**
     Show detail screen for Movie.
     - Parameter movie: The movie being presented.
     - Parameter movieImage: The movie image being presented.
     - Parameter initialView: View controller from which detail are being pushed.
     */
    func showDetailsfor(movie: MBMovie?, movieImage: UIImage?, initialView: UIViewController) {
        self.homeViewRouter?.pushToMovieDetailsWith(movie: movie, movieImage: movieImage, view: initialView)
    }
}
// MARK: - MBMoviesUpdateDelegate
// MARK: -
extension MBHomeViewPresenter: MBMoviesUpdateDelegate {
    /**
     Notify featured list is received and updated.
     It tells to stop loader.
     It also tells to show error if any
     - Parameter error: Error
     */
    func featuredListUpdated(error: Error?) {
        self.homeViewHelper?.finishLoading()
        self.homeViewPresenter?.setFeaturedList(movies: MBMoviesListDataManager.shared.featuredList)
        if error != nil {
            self.homeViewHelper?.showErrorMessage(error: error!)
        }
    }
    
    /**
     Notify movies list is received and updated.
     It tells to stop loader.
     It also tells to show error if any
     - Parameter error: Error
     */
    func moviesListUpdated(error: Error?) {
        self.homeViewHelper?.finishLoading()
        self.homeViewPresenter?.setMoviesList(movies: MBMoviesListDataManager.shared.moviesList)
        if error != nil {
            self.homeViewHelper?.showErrorMessage(error: error!)
        }
    }
}
