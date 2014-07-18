//
//  BezelClassExtensions.swift
//  Bezel
//
//  Created by John Clem on 7/18/14.
//  Copyright (c) 2014 learnswift. All rights reserved.
//

import UIKit

extension UIImage {
    
    class func imageWithBackgroundFromSVGNamed(name : String, targetSize : CGSize, fillImage : UIImage) -> UIImage {
        let svg = PocketSVG(fromSVGFilename: name, fileExtension: "svg")
        let boundingBoxAspectRatio = svg.width / svg.height
        let targetAspectRatio = targetSize.width / targetSize.height
        var scaleFactor = CGFloat(1.0)
        var transform = CGAffineTransformIdentity
        
        if boundingBoxAspectRatio > targetAspectRatio {
            scaleFactor = targetSize.width / svg.width
        } else {
            scaleFactor = targetSize.height / svg.height
        }
        
        transform = CGAffineTransformScale(transform, scaleFactor, scaleFactor)
        UIGraphicsBeginImageContextWithOptions(targetSize, false, UIScreen.mainScreen().scale)
        let context = UIGraphicsGetCurrentContext()
        CGContextDrawImage(context, CGRect(x: 0.0, y: 0.0, width: targetSize.width, height: targetSize.height), fillImage.CGImage)
        for path in svg.beziers {
            if let bezierPath = path as? UIBezierPath {
                let scaledPath = CGPathCreateCopyByTransformingPath(bezierPath.CGPath, &transform)
                CGContextAddPath(context, scaledPath)
            }
        }

        CGContextFillPath(context)
        var image = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()

        return image
    }
}