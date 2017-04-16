//
//  ParamsViewController.swift
//  handwriting
//
//  Created by Flavien SICARD on 14/04/2017.
//  Copyright © 2017 Flavien SICARD. All rights reserved.
//

import UIKit
import SwiftyJSON
import Eureka


protocol SettingsDelegate {
    func handwritingModels(handwritingModels: HandwritingModels)
}

class SettingsViewController: FormViewController {
    
    public var delegate: SettingsDelegate?
    public var handwritingModels: HandwritingModels! = nil
    private var json: JSON! = nil
    private var indicatorView: ActivityIndicator! = nil
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.navigationBar(title: "Settings",
                           rightButton: UIBarButtonItem(title: "OK", style: UIBarButtonItemStyle.plain, target: self, action: #selector(SettingsViewController.done)))
        self.setup()
    }
    
    /// Setup Eureka Table, Indicateur view and get list of typefaces
    func setup() {
        self.form +++ Section("")
            <<< PushRow<String>() {
                $0.title = "Font"
                $0.tag = $0.title
                $0.selectorTitle = "Choose an font"
                $0.value = handwritingModels.handwriting_name
            }
            <<< AccountRow() {
                $0.title = "handwriting_color"
                $0.tag = $0.title
                $0.placeholder = "#000000"
                $0.value = handwritingModels.handwriting_color
                
            }
            <<< SliderRow() {
                $0.title = "handwriting_size"
                $0.tag = $0.title
                $0.minimumValue = 0.0
                $0.maximumValue = 100
                $0.steps = 100
                $0.value = handwritingModels.handwriting_size
            }
            <<< SliderRow() {
                $0.title = "line_spacing"
                $0.tag = $0.title
                $0.minimumValue = 0.0
                $0.maximumValue = 5.0
                $0.steps = 50
                $0.value = handwritingModels.line_spacing
            }
            <<< SliderRow() {
                $0.title = "line_spacing_variance"
                $0.tag = $0.title
                $0.minimumValue = 0.0
                $0.maximumValue = 1.0
                $0.steps = 20
                $0.value = handwritingModels.line_spacing_variance
            }
            <<< SliderRow() {
                $0.title = "word_spacing_variance"
                $0.tag = $0.title
                $0.minimumValue = 0.0
                $0.maximumValue = 1.0
                $0.steps = 20
                $0.value = handwritingModels.word_spacing_variance
            }
            <<< SliderRow() {
                $0.title = "random_seed"
                $0.tag = $0.title
                $0.minimumValue = -100.0
                $0.maximumValue = 100.0
                $0.steps = 200
                $0.value = Float(handwritingModels.random_seed)
            }
        self.indicatorView = setupIndicator()
        self.view.addSubview(self.indicatorView)
        self.listFont()
    }
    
    /// Send request of get list of typefaces
    func listFont() {
        self.indicatorView.startAnimating()
        API().req(.getHandwritings) { (bool, json) in
            self.indicatorView.stopAnimating()
            switch bool {
            case true:
                self.json = JSON(json!)
                var tab: [String] = []
                for i in self.json {
                    tab.append(i.1["title"].string!)
                }
                (self.form.rowBy(tag: "Font") as! PushRow).options = tab
                self.form.rowBy(tag: "Font")?.updateCell()
            case false:
                self.alertError(message: "Request error - Cannot get fonts")
            }
        }
    }
    
    /// Save all parameters in models and dismiss view
    func done() {
        self.handwritingModels.handwriting_size = self.form.values(includeHidden: true)["handwriting_size"] as? Float
        self.handwritingModels.handwriting_color = self.form.values(includeHidden: true)["handwriting_color"] as? String
        self.handwritingModels.line_spacing = self.form.values(includeHidden: true)["line_spacing"] as? Float
        self.handwritingModels.line_spacing_variance = self.form.values(includeHidden: true)["line_spacing_variance"] as? Float
        self.handwritingModels.word_spacing_variance = self.form.values(includeHidden: true)["word_spacing_variance"] as? Float
        self.handwritingModels.random_seed = Int((self.form.values(includeHidden: true)["random_seed"] as? Float)!)
        if self.json != nil {
            for places in self.json {
                if places.1["title"].string == self.form.values(includeHidden: true)["Font"] as? String {
                    self.handwritingModels.handwriting_id = places.1["id"].string
                    self.handwritingModels.handwriting_name = places.1["title"].string //: String?
                }
            }
        }
        self.delegate?.handwritingModels(handwritingModels: self.handwritingModels)
        self.dismiss(animated: true, completion: nil)
    }
    
    /// Get AlertController with message error
    func alertError(message: String) {
        let alert = UIAlertController(title: "Error", message: message, preferredStyle: UIAlertControllerStyle.alert)
        alert.addAction(UIAlertAction(title: "OK", style: UIAlertActionStyle.default, handler: nil))
        self.present(alert, animated: true, completion: nil)
    }
}

