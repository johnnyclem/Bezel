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
    var colorDataSource : ColorDataSource!
    var shapeDataSource : ShapeDataSource!
    var backgroundDataSource : BackgroundDataSource!
    var collectionView : UICollectionView?
    
    init() {
        colorDataSource = ColorDataSource(colors: nil)
        shapeDataSource = ShapeDataSource(shapes: nil)
        backgroundDataSource = BackgroundDataSource(backgrounds: nil)
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
            return colorDataSource.collectionView(collectionView, numberOfItemsInSection: section)
        }
    }

    func collectionView(collectionView: UICollectionView!, cellForItemAtIndexPath indexPath: NSIndexPath!) -> UICollectionViewCell! {
        switch (selectedSection) {
        case 2:
            return backgroundDataSource.collectionView(collectionView, cellForItemAtIndexPath: indexPath)
        case 1:
            return shapeDataSource.collectionView(collectionView, cellForItemAtIndexPath: indexPath)
        default:
            return colorDataSource.collectionView(collectionView, cellForItemAtIndexPath: indexPath)
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
        self.collectionView?.reloadData()
    }
}
