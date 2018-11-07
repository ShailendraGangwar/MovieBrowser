//
//  MBMovieDetailsViewController.swift
//  MovieBrowser
//
//  Created by Shailendra Gangwar on 05/11/18.
//  Copyright © 2018 Shailendra Gangwar. All rights reserved.
//

import UIKit

class MBDetailsViewController: UIViewController {
    
    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var movieDescription: UILabel!
    fileprivate let movieDetailsPresenter = MBMoviesDetailViewPresenter()

    var movie: MBMovie!
    var movieImage: UIImage!
    var currentIMDDId: String = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.movieDetailsPresenter.movieDetailsHelper = self as MBMovieHelperProtocol
        self.movieDetailsPresenter.movieDetailsPresenter = self as MBMovieDetailsPresenterProtocol

        if let _ = movie {
            self.movieDetailsPresenter.getDetailsForMovie(movie: movie)
        }
        configureView(movie: movie)
        self.setUpNavBar()
    }
    
    func setUpNavBar(){
        self.navigationController?.view.backgroundColor = UIColor.white
        self.navigationController?.view.tintColor = UIColor.black
        self.navigationItem.title = movie?.title
        let backButton = UIBarButtonItem()
        backButton.title = "Movies"
        self.navigationController?.navigationBar.topItem?.backBarButtonItem = backButton
    }

    func fetchMovieDetails() {
        self.movieDetailsPresenter.getDetailsForMovie(movie: self.movie)
    }
    
    func configureView(movie: MBMovie?) {
        if let movieImage = self.movieImage {
            DispatchQueue.main.async {
                self.imageView.image = movieImage
            }
        } else {
            DispatchQueue.global().async {
                do {
                    let imageData = try Data.init(contentsOf: (movie?.poster)!)
                    DispatchQueue.main.async {
                        self.imageView.image = UIImage.init(data: imageData)
                    }
                } catch {
                    DispatchQueue.main.async {
                        self.imageView.image = UIImage.init(named: StringConstants.notFoundIcon)
                    }
                    print("image processing error: \(error.localizedDescription)")
                }
            }
        }
        if let movie = movie {
            currentIMDDId = movie.imdbId
            DispatchQueue.main.async {
                self.movieDescription.text = movie.plot ?? ""
                self.movie.plot = movie.plot
            }
        }
    }
    
    private func hideLoader() {
        MBLoader().hideOverlayView(view: self.view)
    }

    private func showLoader() {
        MBLoader().showOverlayOn(view: self.view)
    }
}

// MARK: - MBHomeViewPresenterProtocol
// MARK: -
extension MBDetailsViewController: MBMovieDetailsPresenterProtocol {
    func setMovie(movie: MBMovie) {
        self.configureView(movie: movie)
    }
    
    func showErrorMessage(error: Error) {
        Utils.showErrorMessage(error: error)
    }
}

// MARK: - MBMovieHelperProtocol
// MARK: -
extension MBDetailsViewController: MBMovieHelperProtocol {
    func startLoading() {
        DispatchQueue.main.async {
            self.showLoader()
        }
    }
    
    func finishLoading() {
        DispatchQueue.main.async {
            self.hideLoader()
        }
    }
}
