//
//  MBConstants.swift
//  MovieBrowser
//
//  Created by Shailendra Gangwar on 05/11/18.
//  Copyright © 2018 Shailendra Gangwar. All rights reserved.
//

import Foundation
import UIKit

enum MBAppStoryboard: String {
    case Main = "Main"
    var instance: UIStoryboard {
        return UIStoryboard(name: self.rawValue, bundle: Bundle.main)
    }
}

enum MathConstants {
    static let rowHeight: CGFloat  = 66
    static let overlayViewTag: Int = 2222
}

struct StringConstants {
    static let titleHomeView = "Movies"
    static let storyboardName = "Main"
    static let movieTableCell = "movieTableCell"
    static let backButtonTitle = "Movies"
    static let movieDetailsViewController = "MBDetailsViewController"
    static let movieCollectionViewCell = "movieCollectionViewCell"
    static let ohh = "Ohh"
    static let ok = "OK"
    static let movieListTopic = "love"
    static let featuredListTopic = "war"
    static let notFoundIcon = "not_found_icon"
}
