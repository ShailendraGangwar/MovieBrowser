//
//  MBMovieDetailsPresenter.swift
//  MovieBrowser
//
//  Created by Shailendra Gangwar on 06/11/18.
//  Copyright © 2018 Shailendra Gangwar. All rights reserved.
//

import Foundation
/**
 - MBMoviesDetailViewPresenter is responsible for presenting data to Movie Details View Controller.
 - It interacts with MBMovieAPIService to get movie details.
 */
class MBMoviesDetailViewPresenter {
    
    // MARK: - Variables
    // MARK: -
    
    /// Movie detail view presenter protocol
    weak var movieDetailsPresenter: MBMovieDetailsPresenterProtocol?
    /// Movie detail view helper protocol
    weak var movieDetailsHelper: MBMovieHelperProtocol?
    
    // MARK: - Methods
    // MARK: -
    
    /**
     Get details of Movie.
     - Parameter movie: The movie for whih details are required.
     */
    func getDetailsForMovie(movie: MBMovie) {
        self.movieDetailsHelper?.startLoading()
        guard let encodedString = movie.title.addingPercentEncoding(withAllowedCharacters: .urlHostAllowed) else {
            self.movieDetailsHelper?.finishLoading()
            return
        }
        MBMovieAPIService.shared.getDetailsFor(movieTitle: encodedString) { (error, movie) in
            if let error = error {
                self.movieDetailsHelper?.showErrorMessage(error: error)
            } else if let movie = movie {
                self.movieDetailsPresenter?.setMovie(movie: movie)
                self.movieDetailsHelper?.finishLoading()
            }
        }
    }
    
}
