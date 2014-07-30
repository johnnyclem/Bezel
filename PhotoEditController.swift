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
    
    func imageWithBackgroundImage(backgroundImage : UIImage, shape : Shape) -> UIImage? {
        return nil
    }
    
    func imageWithBackgroundColor(backgroundColor : UIColor, shape : Shape) -> UIImage? {
        let context = CIContext(options: nil)
        
        let background = CIImage(image: originalImage)
        let overlay = CIImage(image: shape.previewImage)
        
        
        if let compositedImage = overlay.imageByCompositingOverImage(background) {
            return UIImage(CIImage: compositedImage)
        }
        return nil
    }
    
    func imageWithShape(shape : Shape) -> UIImage? {
        if let compositedImage = self.imageWithBackgroundColor(UIColor.blackColor(), shape: shape) {
            return compositedImage
        }
        
        return nil
    }
    
}
