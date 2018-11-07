//
//  MBFeaturedListView.swift
//  MovieBrowser
//
//  Created by Shailendra Gangwar on 07/11/18.
//  Copyright © 2018 Shailendra Gangwar. All rights reserved.
//

import UIKit

class MBFeaturedListView: UIView {

    @IBOutlet var contentView: UIView!
    @IBOutlet weak var movieCollectionView: UICollectionView!
    @IBOutlet weak var pageControl: UIPageControl!
    var scrollingTimer = Timer()
    var featuredMoviesList = [MBMovie]() {
        didSet {
            DispatchQueue.main.async {
                self.movieCollectionView.reloadData()
                self.configurePageControl()
                self.setTimer()
            }
        }
    }
    private var currentVisibleMovie = 1
    var movieListPresenter : MBHomeViewPresenter?
    weak var movieListActionDelegate : MBFeaturedListActionProtocol?

    override init(frame: CGRect) {
        super.init(frame: frame)
        commonInit()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        commonInit()
    }
    
    private func commonInit() {
        Bundle.main.loadNibNamed("MBFeaturedListView", owner: self, options: nil)
        addSubview(contentView)
        contentView.frame = self.bounds
        contentView.autoresizingMask = [.flexibleHeight, .flexibleWidth]
        movieCollectionView.register(UINib(nibName: "MBMovieCollectionViewCell", bundle: nil), forCellWithReuseIdentifier: StringConstants.movieCollectionViewCell)
        self.movieCollectionView.delegate = self
        self.movieCollectionView.dataSource = self
    }
    
    private func configurePageControl() {
        self.pageControl.numberOfPages = self.featuredMoviesList.count
    }
    
    private func setTimer() {
        let _ = Timer.scheduledTimer(timeInterval: 2.0, target: self, selector: #selector(MBFeaturedListView.autoScroll), userInfo: nil, repeats: true)
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
// MARK: - UICollectionViewDataSource
// MARK: -
extension MBFeaturedListView: UICollectionViewDataSource {
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
                    cell.movieImageView.image = UIImage.init(named: StringConstants.notFoundIcon)
                }
                print("image processing error: \(error.localizedDescription)")
            }
        }
        cell.backgroundColor = UIColor.lightText
    }
}
// MARK: - UICollectionViewDelegate
// MARK: -
extension MBFeaturedListView: UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let currentCell = collectionView.cellForItem(at: indexPath) as! MBMovieCollectionViewCell
        self.movieListActionDelegate?.itemSelectedWith(movie: featuredMoviesList[indexPath.row], movieImage: currentCell.movieImageView?.image)
    }
}
// MARK: - UICollectionViewDelegateFlowLayout
// MARK: -
extension MBFeaturedListView: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: UIScreen.main.bounds.width, height: 188)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return UIEdgeInsets(top: 5, left: 15, bottom: 5, right: 15)
    }
}
