//
//  MBMovieProtocols.swift
//  MovieBrowser
//
//  Created by Shailendra Gangwar on 06/11/18.
//  Copyright © 2018 Shailendra Gangwar. All rights reserved.
//

import Foundation
import UIKit


protocol MBHomeViewPresenterProtocol: class {
    
    func setMoviesList(movies: [MBMovie])
    
    func setFeaturedList(movies: [MBMovie])
    
}

protocol MBMovieDetailsPresenterProtocol: class {
    
    func setMovie(movie: MBMovie)
    
}

protocol MBMovieHelperProtocol: class {
    
    func startLoading()
    
    func finishLoading()
    
    func showErrorMessage(error: Error)
}

protocol MBRouterProtocol: class {
    
    func pushToMovieDetailsWith(movie: MBMovie?, movieImage: UIImage?, view: UIViewController)

    static func attachHomePresenter(homeView: MBHomeViewController)

}

protocol MBFeaturedListActionProtocol: class {
    
    func itemSelectedWith(movie: MBMovie?, movieImage: UIImage?)
    
}
