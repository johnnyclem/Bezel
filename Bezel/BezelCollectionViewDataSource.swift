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
    var diskIOQueue = NSOperationQueue()
    var collectionView : UICollectionView?
    var didChangeColorBlock : NKOColorPickerDidChangeColorBlock
    var colorPicker : NKOColorPickerView?
    var currentColor = UIColor.lightGrayColor()
    var currentShape = Shape(color: UIColor.whiteColor(), size: CGSize(width: 640, height: 640), info: ["shapeName" : "circle", "overlayImage" : "circle_black", "previewImage" : "circle"])

    init(didChangeColorBlock : NKOColorPickerDidChangeColorBlock) {
        self.didChangeColorBlock = didChangeColorBlock
        super.init()
        self.loadAllShapes(UIColor.whiteColor())
        self.loadAllTextures()
        self.diskIOQueue.qualityOfService = NSQualityOfService.UserInitiated
    }
    
    func collectionView(collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
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

    func collectionView(collectionView: UICollectionView, cellForItemAtIndexPath indexPath: NSIndexPath) -> UICollectionViewCell {
        switch (selectedSection) {
        case 2: // Backgrounds
            let cell = collectionView.dequeueReusableCellWithReuseIdentifier("BackgroundCell", forIndexPath: indexPath) as ImageCollectionViewCell
            
            var imageView : UIImageView!
            
            if let taggedImageView = cell.viewWithTag(999) as? UIImageView {
                imageView = taggedImageView
            } else {
                imageView = UIImageView(frame: cell.bounds)
                imageView.tag = 999
                cell.addSubview(imageView)
            }
            
            if indexPath.item == backgrounds.count {
                imageView.image = self.backgroundThumbs[0]
            } else {
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
    
    func didChangeSegment(segment : Int, sender: AnyObject?) {
        selectedSection = segment
        
        if let segmentedControl = sender as? UISegmentedControl {
            println("Tapped Control With ID: \(segmentedControl.accessibilityLabel)")
        } else {
            println("couldn't cast sender to UISegmentedControl")
        }

        switch selectedSection {
        case 1:
            if self.colorPicker == nil {
                colorPicker = NKOColorPickerView(frame: CGRect(origin: CGPoint(x: 0, y: collectionView!.frame.origin.y + 33), size: CGSize(width: collectionView!.frame.size.width, height: collectionView!.frame.size.height-33.0)))
                colorPicker!.didChangeColorBlock = self.didChangeColorBlock
            }
            
            colorPicker!.color = self.currentColor
            collectionView?.superview?.addSubview(colorPicker!)
            collectionView!.reloadData()
        default:
            colorPicker?.removeFromSuperview()
            collectionView!.reloadData()
        }
    }
    
    // Shapes Data Source
    func loadAllShapes(color : UIColor) {
        let filePath = NSBundle.mainBundle().pathForResource("Shapes", ofType: "plist")!
        let shapesArray = NSArray(contentsOfFile: filePath)
        self.shapes = Array<Shape>()
        
        for info in shapesArray {
            if let shapeDict = info as? Dictionary<String, String> {
                let shape = Shape(color: color, size : CGSize(width: 640, height: 640), info : shapeDict)
                self.shapes.append(shape)
            }
        }
    }

    func loadAllTextures() {
        let filePath = NSBundle.mainBundle().pathForResource("Backgrounds", ofType: "plist")!
        let bgArray = NSArray(contentsOfFile: filePath)
        self.backgrounds = Array<UIImage>()
        let addBgThumb = UIImage(named: "addPhoto.png")
        self.backgroundThumbs.append(addBgThumb)

        for info in bgArray {
            if let bgDict = info as? NSDictionary {
                if let imageName = info["imageName"] as? String {
                    var thumbName = imageName + "_thumb"
                    let bgThumb = UIImage(named: thumbName)
                    self.backgroundThumbs.append(bgThumb)
                    self.diskIOQueue.addOperationWithBlock { () -> Void in
                        let bg = UIImage(named: imageName)
                        self.backgrounds.append(bg)
                    }
                }
            }
        }
    }
    
}

