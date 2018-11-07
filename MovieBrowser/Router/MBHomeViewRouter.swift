//
//  MBHomeViewRouter.swift
//  MovieBrowser
//
//  Created by Shailendra Gangwar on 06/11/18.
//  Copyright © 2018 Shailendra Gangwar. All rights reserved.
//

import Foundation
import UIKit
/**
 ## MBHomeViewRouter responsible for:
 - Routing to details view controller
 - Attcahing presenter to home view
 */
class MBHomeViewRouter: MBRouterProtocol {

    /**
     Show detail screen for Movie.
     - Parameter movie: The movie being presented.
     - Parameter movieImage: The movie image being presented.
     - Parameter view: View controller from which detail are being pushed.
     */
    func pushToMovieDetailsWith(movie: MBMovie?, movieImage: UIImage?, view: UIViewController) {
        let storyBoard: UIStoryboard = MBAppStoryboard.Main.instance
        let movieDetailsViewController = storyBoard.instantiateViewController(withIdentifier: MBStringConstants.movieDetailsViewController) as? MBDetailsViewController
        movieDetailsViewController?.movieImage = movieImage
        movieDetailsViewController?.movie = movie
        view.navigationController?.pushViewController(movieDetailsViewController!, animated: true)
    }
    
    /**
     Atttach presenter to Home view.
     - Parameter homeView: Home view controller.
     */
    static func attachHomePresenter(homeView: MBHomeViewController) {
        let presenter = MBHomeViewPresenter()
        homeView.movieListPresenter = presenter
        homeView.movieListPresenter?.homeViewRouter = MBHomeViewRouter()
        homeView.movieListPresenter?.homeViewHelper = homeView
        homeView.movieListPresenter?.homeViewPresenter = homeView
    }
}
