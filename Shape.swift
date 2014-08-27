//
//  Shape.swift
//  Bezel
//
//  Created by Bradley Johnson on 7/9/14.
//  Copyright (c) 2014 learnswift. All rights reserved.
//

import UIKit


class Shape {

    var shapeName : String!
    var overlayImageName : String!
    var previewImageName : String!

    var previewImage : UIImage!
    var overlayImage : UIImage!
    
    var originalImage : UIImage?
    var backgroundImage : UIImage?

    var fillColor = UIColor.blackColor()
    var overlaySize = CGSize(width: 640, height: 640)
    let previewSize = CGSize(width: 120, height: 120)
    
    init(color : UIColor, size : CGSize, info : Dictionary<String, String>) {
        self.fillColor = color
        
        if let newShapeName : String = info["shapeName"] {
            self.shapeName = newShapeName
        }
        if let previewImageName : String = info["previewImage"] {
            self.previewImageName = previewImageName
            self.previewImage = UIImage(named: previewImageName)
        }
        if let overlayImageName : String = info["overlayImage"] {
            self.overlayImageName = overlayImageName
            self.overlayImage = UIImage(SVGNamed: self.overlayImageName, targetSize: self.overlaySize, fillColor: self.fillColor)
        }
    }
    
    func updatePreviewColor(color : UIColor ) {
        self.fillColor = color
        self.previewImage = UIImage(SVGNamed: self.overlayImageName, targetSize: CGSize(width: 120, height: 120), fillColor: color, cache: false)
    }
    
    func setFillColor(color : UIColor) {
        self.fillColor = color
        self.overlayImage = UIImage(SVGNamed: self.overlayImageName, targetSize: self.overlaySize, fillColor: self.fillColor, cache: false)
    }
    
    func maskedOutputForImage(originalImage: UIImage) -> UIImage {
        
        let longerSide = max(originalImage.size.height, originalImage.size.height)
        let targetSize = CGSize(width: longerSide, height: longerSide)
        let imageMask = UIImage(SVGNamed: overlayImageName, targetSize: targetSize, fillColor: self.fillColor)
        let maskedImage = Toucan(image: originalImage).resize(targetSize, fitMode: .Crop).maskWithImage(maskImage: imageMask)
        return maskedImage.image
    }
    
    func imageWithBackground(backgroundImage: UIImage?, backgroundColor: UIColor?, originalImage: UIImage) -> UIImage? {
        
        var imageMask : UIImage!
        
        if backgroundImage == nil && backgroundColor != nil {
            // apply color background
            imageMask = UIImage( SVGNamed: overlayImageName, targetSize: originalImage.size, fillColor: backgroundColor!)
        } else if backgroundImage != nil {
            // apply image background
            var fillPattern = UIColor(patternImage: backgroundImage!)
            imageMask = UIImage(SVGNamed: overlayImageName, targetSize: originalImage.size, fillColor: fillPattern)
        } else {
            // no background color or image, so just return the original
            println("You must choose a backgroundcolor or a background image")
            return originalImage
        }
        

        var compositeFilter = CIFilter(name: "CIBlendWithAlphaMask")
        compositeFilter.setValue(CIImage(CGImage: originalImage.CGImage), forKey: kCIInputImageKey)
        compositeFilter.setValue(CIImage(CGImage: imageMask.CGImage), forKey: kCIInputMaskImageKey)
        var compositeImage = compositeFilter.outputImage
        var maskedImage = UIImage(CIImage: compositeImage)
        println(maskedImage.size)
        return maskedImage
    }

    
}