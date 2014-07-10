//
//  ViewController.swift
//  Bezel
//
//  Created by John Clem on 7/9/14.
//  Copyright (c) 2014 Mind Diaper. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    @IBOutlet var imageView : UIImageView?
    @IBOutlet var collectionView : UICollectionView?
    var dataSource : BezelCollectionViewDataSource?
    let actionController = UIAlertController(title: "Image Source", message: "Select Your Choice Please", preferredStyle: UIAlertControllerStyle.ActionSheet)
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.testCollectionViewDataSource()
        self.setupActionController()
    }
    
    func setupActionController(){
        
        let cancelOption = UIAlertAction(title: "Cancel", style: UIAlertActionStyle.Cancel, handler: {(action :UIAlertAction!) -> Void in
            println(action.title)
            })
        let cameraOption = UIAlertAction(title: "Camera", style: UIAlertActionStyle.Default, handler: {(action :UIAlertAction!) -> Void in
            println(action.title)
            })
        let libraryOption = UIAlertAction(title: "Photo Library", style: UIAlertActionStyle.Default, handler: {(action :UIAlertAction!) -> Void in
            println(action.title)
            })
        self.actionController.addAction(cameraOption)
        self.actionController.addAction(cancelOption)
        self.actionController.addAction(libraryOption)
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    override func viewDidAppear(animated: Bool) {
        super.viewDidAppear(animated)
        imageView!.contentMode = UIViewContentMode.ScaleAspectFill
        var image = UIImage(named: "road.jpg")
        
        
        imageView!.image = image
//        self.testImageViewOverlay()
    }
    
    func testImageViewOverlay() {
        //        let overlay = UIImage(named: "bolt_black.png")
        //        let overlayView = UIImageView(frame: imageView!.frame)
        //        overlayView.image = overlay
        //        imageView!.addSubview(overlayView)
        
        let composition = self.overlayImageWithShape(nil, image: imageView!.image)
        imageView!.image = UIImage(CIImage: composition)
    }
    
    func overlayBoltByCheating() {
        let overlayImage = UIImage(named: "bolt_black.png")
        let overlay = UIImageView(frame: imageView!.frame)
        overlay.contentMode = UIViewContentMode.ScaleAspectFit
        overlay.image = overlayImage
        self.view.addSubview(overlay)
    }
    
    func overlayImageWithShape(shape : Shape?, image: UIImage) -> CIImage {
        let context = CIContext(options: nil)
        
        let background = CIImage(image: image)
        let overlayImage = UIImage(named: "bolt_black.png")
        let overlay = CIImage(image: overlayImage)

        return overlay.imageByCompositingOverImage(background)
    }
    
    func testCollectionViewDataSource() {
        dataSource = BezelCollectionViewDataSource()
        collectionView!.dataSource = dataSource
        collectionView!.delegate = dataSource
        collectionView!.reloadData()
    }
    
    @IBAction func cameraButtonPressed(sender: AnyObject) {
        self.presentViewController(self.actionController, animated: true, completion: nil)
    }
}





















    