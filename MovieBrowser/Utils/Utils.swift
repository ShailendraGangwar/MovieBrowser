//
//  Utils.swift
//  MovieBrowser
//
//  Created by Shailendra Gangwar on 06/11/18.
//  Copyright © 2018 Shailendra Gangwar. All rights reserved.
//

import Foundation
import UIKit

class Utils {
    
    static func showErrorMessage(error: Error) {
        DispatchQueue.main.async {
            guard let viewController = UIApplication.shared.keyWindow?.rootViewController else {
                return
            }
            let alert = UIAlertController(title: StringConstants.ohh, message: error.localizedDescription, preferredStyle: UIAlertControllerStyle.alert)
            alert.addAction(UIAlertAction(title: StringConstants.ok, style: .default, handler: { action in
                switch action.style{
                case .default:
                    print("default")
                case .cancel:
                    print("cancel")
                    
                case .destructive:
                    print("destructive")
                    
                }}))
            viewController.present(alert, animated: true, completion: nil)
        }
    }
}
