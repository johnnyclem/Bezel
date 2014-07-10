//
//  ShapeDataSource.swift
//  Bezel
//
//  Created by John Clem on 7/9/14.
//  Copyright (c) 2014 learnswift. All rights reserved.
//

import UIKit

class ShapeDataSource: NSObject {
    var shapes : Array<Shape>
    
    init(shapes: Array<Shape>?) {
        if let newShapes = shapes as? Array<Shape> {
            self.shapes = newShapes
        } else {
            self.shapes = [Shape(overlayImage: UIImage(named: "bolt_black.png"), previewImage: UIImage(named: "bolt_white.png")), Shape(overlayImage: UIImage(named: "anchor_black.png"), previewImage: UIImage(named: "anchor_white.png")), Shape(overlayImage: UIImage(named: "arrow_black.png"), previewImage: UIImage(named: "arrow_white.png")), Shape(overlayImage: UIImage(named: "cross_black.png"), previewImage: UIImage(named: "cross_white.png"))]
        }
        super.init()
    }
    
    func collectionView(collectionView: UICollectionView!, numberOfItemsInSection section: Int) -> Int {
        return self.shapes.count
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
