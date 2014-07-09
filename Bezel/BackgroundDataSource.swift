//
//  BackgroundDataSource.swift
//  Bezel
//
//  Created by John Clem on 7/9/14.
//  Copyright (c) 2014 learnswift. All rights reserved.
//

import UIKit

class BackgroundDataSource: NSObject {
    var backgrounds : Array<UIImage>
    
    init(backgrounds: Array<UIImage>?) {
        if let newBackgrounds = backgrounds as? Array<UIImage> {
            self.backgrounds = newBackgrounds
        } else {
            self.backgrounds = [UIImage(named: "tree_bg.png"), UIImage(named: "gold_tree_bg.png"), UIImage(named: "candy_bg.png")]
        }
        super.init()
    }

    func collectionView(collectionView: UICollectionView!, numberOfItemsInSection section: Int) -> Int {
        return self.backgrounds.count
    }
    
    func collectionView(collectionView: UICollectionView!, cellForItemAtIndexPath indexPath: NSIndexPath!) -> UICollectionViewCell! {
        let cell = collectionView.dequeueReusableCellWithReuseIdentifier("BackgroundCell", forIndexPath: indexPath) as ImageCollectionViewCell
        
        if !cell.imageView {
            cell.imageView = UIImageView(frame: cell.bounds)
            cell.addSubview(cell.imageView)
        }
        
        cell.imageView!.image = self.backgrounds[indexPath.row]
        
        return cell
    }
    
}
