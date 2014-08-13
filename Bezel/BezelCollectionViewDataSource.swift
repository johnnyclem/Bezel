//
//  BezelCollectionViewDataSource.swift
//  Bezel
//
//  Created by John Clem on 7/9/14.
//  Copyright (c) 2014 learnswift. All rights reserved.
//

import UIKit

class BezelCollectionViewDataSource: NSObject, UICollectionViewDataSource, HeaderDelegate {

    var selectedSection = 0
    var shapes = Array<Shape>()
    var backgrounds = [UIImage]()
    var backgroundThumbs = [UIImage]()
    
    var collectionView : UICollectionView?
    var didChangeColorBlock : NKOColorPickerDidChangeColorBlock
    var colorPicker : NKOColorPickerView?
    var currentColor = UIColor.lightGrayColor()
    var currentShape = Shape(color: UIColor.whiteColor(), size: CGSize(width: 640, height: 640), info: ["shapeName" : "circle", "overlayImage" : "circle_black", "previewImage" : "circle"])

    init(didChangeColorBlock : NKOColorPickerDidChangeColorBlock) {
        self.didChangeColorBlock = didChangeColorBlock
        super.init()
        self.shapes = self.loadAllShapes(UIColor.whiteColor())
        self.backgrounds = self.loadAllTextures()
    }
    
    func collectionView(collectionView: UICollectionView!, numberOfItemsInSection section: Int) -> Int {
        self.collectionView = collectionView
        
        switch (selectedSection) {
        case 2:
            return backgroundThumbs.count
        case 1:
            return 0
        default:
            return shapes.count
        }
    }

    func collectionView(collectionView: UICollectionView!, cellForItemAtIndexPath indexPath: NSIndexPath!) -> UICollectionViewCell! {
        switch (selectedSection) {
        case 2: // Backgrounds
            let cell = collectionView.dequeueReusableCellWithReuseIdentifier("BackgroundCell", forIndexPath: indexPath) as ImageCollectionViewCell
            
            var imageView : UIImageView!
            var overlayImageView : UIImageView!
            
            if let taggedImageView = cell.viewWithTag(999) as? UIImageView {
                imageView = taggedImageView
            } else {
                imageView = UIImageView(frame: cell.bounds)
                imageView.tag = 999
                cell.addSubview(imageView)
            }
            
            if indexPath.item == backgrounds.count {
                for subView in imageView.subviews {
                    subView.removeFromSuperview()
                }
                imageView.image = self.backgroundThumbs[0]
            } else {
                let cellOverlayImage = self.currentShape.previewImage

                if let taggedOverlayImageView = cell.viewWithTag(998) as? UIImageView {
                    overlayImageView = taggedOverlayImageView
                } else {
                    overlayImageView = UIImageView(frame: cell.bounds)
                    overlayImageView.tag = 998
                    overlayImageView.image = cellOverlayImage
                    imageView.addSubview(overlayImageView!)
                }
                imageView.image = self.backgrounds[indexPath.row]
            }
            
            
            return cell
        default: // Shapes
            let cell = collectionView.dequeueReusableCellWithReuseIdentifier("ShapeCell", forIndexPath: indexPath) as ImageCollectionViewCell
            
            let shape = self.shapes[indexPath.row]
            
            if cell.imageView == nil {
                cell.imageView = UIImageView(frame: cell.bounds)
                cell.addSubview(cell.imageView!)
            }
            
            
            cell.imageView!.image = shape.previewImage
            return cell
        }
    }
    
    func collectionView(collectionView: UICollectionView!, viewForSupplementaryElementOfKind kind: String!, atIndexPath indexPath: NSIndexPath!) -> UICollectionReusableView! {
        let header = collectionView.dequeueReusableSupplementaryViewOfKind(UICollectionElementKindSectionHeader, withReuseIdentifier: "Header", forIndexPath: indexPath) as HeaderCollectionReusableView
        header.delegate = self
        return header
    }
    
    // Header Delegate
    
    func didChangeSegment(segment: Int) {
        selectedSection = segment
        if selectedSection == 1 {
            if self.colorPicker == nil {
                colorPicker = NKOColorPickerView(frame: CGRect(origin: CGPoint(x: 0, y: collectionView!.frame.origin.y + 33), size: CGSize(width: collectionView!.frame.size.width, height: collectionView!.frame.size.height-33.0)))
                colorPicker!.didChangeColorBlock = self.didChangeColorBlock
            }
            
            colorPicker!.color = self.currentColor
            collectionView?.superview?.addSubview(colorPicker!)
            collectionView!.reloadData()
        } else {
            colorPicker?.removeFromSuperview()
            collectionView!.reloadData()
        }
    }
    
    // Shapes Data Source
    func loadAllShapes(color : UIColor) -> Array<Shape> {
        let filePath = NSBundle.mainBundle().pathForResource("Shapes", ofType: "plist")
        let shapesArray = NSArray(contentsOfFile: filePath)
        var allShapes = Array<Shape>()
        
        for info in shapesArray {
            if let shapeDict = info as? Dictionary<String, String> {
                let shape = Shape(color: color, size : CGSize(width: 640, height: 640), info : shapeDict)
                allShapes.append(shape)
            }
        }
        
        return allShapes
    }

    func loadAllTextures() -> Array<UIImage> {
        let filePath = NSBundle.mainBundle().pathForResource("Backgrounds", ofType: "plist")
        let bgArray = NSArray(contentsOfFile: filePath)
        var allBGs = Array<UIImage>()
        let addBgThumb = UIImage(named: "addPhoto.png")
        self.backgroundThumbs.append(addBgThumb)

        for info in bgArray {
            if let bgDict = info as? NSDictionary {
                if let imageName = info["imageName"] as? String {
                    var thumbName = imageName + "_thumb"
                    let bgThumb = UIImage(named: thumbName)
                    let bg = UIImage(named: imageName)
                    allBGs.append(bg)
                    self.backgroundThumbs.append(bgThumb)
                }
            }
        }
        
        return allBGs
    }

    
}
