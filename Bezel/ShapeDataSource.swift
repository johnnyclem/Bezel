//
//  ShapeDataSource.swift
//  Bezel
//
//  Created by John Clem on 7/9/14.
//  Copyright (c) 2014 learnswift. All rights reserved.
//

import UIKit

class ShapeDataSource: NSObject {
    var shapes : Array<Shape>!
    
    init(shapes: Array<Shape>?) {
        super.init()
        
        if let newShapes = shapes as? Array<Shape> {
            self.shapes = newShapes
        } else {
            self.shapes = self.loadAllShapes()
        }
    }
    
    func collectionView(collectionView: UICollectionView!, numberOfItemsInSection section: Int) -> Int {
        return self.shapes!.count
    }
    
    func loadAllShapes() -> Array<Shape> {
        let anchor = UIImage(SVGNamed: "anchor", targetSize: CGSize(width: 120, height: 120), fillColor: UIColor.whiteColor())
        let anchorOverlay = UIImage(SVGNamed: "anchor_black", targetSize: CGSize(width: 640, height: 640), fillColor: UIColor.blackColor())
        
        let shape = Shape(overlayImage : anchorOverlay, previewImage : anchor)
        return [shape]
    }
        
    func collectionView(collectionView: UICollectionView!, cellForItemAtIndexPath indexPath: NSIndexPath!) -> UICollectionViewCell! {
        let cell = collectionView.dequeueReusableCellWithReuseIdentifier("ShapeCell", forIndexPath: indexPath) as ImageCollectionViewCell
        
        let shape = self.shapes![indexPath.row]
        
        if !cell.imageView {
            cell.imageView = UIImageView(frame: cell.bounds)
            cell.addSubview(cell.imageView)
        }
        
        cell.imageView!.image = shape.previewImage
        
        return cell
    }

}
