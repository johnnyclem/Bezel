//
//  ShapeDataSource.swift
//  Bezel
//
//  Created by John Clem on 7/9/14.
//  Copyright (c) 2014 learnswift. All rights reserved.
//

import UIKit

class ShapeDataSource: NSObject {
    var shapes = Array<Shape>()
    
    init() {
        super.init()
        shapes = self.loadAllShapes()
    }
    
    func collectionView(collectionView: UICollectionView!, numberOfItemsInSection section: Int) -> Int {
        return self.shapes.count
    }
    
    func loadAllShapes() -> Array<Shape> {
        let filePath = NSBundle.mainBundle().pathForResource("Shapes", ofType: "plist")
        let shapesArray = NSArray(contentsOfFile: filePath)
        var allShapes = Array<Shape>()
        
        for info in shapesArray {
            if let shapeDict = info as? Dictionary<String, String> {
                let shape = Shape(color: UIColor.blackColor(), size : CGSize(width: 640, height: 640), info : shapeDict)
                allShapes += shape
            }
        }
        
        return allShapes
    }
        
    func collectionView(collectionView: UICollectionView!, cellForItemAtIndexPath indexPath: NSIndexPath!) -> UICollectionViewCell! {
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
