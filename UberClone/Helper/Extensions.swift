//
//  Extensions.swift
//  UberClone
//
//  Created by José Vitor Scheffer Boff dos Santos on 27/01/23.
//

import UIKit
import Foundation

extension UIView {
    
    func addLoading() {
        let blurEffect = UIBlurEffect(style: .prominent)
        let blurEffectView = UIVisualEffectView(effect: blurEffect)
        
        blurEffectView.frame = self.bounds
        blurEffectView.tag = 101
        
        self.addSubview(blurEffectView)
        
        let activityIndicator = UIActivityIndicatorView()
        if #available(iOS 13.0, *) {
            activityIndicator.style = .large
        } else {
            activityIndicator.style = .whiteLarge
        }
        
        activityIndicator.frame = self.bounds
        activityIndicator.tag = 202
        activityIndicator.startAnimating()
        
        self.addSubview(activityIndicator)
    }
    
    func removeLoading() {
        self.subviews.forEach { view in
            if view.tag == 101 || view.tag == 202 {
                view.removeFromSuperview()
            }
        }
    }
}
