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
    var backgrounds = Array<UIImage>()
    var collectionView : UICollectionView?
    var didChangeColorBlock : NKOColorPickerDidChangeColorBlock
    var colorPicker = NKOColorPickerView()
    var currentColor = UIColor.lightGrayColor()
    
    init(didChangeColorBlock : NKOColorPickerDidChangeColorBlock) {
        self.didChangeColorBlock = didChangeColorBlock
        super.init()
        self.shapes = self.loadAllShapes()
        self.backgrounds = [UIImage(named: "tree_bg.png"), UIImage(named: "gold_tree_bg.png"), UIImage(named: "candy_bg.png")]
    }
    
    func collectionView(collectionView: UICollectionView!, numberOfItemsInSection section: Int) -> Int {
        self.collectionView = collectionView
        
        switch (selectedSection) {
        case 2:
            return backgrounds.count
        case 1:
            return 0
        default:
            return shapes.count
        }
    }

    func collectionView(collectionView: UICollectionView!, cellForItemAtIndexPath indexPath: NSIndexPath!) -> UICollectionViewCell! {
        switch (selectedSection) {
        case 2:
            let cell = collectionView.dequeueReusableCellWithReuseIdentifier("BackgroundCell", forIndexPath: indexPath) as ImageCollectionViewCell
            
            if !cell.imageView {
                cell.imageView = UIImageView(frame: cell.bounds)
                cell.addSubview(cell.imageView)
            }
            
            cell.imageView!.image = self.backgrounds[indexPath.row]
            
            return cell
        default:
            let cell = collectionView.dequeueReusableCellWithReuseIdentifier("ShapeCell", forIndexPath: indexPath) as ImageCollectionViewCell
            
            let shape = self.shapes[indexPath.row]
            
            if !cell.imageView {
                cell.imageView = UIImageView(frame: cell.bounds)
                cell.addSubview(cell.imageView)
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
            colorPicker = NKOColorPickerView(frame: CGRect(origin: CGPoint(x: 0, y: collectionView!.frame.origin.y + 33), size: CGSize(width: collectionView!.frame.size.width, height: collectionView!.frame.size.height-33.0)))
            colorPicker.color = self.currentColor
            colorPicker.didChangeColorBlock = self.didChangeColorBlock
            collectionView!.superview.addSubview(colorPicker)
            collectionView!.reloadData()
        } else {
            colorPicker.removeFromSuperview()
            self.collectionView?.reloadData()
        }
    }
    
    // Shapes Data Source
    func loadAllShapes() -> Array<Shape> {
        let filePath = NSBundle.mainBundle().pathForResource("Shapes", ofType: "plist")
        let shapesArray = NSArray(contentsOfFile: filePath)
        var allShapes = Array<Shape>()
        
        for info in shapesArray {
            if let shapeDict = info as? Dictionary<String, String> {
                let shape = Shape(color: UIColor.clearColor(), size : CGSize(width: 640, height: 640), info : shapeDict)
                allShapes += shape
            }
        }
        
        return allShapes
    }

    
}
