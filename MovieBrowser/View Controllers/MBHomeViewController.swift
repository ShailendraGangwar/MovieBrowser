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
    
    @IBOutlet weak var movieCollectionView: UICollectionView!
    @IBOutlet weak var movieListTableView: UITableView!
    @IBOutlet weak var pageControl: UIPageControl!
    
    // MARK: - Variables
    // MARK: -
    
    var movieListPresenter : MBHomeViewPresenter?
    var scrollingTimer = Timer()
    private var moviesList = [MBMovie]() {
        didSet {
            DispatchQueue.main.async {
                self.movieListTableView.reloadData()
            }
        }
    }
    private var featuredMoviesList = [MBMovie]() {
        didSet {
            DispatchQueue.main.async {
                self.movieCollectionView.reloadData()
                self.configurePageControl()
                self.setTimer()
            }
        }
    }
    
    private var currentVisibleMovie = 1
    
    // MARK: - Life cycle methods
    // MARK: -
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = StringConstants.titleHomeView
        MBHomeViewRouter.attachHomePresenter(homeView: self)
        self.movieListTableView.delegate = self
        self.movieListTableView.dataSource = self
        self.movieListPresenter?.getMoviesForTableList()
        self.movieCollectionView.delegate = self
        self.movieCollectionView.dataSource = self
        self.movieListPresenter?.getFeaturedMovies()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    // MARK: - Custom mehtods
    // MARK: -
    
    private func configurePageControl() {
        self.pageControl.numberOfPages = self.featuredMoviesList.count
    }
    
    private func hideLoader() {
        MBLoader().hideOverlayView(view: self.view)
    }
    
    private func showLoader() {
        MBLoader().showOverlayOn(view: self.view)
    }
    
    private func setTimer() {
        let _ = Timer.scheduledTimer(timeInterval: 2.0, target: self, selector: #selector(MBHomeViewController.autoScroll), userInfo: nil, repeats: true)
    }
    
    @objc private func autoScroll() {
        self.pageControl.currentPage = currentVisibleMovie
        if self.currentVisibleMovie < self.featuredMoviesList.count {
            let indexPath = IndexPath(item: currentVisibleMovie, section: 0)
            self.movieCollectionView.scrollToItem(at: indexPath, at: .centeredHorizontally, animated: true)
            self.currentVisibleMovie = self.currentVisibleMovie + 1
        } else {
            self.currentVisibleMovie = 0
            self.movieCollectionView.scrollToItem(at: IndexPath(item: 0, section: 0), at: .centeredHorizontally, animated: true)
        }
    }
    
}

// MARK: - UITableViewDataSource
// MARK: -

extension MBHomeViewController: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return moviesList.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: StringConstants.movieTableCell, for: indexPath) as! MBMovieTableCell
        let movie = moviesList[indexPath.row]
        cell.selectionStyle = .none
        configureMovie(movie: movie, forCell: cell)
        return cell
    }
    
    func configureMovie(movie: MBMovie, forCell cell: MBMovieTableCell) {
        DispatchQueue.global().async {
            do {
                let imageData = try Data.init(contentsOf: movie.poster)
                DispatchQueue.main.async {
                    cell.movieImageView.image = UIImage.init(data: imageData)
                    cell.movieTitle.text = movie.title
                }
            } catch {
                DispatchQueue.main.async {
                    cell.movieImageView.image = UIImage.init(named: "error_icon")
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
        return 66
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let currentCell = tableView.cellForRow(at: indexPath) as! MBMovieTableCell
        self.movieListPresenter?.showDetailsfor(
            movie: moviesList[indexPath.row],
            movieImage: currentCell.imageView?.image,
            initialView: self)
    }
}

// MARK: - UICollectionViewDataSource
// MARK: -

extension MBHomeViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let collectionViewCell = collectionView.dequeueReusableCell(withReuseIdentifier: StringConstants.movieCollectionViewCell, for: indexPath) as! MBMovieCollectionViewCell
        let movie = featuredMoviesList[indexPath.row]
        configureFeaturedMovie(movie: movie, forCell: collectionViewCell)
        return collectionViewCell
    }
    
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return featuredMoviesList.count
    }
    
    
    func configureFeaturedMovie(movie: MBMovie, forCell cell: MBMovieCollectionViewCell) {
        DispatchQueue.global().async {
            do {
                let imageData = try Data.init(contentsOf: movie.poster)
                DispatchQueue.main.async {
                    cell.movieImageView.image = UIImage.init(data: imageData)
                }
            } catch {
                DispatchQueue.main.async {
                    cell.movieImageView.image = UIImage.init(named: "error_icon")
                }
                print("image processing error: \(error.localizedDescription)")
            }
        }
        cell.backgroundColor = UIColor.lightText
        
    }
    
}

// MARK: - UICollectionViewDelegate
// MARK: -

extension MBHomeViewController: UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let currentCell = collectionView.cellForItem(at: indexPath) as! MBMovieCollectionViewCell
        self.movieListPresenter?.showDetailsfor(
            movie: featuredMoviesList[indexPath.row],
            movieImage: currentCell.movieImageView?.image,
            initialView: self)
    }
}

// MARK: - UICollectionViewDelegateFlowLayout
// MARK: -

extension MBHomeViewController: UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: UIScreen.main.bounds.width * 0.90, height: 240)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return UIEdgeInsets(top: 5, left: 15, bottom: 5, right: 15)
    }
}

// MARK: - MBHomeViewPresenterProtocol
// MARK: -

extension MBHomeViewController: MBHomeViewPresenterProtocol {
    func setFeaturedList(movies: [MBMovie]) {
        self.featuredMoviesList = movies
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

