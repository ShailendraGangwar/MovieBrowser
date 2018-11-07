//
//  MBHomeViewController.swift
//  MovieBrowser
//
//  Created by Shailendra Gangwar on 05/11/18.
//  Copyright © 2018 Shailendra Gangwar. All rights reserved.
//

import UIKit

class MBHomeViewController: UIViewController {
    
    // MARK: - IBOutlets
    // MARK: -
    
    /// Movie list table view
    @IBOutlet weak var movieListTableView: UITableView!
    /// Featured list view
    @IBOutlet weak var featuredListView: MBFeaturedListView!
    
    // MARK: - Variables
    // MARK: -
    
    /// Movie list presenter
    var movieListPresenter : MBHomeViewPresenter?
    /// Movies list
    private var moviesList = [MBMovie]() {
        didSet {
            DispatchQueue.main.async {
                self.movieListTableView.reloadData()
            }
        }
    }
    
    // MARK: - Life cycle methods
    // MARK: -
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // View title
        self.title = MBStringConstants.titleHomeView
        // Attaching presenter
        MBHomeViewRouter.attachHomePresenter(homeView: self)
        // Tableview datasource and delegate
        self.movieListTableView.delegate = self
        self.movieListTableView.dataSource = self
        // Fetrch movies list
        self.movieListPresenter?.getMoviesForTableList()
        self.movieListPresenter?.getFeaturedMovies()
        // Setting delegate for selectionon featured movie.
        self.featuredListView.movieListActionDelegate = self
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    // MARK: - Custom mehtods
    // MARK: -
    
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

// MARK: - UITableViewDataSource
// MARK: -

extension MBHomeViewController: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return moviesList.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: MBStringConstants.movieTableCell, for: indexPath) as! MBMovieTableCell
        let movie = moviesList[indexPath.row]
        // configure cell
        configureMovie(movie: movie, forCell: cell)
        return cell
    }
    
    /**
     Configure Movie list cell
     - Parameter movie: movie
     - Parameter cell: table view cell
     */
    func configureMovie(movie: MBMovie, forCell cell: MBMovieTableCell) {
        cell.selectionStyle = .none
        DispatchQueue.global().async {
            do {
                let imageData = try Data.init(contentsOf: movie.poster)
                DispatchQueue.main.async {
                    cell.movieImageView.image = UIImage.init(data: imageData)
                    cell.movieTitle.text = movie.title
                }
            } catch {
                DispatchQueue.main.async {
                    cell.movieImageView.image = UIImage.init(named: MBStringConstants.notFoundIcon)
                }
                print("image processing error: \(error.localizedDescription)")
            }
        }
    }
}

// MARK: - UITableViewDelegate
// MARK: -

extension MBHomeViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return MBMathConstants.rowHeight
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let currentCell = tableView.cellForRow(at: indexPath) as! MBMovieTableCell
        // show details for the movie
        self.movieListPresenter?.showDetailsfor(
            movie: moviesList[indexPath.row],
            movieImage: currentCell.imageView?.image,
            initialView: self)
    }
}

// MARK: - MBHomeViewPresenterProtocol
// MARK: -

extension MBHomeViewController: MBHomeViewPresenterProtocol {
    func setFeaturedList(movies: [MBMovie]) {
        self.featuredListView.featuredMoviesList = movies
    }
    
    func setMoviesList(movies: [MBMovie]) {
        self.moviesList = movies
    }
    
    func showErrorMessage(error: Error) {
        Utils.showErrorMessage(error: error)
    }
}

// MARK: - MBMovieHelperProtocol
// MARK: -

extension MBHomeViewController: MBMovieHelperProtocol {
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

// MARK: - MBFeaturedListActionProtocol
// MARK: -

extension MBHomeViewController: MBFeaturedListActionProtocol {
    func itemSelectedWith(movie: MBMovie?, movieImage: UIImage?) {
        // show details for the movie
        self.movieListPresenter?.showDetailsfor(
            movie: movie,
            movieImage: movieImage,
            initialView: self)
    }
}
