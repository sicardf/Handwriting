//
//  GenerateView.swift
//  handwriting
//
//  Created by Flavien SICARD on 14/04/2017.
//  Copyright © 2017 Flavien SICARD. All rights reserved.
//

import UIKit

protocol GenerateDelegate {
    func didPressSettingsButton(button:UIButton)
    func didPressGenerateButton(button:UIButton)
}

class GenerateView: UIView {

    @IBOutlet var view: UIView!
    @IBOutlet weak var settingsButton: UIButton!
    @IBOutlet weak var generateButton: UIButton!
    @IBOutlet weak var textView: UITextView!
    @IBOutlet weak var imageView: UIImageView!
    
    var delegate: GenerateDelegate!

    override init(frame: CGRect) {
        super.init(frame: frame)
        self.setup()
    }

    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        self.setup()
    }
    
    /// Setup View and add target in settings and geneerate button
    func setup() {
        UINib(nibName: "GenerateView", bundle: nil).instantiate(withOwner: self, options: nil)
        self.addSubview(view)
        self.view.frame = self.bounds
        self.settingsButton.addTarget(self, action: #selector(GenerateView.settingsButtonPress), for: .touchUpInside)
        self.generateButton.addTarget(self, action: #selector(GenerateView.generateButtonPress), for: .touchUpInside)
    }
    
    /// Delegate action press button generate with protocol GenerateDelegate : GeerateView
    func generateButtonPress(button:UIButton) {
        delegate.didPressGenerateButton(button: button)
    }
    
    /// Delegate action press button settings with protocol GenerateDelegate : GenerateView
    func settingsButtonPress(button:UIButton) {
        delegate.didPressSettingsButton(button: button)
    }
    
    @IBInspectable
    var text:String? {
        get {
            return self.textView.text
        }
        set(string) {
            self.textView.text = string
        }
    }
    
    @IBInspectable
    var image:UIImage? {
        get {
            return self.imageView.image
        }
        set(image) {
            self.imageView.image = image
        }
    }
    
}
