//
//  Shape.swift
//  Bezel
//
//  Created by Bradley Johnson on 7/9/14.
//  Copyright (c) 2014 learnswift. All rights reserved.
//

import UIKit


class Shape {
    var previewImage : UIImage?
    var overlayImage : UIImage?
    var backgroundImage : UIImage?

    var fillColor = UIColor.blackColor()
    var overlaySize = CGSize(width: 640, height: 640)
    let previewSize = CGSize(width: 120, height: 120)
    var shapeName : String?
    var overlayImageName : String!
    var previewImageName : String!
    
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
        self.previewImage = UIImage(SVGNamed: self.overlayImageName, targetSize: CGSize(width: 120, height: 120), fillColor: color, cache: false)
    }
    
    func setFillColor(color : UIColor) {
        self.fillColor = color
        self.overlayImage = UIImage(SVGNamed: self.overlayImageName, targetSize: self.overlaySize, fillColor: self.fillColor, cache: false)
    }
    
}