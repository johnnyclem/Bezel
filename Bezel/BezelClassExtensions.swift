//
//  BezelClassExtensions.swift
//  Bezel
//
//  Created by John Clem on 7/18/14.
//  Copyright (c) 2014 learnswift. All rights reserved.
//

import UIKit
import CoreImage

extension UIImage {
    
    class func imageFromView(view : UIView) -> UIImage {
        UIGraphicsBeginImageContextWithOptions(view.bounds.size, true, 0.0)
        view.drawViewHierarchyInRect(view.bounds, afterScreenUpdates: true)
        let outputImage = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        return outputImage
    }
    
    class func imageWithBackgroundFromSVGNamed(name : String, targetSize : CGSize, fillImage : UIImage) -> UIImage {
        let svg = PocketSVG(fromSVGFile: name)
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

    class func maskImage(image : UIImage, withMask mask : UIImage, andBackground background : UIImage) -> UIImage {
        
        let blendFilter = CIFilter(name: "CIBlendWithAlphaMask")
//        blendFilter.setValue(CIImage(CGImageRef : image.CGImage), forKey: kCIInputImageKey)
        
        /*
, withInputParameters: ["inputImage" : image.CIImage, kCIInputBackgroundImageKey : background.CIImage, kCIInputMaskImageKey : mask.CIImage]
        */
        let outputImage = blendFilter.outputImage
        return UIImage(CIImage: outputImage)
    }

}
