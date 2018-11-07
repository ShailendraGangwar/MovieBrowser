//
//  MBLoader.swift
//  MovieBrowser
//
//  Created by Shailendra Gangwar on 05/11/18.
//  Copyright © 2018 Shailendra Gangwar. All rights reserved.
//

import Foundation
import UIKit

/**
 ## MBLoader responsible for:
 - Showing overlay indicator
 - Hiding overlay indicator
 */
class MBLoader {
    
    /// Activity indicator to show something happening in background
    let activityIndicator = UIActivityIndicatorView()
    /// Overlay around activity indicator
    var overlayView = UIView()
    
    /**
     Shows activity indicator and overlay method.
     - Parameter view: View on which activity indicator is shown
     */
    func showOverlayOn(view: UIView) {
        self.overlayView.frame = CGRect(x: 0, y: 0, width: 80, height: 80)
        self.overlayView.center = view.center
        self.overlayView.backgroundColor = UIColor.darkGray
        self.overlayView.clipsToBounds = true
        self.overlayView.layer.cornerRadius = 10
        self.overlayView.tag = MBMathConstants.overlayViewTag
        self.activityIndicator.frame = CGRect(x: 0, y: 0, width: 40, height: 40)
        self.activityIndicator.activityIndicatorViewStyle = UIActivityIndicatorViewStyle.whiteLarge
        self.activityIndicator.center = CGPoint(x: overlayView.bounds.width / 2, y: overlayView.bounds.height / 2)
        self.overlayView.addSubview(activityIndicator)
        view.addSubview(overlayView)
        self.activityIndicator.startAnimating()
    }
    
    /**
     Hides activity indicator and overlay method.
     - Parameter view: View on which activity indicator is to be hide.
     */
    func hideOverlayView(view: UIView) {
        self.activityIndicator.stopAnimating()
        let subViews = view.subviews
        for subview in subViews {
            if subview.tag == MBMathConstants.overlayViewTag {
                subview.removeFromSuperview()
            }
        }
    }
}
