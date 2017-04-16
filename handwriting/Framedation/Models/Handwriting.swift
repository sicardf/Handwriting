//
//  Handwriting.swift
//  handwriting
//
//  Created by Flavien SICARD on 15/04/2017.
//  Copyright © 2017 Flavien SICARD. All rights reserved.
//

import UIKit

class HandwritingModels: NSObject {
    
    private var _handwriting_text: String!
    private var _handwriting_id: String!
    private var _handwriting_name: String!
    private var _handwriting_size: Float!
    private var _handwriting_color: String!
    private var _line_spacing: Float!
    private var _line_spacing_variance: Float!
    private var _word_spacing_variance: Float!
    private var _random_seed: Int!
    
    override init() {
        self._handwriting_id = "2D5QW0F80001"
        self._handwriting_name = "Molly"
        self._handwriting_size = 20.0
        self._handwriting_color = "18689C"
        self._line_spacing = 1.5
        self._line_spacing_variance = 0.0
        self._word_spacing_variance = 0.0
        self._random_seed = -1
        super.init()
    }
    
    var handwriting_text: String! {
        get {
            return self._handwriting_text
        }
        set (newValue) {
            self._handwriting_text = newValue
        }
    }
    
    var handwriting_id: String! {
        get {
            return self._handwriting_id
        }
        set (newValue) {
            self._handwriting_id = newValue
        }
    }
    
    var handwriting_name: String! {
        get {
            return self._handwriting_name
        }
        set (newValue) {
            self._handwriting_name = newValue
        }
    }
    
    var handwriting_size: Float! {
        get {
            return self._handwriting_size
        }
        set (newValue) {
            if newValue >= 0.0 && newValue <= 9000.0 {
                self._handwriting_size = newValue
            }
        }
    }
    
    var handwriting_color: String! {
        get {
            return self._handwriting_color
        }
        set (newValue) {
            self._handwriting_color = newValue
        }
    }
    
    var line_spacing: Float! {
        get {
            return self._line_spacing
        }
        set (newValue) {
            if newValue >= 0.0 && newValue <= 5.0 {
                self._line_spacing = newValue
            }
        }
    }
    
    var line_spacing_variance: Float! {
        get {
            return self._line_spacing_variance
        }
        set (newValue) {
            if newValue >= 0.0 && newValue <= 1.0 {
                self._line_spacing_variance = newValue
            }
        }
    }
    
    var word_spacing_variance: Float! {
        get {
            return self._word_spacing_variance
        }
        set (newValue) {
            if newValue >= 0.0 && newValue <= 1.0 {
                self._word_spacing_variance = newValue
            }
        }
    }
    
    var random_seed: Int! {
        get {
            return self._random_seed
        }
        set (newValue) {
            self._random_seed = newValue
        }
    }
    
    var params: [String: String] {
        get {
            return ["text": self.handwriting_text,
                    "handwriting_id": self.handwriting_id!,
                    "handwriting_name": self.handwriting_name!,
                    "handwriting_size": "\(self._handwriting_size!)px",
                    "handwriting_color": self._handwriting_color!,
                    "line_spacing": "\(self._line_spacing!)",
                    "line_spacing_variance": "\(self._line_spacing_variance!)",
                    "word_spacing_variance": "\(self._word_spacing_variance!)",
                    "random_seed": "\(self._random_seed!)"]
        }
    }
    
}
