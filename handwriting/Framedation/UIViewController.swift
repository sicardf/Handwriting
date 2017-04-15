//
//  UIViewController.swift
//  handwriting
//
//  Created by Flavien SICARD on 14/04/2017.
//  Copyright © 2017 Flavien SICARD. All rights reserved.
//

import UIKit

extension UIViewController {
    
    func navigationBar(title: String? = "", rightButton: UIBarButtonItem? = nil) {
        self.navigationController?.navigationBar.topItem?.title = title
        self.navigationController?.navigationBar.titleTextAttributes = [NSForegroundColorAttributeName : UIColor.white]
        self.view.backgroundColor = UIColor.white
        self.navigationController?.navigationBar.barTintColor = UIColor(red: 0.094, green: 0.408, blue: 0.612, alpha: 1.00)
        self.navigationController?.navigationBar.tintColor = UIColor.white
        UIApplication.shared.statusBarStyle = .lightContent
        self.navigationController?.navigationBar.isTranslucent = false
        if rightButton != nil {
            self.navigationItem.rightBarButtonItem = rightButton
            self.navigationItem.rightBarButtonItem?.setTitleTextAttributes([NSForegroundColorAttributeName : UIColor.white], for: UIControlState())
        }
    }

    func setupIndicator() -> ActivityIndicator {
        let indicator = ActivityIndicator(frame: CGRect(x: 0, y: 0, width: 125, height: 125))
        indicator.center = CGPoint(x: self.view.frame.size.width / 2, y: self.view.frame.size.height / 2 - 30)
        indicator.animationDuration = 0.5
        indicator.rotationDuration = 5
        indicator.numSegments = 18
        indicator.lineWidth = 6
        indicator.stopAnimating()
        return indicator
    }
    
}


