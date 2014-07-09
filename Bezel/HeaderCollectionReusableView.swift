//
//  HeaderCollectionReusableView.swift
//  Bezel
//
//  Created by John Clem on 7/9/14.
//  Copyright (c) 2014 learnswift. All rights reserved.
//

import UIKit

protocol HeaderDelegate : NSObjectProtocol {
    
    func didChangeSegment(segment : Int)
}

class HeaderCollectionReusableView: UICollectionReusableView {
    
    @IBOutlet var segmentedControl : UISegmentedControl?
    var delegate : HeaderDelegate?
    
    @IBAction func changeCollectionViewData (sender : AnyObject?) {
        delegate?.didChangeSegment(segmentedControl!.selectedSegmentIndex)
    }
}
