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
    var fillColor = UIColor.blackColor()
    var overlaySize = CGSize(width: 640, height: 640)
    
    init(previewImage : UIImage) {
        self.previewImage = previewImage
        self.overlayImage = previewImage
    }
    
    init(overlayImage : UIImage, previewImage : UIImage) {
        self.previewImage = previewImage
        self.overlayImage = overlayImage
    }
    
    init(overlayImage : UIImage, previewImage : UIImage, color : UIColor, size : CGSize) {
        let anchor = UIImage(SVGNamed: "anchor", targetSize: CGSize(width: 120, height: 120), fillColor: UIColor.whiteColor())
        let anchorOverlay = UIImage(SVGNamed: "anchor_black", targetSize: CGSize(width: 640, height: 640), fillColor: color)

        self.previewImage = previewImage
        self.overlayImage = anchorOverlay
        self.fillColor = color
        self.overlaySize = size
    }
    

}