//
//  MBMovieDetailsViewController.swift
//  MovieBrowser
//
//  Created by Shailendra Gangwar on 05/11/18.
//  Copyright © 2018 Shailendra Gangwar. All rights reserved.
//

import UIKit

class MBDetailsViewController: UIViewController {
    
    // MARK: - IBOutlets
    // MARK: -
    
    /// Image view
    @IBOutlet weak var imageView: UIImageView!
    /// Movie description label
    @IBOutlet weak var movieDescription: UILabel!
    /// Movie Imdb Id
    @IBOutlet weak var movieImdbId: UILabel!
    /// Movie release year
    @IBOutlet weak var movieReleaseYear: UILabel!
    // MARK: - Variables
    // MARK: -
    
    /// Movie details presenter
    private let movieDetailsPresenter = MBMoviesDetailViewPresenter()
    /// Current movie
    var movie: MBMovie!
    /// Movie image
    var movieImage: UIImage!
    
    // MARK: - Life cycle methods
    //
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.movieDetailsPresenter.movieDetailsHelper = self
        self.movieDetailsPresenter.movieDetailsPresenter = self
        if let _ = movie {
            self.movieDetailsPresenter.getDetailsForMovie(movie: movie)
        }
        self.setUpNavigationBar()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    // MARK: - Custom mehtods
    // MARK: -
    
    /**
     Setting navigation bar
     */
    private func setUpNavigationBar(){
        self.navigationController?.view.backgroundColor = UIColor.white
        self.navigationController?.view.tintColor = UIColor.black
        self.navigationItem.title = movie?.title
        let backButton = UIBarButtonItem()
        backButton.title = MBStringConstants.backButtonTitle
        self.navigationController?.navigationBar.topItem?.backBarButtonItem = backButton
    }

    /**
     Fetch Movie details
     */
    private func fetchMovieDetails() {
        self.movieDetailsPresenter.getDetailsForMovie(movie: self.movie)
    }
    
    /**
     Configure View with movie details
     - Parameter movie: movie
     */
    private func configureView(movie: MBMovie?) {
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
                        self.imageView.image = UIImage.init(named: MBStringConstants.notFoundIcon)
                    }
                    print("image processing error: \(error.localizedDescription)")
                }
            }
        }
        if let movie = movie {
            DispatchQueue.main.async {
                self.movieDescription.text = movie.plot ?? ""
                self.movie.plot = movie.plot
                self.movieImdbId.text = "IMDB Id: \(movie.imdbId)"
                self.movieReleaseYear.text = "Release year: \(movie.year)"
            }
        }
    }
    
    /**
     Hide Loader
     */
    private func hideLoader() {
        MBLoader().hideOverlayView(view: self.view)
    }
    
    /**
     Show Loader
     */
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
