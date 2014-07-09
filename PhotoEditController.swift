//
//  PhotoEditController.swift
//  Bezel
//
//  Created by Bradley Johnson on 7/9/14.
//  Copyright (c) 2014 learnswift. All rights reserved.
//

import Foundation
import UIKit

class PhotoEditController {
    
    var originalImage : UIImage
    var shape : Shape?
    var backgroundColor : UIColor?
    var backgroundImage : UIImage?
    
    init(image : UIImage) {
        self.originalImage = image
    }
    
    func imageWithBackgroundImage(backgroundImage : UIImage, shape : Shape) ->UIImage {
        return UIImage()
    }
    
    func imageWithBackgroundColor(backgroundColor : UIColor, shape : Shape) ->UIImage {
        return UIImage()
    }
    
    func imageWithShape(shape : Shape) ->UIImage {
        return UIImage()
    }
    
    
}
