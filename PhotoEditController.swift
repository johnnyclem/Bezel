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
    var backgroundImage : UIImage?
    
    init(image : UIImage) {
        self.originalImage = image
    }
    
    func imageWithBackgroundImage(backgroundImage : UIImage, andShape shape : Shape) -> UIImage {
        self.backgroundImage = backgroundImage
        
        var context = CIContext(options: nil)
        let compositeFilter = CIFilter(name: "CIBlendWithAlphaMask")
        compositeFilter.setValue(originalImage, forKey: kCIInputImageKey)
        compositeFilter.setValue(shape.overlayImage, forKey: kCIInputMaskImageKey)
        compositeFilter.setValue(backgroundImage, forKey: kCIInputBackgroundImageKey)
        
        var compositeImage = compositeFilter.outputImage
        context.createCGImage(compositeImage, fromRect: CGRect(x: 0, y: 0, width: 640, height: 640))
        
        return UIImage(CIImage: compositeImage)
    }

    func imageWithBackgroundColor(backgroundColor : UIColor, andShape shape : Shape) -> UIImage {
        var colorImage = UIImage(color: backgroundColor)
        
        var context = CIContext(options: nil)
        
        let compositeFilter = CIFilter(name: "CIBlendWithAlphaMask")
        compositeFilter.setValue(originalImage, forKey: kCIInputImageKey)
        compositeFilter.setValue(shape.overlayImage, forKey: kCIInputMaskImageKey)
        compositeFilter.setValue(colorImage, forKey: kCIInputBackgroundImageKey)
        
        var compositeImage = compositeFilter.outputImage
        context.createCGImage(compositeImage, fromRect: CGRect(x: 0, y: 0, width: 640, height: 640))
        
        return UIImage(CIImage: compositeImage)
    }
        
}
