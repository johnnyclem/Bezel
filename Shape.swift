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
    var overlayImage : UIImage
    
    init(previewImage : UIImage) {
        self.previewImage = previewImage
        self.overlayImage = previewImage
    }
    
    init(overlayImage : UIImage, previewImage : UIImage) {
        self.previewImage = previewImage
        self.overlayImage = overlayImage
    }
}