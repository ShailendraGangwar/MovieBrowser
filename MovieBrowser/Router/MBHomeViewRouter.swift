//
//  MBHomeViewRouter.swift
//  MovieBrowser
//
//  Created by Shailendra Gangwar on 06/11/18.
//  Copyright © 2018 Shailendra Gangwar. All rights reserved.
//

import Foundation
import UIKit

class MBHomeViewRouter: MBRouterProtocol {

    func pushToMovieDetailsWith(movie: MBMovie?, movieImage: UIImage?, view: UIViewController) {
        let storyBoard: UIStoryboard = MBAppStoryboard.Main.instance
        let movieDetailsViewController = storyBoard.instantiateViewController(withIdentifier: StringConstants.movieDetailsViewController) as? MBDetailsViewController
        movieDetailsViewController?.movieImage = movieImage
        movieDetailsViewController?.movie = movie
        view.navigationController?.pushViewController(movieDetailsViewController!, animated: true)
    }
    
    static func attachHomePresenter(homeView: MBHomeViewController) {
        let presenter = MBHomeViewPresenter()
        homeView.movieListPresenter = presenter
        homeView.movieListPresenter?.homeViewRouter = MBHomeViewRouter()
        homeView.movieListPresenter?.homeViewHelper = homeView
        homeView.movieListPresenter?.homeViewPresenter = homeView
    }

}
