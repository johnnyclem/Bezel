//
//  Shape.swift
//  Bezel
//
//  Created by Bradley Johnson on 7/9/14.
//  Copyright (c) 2014 learnswift. All rights reserved.
//

import UIKit


class Shape {
    var previewImage : UIImage
    
    init(previewImage : UIImage) {
        self.previewImage = previewImage
    }
    
    init(shape : String, previewImage : UIImage) {
        self.previewImage = previewImage
    }
}