//
//  MBConstants.swift
//  MovieBrowser
//
//  Created by Shailendra Gangwar on 05/11/18.
//  Copyright © 2018 Shailendra Gangwar. All rights reserved.
//

import Foundation
import UIKit

/**
 MBStringConstants
 */
struct MBStringConstants {
    static let titleHomeView = "Movies"
    static let movieTableCell = "movieTableCell"
    static let backButtonTitle = "Movies"
    static let movieDetailsViewController = "MBDetailsViewController"
    static let movieCollectionViewCell = "movieCollectionViewCell"
    static let movieCollectionViewCellNib = "MBMovieCollectionViewCell"
    static let featuredListView = "MBFeaturedListView"
    static let ohh = "Ohh"
    static let ok = "OK"
    static let movieListTopic = "love"
    static let featuredListTopic = "war"
    static let notFoundIcon = "not_found_icon"
    static let movieReleaseYear = "Release year: "
    static let movieImdbId = "IMDB Id: "
}

/**
 MBUrls
 */
struct MBUrls {
    static let movieListURL = "http://www.omdbapi.com/?apikey=5335e485&s="
    static let titleSearchURL = "http://www.omdbapi.com/?apikey=5335e485&t="
    static let featuredURL = "http://www.omdbapi.com/?apikey=5335e485&y=2018&s="
}

/**
 MBAppStoryboard
 */
enum MBAppStoryboard: String {
    case Main = "Main"
    var instance: UIStoryboard {
        return UIStoryboard(name: self.rawValue, bundle: Bundle.main)
    }
}

/**
 MBMathConstants
 */
enum MBMathConstants {
    static let rowHeight: CGFloat  = 66
    static let overlayViewTag: Int = 2222
    static let itemHeight: CGFloat = 188
    static let timerScheduleInterval = 3.0
}

