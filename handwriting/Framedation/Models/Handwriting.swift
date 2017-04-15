//
//  Handwriting.swift
//  handwriting
//
//  Created by Flavien SICARD on 15/04/2017.
//  Copyright © 2017 Flavien SICARD. All rights reserved.
//

import UIKit

class HandwritingModels: NSObject {
    
    var handwriting_id: String!
    var handwriting_name: String!
    var handwriting_size: Float!
    var handwriting_color: String!
    var line_spacing: Float!
    var line_spacing_variance: Float!
    var word_spacing_variance: Float!
    var random_seed: Int!
    var text: String!
    
    override init() {
        self.handwriting_id = "2D5QW0F80001"
        self.handwriting_name = "Molly"
        self.handwriting_size = 20.0
        self.handwriting_color = "#000000"
        self.line_spacing = 1.5
        self.line_spacing_variance = 0.0
        self.word_spacing_variance = 0.0
        self.random_seed = -1
        super.init()
    }
    
    var params: [String: String] {
        get {
            return ["text": self.text,
                    "handwriting_id": self.handwriting_id!,
                    "handwriting_name": self.handwriting_name!,
                    "handwriting_size": "\(self.handwriting_size!)px",
                    "handwriting_color": self.handwriting_color!,
                    "line_spacing": "\(self.line_spacing!)",
                    "line_spacing_variance": "\(self.line_spacing_variance!)",
                    "word_spacing_variance": "\(self.word_spacing_variance!)",
                    "random_seed": "\(self.random_seed!)"]
        }
    }
    
}
