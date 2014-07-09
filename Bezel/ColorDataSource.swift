//
//  ColorDataSource.swift
//  Bezel
//
//  Created by John Clem on 7/9/14.
//  Copyright (c) 2014 learnswift. All rights reserved.
//

import UIKit

class ColorDataSource: NSObject {
   
    var colors : Array<UIColor>
    
    init(colors: Array<UIColor>?) {
        if let newColors = colors as? Array<UIColor> {
            self.colors = newColors
        } else {
            self.colors = [UIColor.blackColor(), UIColor.darkGrayColor(), UIColor.lightGrayColor(), UIColor.whiteColor(), UIColor.redColor(), UIColor.greenColor(), UIColor.blueColor(), UIColor.brownColor(), UIColor.yellowColor()]
        }
        super.init()
    }
    func collectionView(collectionView: UICollectionView!, numberOfItemsInSection section: Int) -> Int {
        return self.colors.count
    }
    
    func collectionView(collectionView: UICollectionView!, cellForItemAtIndexPath indexPath: NSIndexPath!) -> UICollectionViewCell! {
        let cell = collectionView.dequeueReusableCellWithReuseIdentifier("ColorCell", forIndexPath: indexPath) as UICollectionViewCell
        cell.backgroundColor = self.colors[indexPath.row]
        return cell
    }
    
}
