//
//  MBHomeViewPresenter.swift
//  MovieBrowser
//
//  Created by Shailendra Gangwar on 05/11/18.
//  Copyright © 2018 Shailendra Gangwar. All rights reserved.
//

import Foundation
import UIKit

class MBHomeViewPresenter {
    
    var moviesListDataStore = MBMoviesListDataManager.shared
    weak var homeViewPresenter: MBHomeViewPresenterProtocol?
    weak var homeViewHelper: MBMovieHelperProtocol?
    var homeViewRouter: MBRouterProtocol?

    init() {
        self.moviesListDataStore.moviesListUpdateDelegate = self
    }

    func getMoviesForTableList() {
        self.homeViewHelper?.startLoading()
        MBMovieAPIService.shared.movieSearch(keyword: StringConstants.movieListTopic)
    }
    
    func getFeaturedMovies() {
        self.homeViewHelper?.startLoading()
        MBMovieAPIService.shared.featureMovieSearch(keyword: StringConstants.featuredListTopic)
    }
    
    func showDetailsfor(movie: MBMovie?, movieImage: UIImage?, initialView: UIViewController) {
        self.homeViewRouter?.pushToMovieDetailsWith(movie: movie, movieImage: movieImage, view: initialView)
    }
}

extension MBHomeViewPresenter: MBMoviesUpdateDelegate {
    func featuredListUpdated(error: Error?) {
        self.homeViewHelper?.finishLoading()
        self.homeViewPresenter?.setFeaturedList(movies: MBMoviesListDataManager.shared.featuredList)
        if error != nil {
            self.homeViewHelper?.showErrorMessage(error: error!)
        }
    }
    
    func moviesListUpdated(error: Error?) {
        self.homeViewHelper?.finishLoading()
        self.homeViewPresenter?.setMoviesList(movies: MBMoviesListDataManager.shared.moviesList)
        if error != nil {
            self.homeViewHelper?.showErrorMessage(error: error!)
        }
    }
}
