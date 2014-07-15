//
//  BezelCollectionViewDataSource.swift
//  Bezel
//
//  Created by John Clem on 7/9/14.
//  Copyright (c) 2014 learnswift. All rights reserved.
//

import UIKit

class BezelCollectionViewDataSource: NSObject, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout, HeaderDelegate {

    var selectedSection = 0
    var shapeDataSource : ShapeDataSource!
    var backgroundDataSource : BackgroundDataSource!
    var collectionView : UICollectionView?
    var didChangeColorBlock : NKOColorPickerDidChangeColorBlock
    var colorPicker = NKOColorPickerView()
    
    init(didChangeColorBlock : NKOColorPickerDidChangeColorBlock) {
        shapeDataSource = ShapeDataSource()
        backgroundDataSource = BackgroundDataSource(backgrounds: nil)
        self.didChangeColorBlock = didChangeColorBlock
        super.init()
    }
    
    func collectionView(collectionView: UICollectionView!, layout collectionViewLayout: UICollectionViewLayout!, sizeForItemAtIndexPath indexPath: NSIndexPath!) -> CGSize {
        return CGSize(width: 50, height: 50)
    }
    
    func collectionView(collectionView: UICollectionView!, numberOfItemsInSection section: Int) -> Int {
        self.collectionView = collectionView
        
        switch (selectedSection) {
        case 2:
            return backgroundDataSource.collectionView(collectionView, numberOfItemsInSection: section)
        case 1:
            return shapeDataSource.collectionView(collectionView, numberOfItemsInSection: section)
        default:
            return 0
        }
    }

    func collectionView(collectionView: UICollectionView!, cellForItemAtIndexPath indexPath: NSIndexPath!) -> UICollectionViewCell! {
        switch (selectedSection) {
        case 2:
            return backgroundDataSource.collectionView(collectionView, cellForItemAtIndexPath: indexPath)
        default:
            return shapeDataSource.collectionView(collectionView, cellForItemAtIndexPath: indexPath)
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
        if selectedSection == 0 {
            colorPicker = NKOColorPickerView(frame: CGRect(origin: CGPoint(x: 0, y: collectionView!.frame.origin.y + 33), size: CGSize(width: collectionView!.frame.size.width, height: collectionView!.frame.size.height-33.0)))
            colorPicker.color = UIColor.purpleColor()
            colorPicker.didChangeColorBlock = self.didChangeColorBlock
            collectionView!.superview.addSubview(colorPicker)
            collectionView!.reloadData()
        } else {
            colorPicker.removeFromSuperview()
            self.collectionView?.reloadData()
        }
    }
}
