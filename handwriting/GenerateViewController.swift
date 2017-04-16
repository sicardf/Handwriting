//
//  ViewController.swift
//  handwriting
//
//  Created by Flavien SICARD on 13/04/2017.
//  Copyright © 2017 Flavien SICARD. All rights reserved.
//

import UIKit
import Alamofire
import SwiftyJSON


class ViewController: UIViewController, GenerateDelegate, SettingsDelegate {
    
    private var indicatorView: ActivityIndicator! = nil
    private var generateView: GenerateView! = nil
    private var handwritingModels: HandwritingModels! = nil
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.navigationBar(title: "Handwriting")
        self.setup()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    /// Setup GenerateView, indicatorView and HandwritingModels
    private func setup() {
        self.handwritingModels = HandwritingModels()
        
        self.generateView = GenerateView(frame: CGRect(x: 0, y: 0, width: self.view.frame.size.width, height: self.view.frame.size.height - 66))
        self.generateView.delegate = self
        self.view.addSubview(self.generateView)
        
        self.indicatorView = setupIndicator()
        self.view.addSubview(self.indicatorView)
    }
    
    /// Send request with all parameters in model and display image in view
    func generateImage() {
        self.indicatorView.startAnimating()
        handwritingModels.handwriting_text = self.generateView.text!
        API().req(.getRenderPNG, params: handwritingModels.params) { (bool, data) in
            self.indicatorView.stopAnimating()
            switch bool {
            case true:
                let image = UIImage(data: data!)
                self.generateView.image = image
            case false:
                let json = JSON(data!)
                self.alertError(message:json["errors"][0]["error"].string ?? "Request error - Cannot get image")
            }
        }
    }
    
    /// Get AlertController with message error
    func alertError(message: String) {
        let alert = UIAlertController(title: "Error", message: message, preferredStyle: UIAlertControllerStyle.alert)
        alert.addAction(UIAlertAction(title: "OK", style: UIAlertActionStyle.default, handler: nil))
        self.present(alert, animated: true, completion: nil)
    }
    
    /// MARK: Generate
    func didPressGenerateButton(button:UIButton) {
        self.view.endEditing(true)
        self.generateImage()
    }
    
    func didPressSettingsButton(button: UIButton) {
        let viewController = SettingsViewController()
        viewController.delegate = self
        viewController.handwritingModels = self.handwritingModels
        self.present(UINavigationController(rootViewController: viewController), animated: true, completion: nil)
    }
    
    /// MARK: font
    func handwritingModels(handwritingModels: HandwritingModels) {
        self.handwritingModels = handwritingModels
    }
    
}

