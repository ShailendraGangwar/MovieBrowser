//
//  MBMovieDetailsPresenter.swift
//  MovieBrowser
//
//  Created by Shailendra Gangwar on 06/11/18.
//  Copyright © 2018 Shailendra Gangwar. All rights reserved.
//

import Foundation

class MBMoviesDetailViewPresenter {
    
    weak var movieDetailsPresenter: MBMovieDetailsPresenterProtocol?
    weak var movieDetailsHelper: MBMovieHelperProtocol?

    func getDetailsForMovie(movie: MBMovie) {
        self.movieDetailsHelper?.startLoading()
        guard let encodedString = movie.title.addingPercentEncoding(withAllowedCharacters: .urlHostAllowed) else {
            self.movieDetailsHelper?.finishLoading()
            return
        }
        MBMovieAPIService.shared.titleSearch(keyword: encodedString) { (error, movie) in
            if let error = error {
                self.movieDetailsHelper?.showErrorMessage(error: error)
            } else if let movie = movie {
                self.movieDetailsPresenter?.setMovie(movie: movie)
                self.movieDetailsHelper?.finishLoading()
            }
        }
    }
    
}
