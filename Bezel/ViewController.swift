//
//  ViewController.swift
//  Bezel
//
//  Created by John Clem on 7/9/14.
//  Copyright (c) 2014 Mind Diaper. All rights reserved.
//

import UIKit

class ViewController: UIViewController, UIImagePickerControllerDelegate,UINavigationControllerDelegate, UIScrollViewDelegate, UICollectionViewDelegate {
    
    var imageView : UIImageView!
    @IBOutlet strong var scrollView: UIScrollView?
    @IBOutlet var collectionView : UICollectionView!
    @IBOutlet strong var cutoutImageView: UIImageView?
    var dataSource : BezelCollectionViewDataSource?
    let actionController = UIAlertController(title: "Image Source", message: "Select Your Choice Please", preferredStyle: UIAlertControllerStyle.ActionSheet)
    let cameraPicker = UIImagePickerController()
    let libraryPicker = UIImagePickerController()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.collectionView.delegate = self
        self.testCollectionViewDataSource()
        self.setupPickersAndActionController()
        
        self.scrollView!.delegate = self
        self.scrollView!.minimumZoomScale = 0.5
        self.scrollView!.maximumZoomScale = 10
        self.imageView = UIImageView(frame: CGRect(x: 0, y: 0, width: self.scrollView!.frame.size.width, height: self.scrollView!.frame.size.height))
        self.scrollView!.addSubview(self.imageView)
        self.imageView.contentMode = UIViewContentMode.ScaleAspectFill
        
        var image = UIImage(named: "road.jpg")
        imageView!.image = image
    }
    
    func setupPickersAndActionController(){
        
        //only add the camera option if a camera is on the device
        if UIImagePickerController.isSourceTypeAvailable(UIImagePickerControllerSourceType.Camera) {
            self.cameraPicker.delegate = self
            self.cameraPicker.allowsEditing = false
            self.cameraPicker.sourceType = UIImagePickerControllerSourceType.Camera
            let cameraOption = UIAlertAction(title: "Camera", style: UIAlertActionStyle.Default, handler: {(action :UIAlertAction!) -> Void in
                self.presentViewController(self.cameraPicker, animated: true, completion: nil)
                })
             self.actionController.addAction(cameraOption)
        }
        //setup
        self.libraryPicker.delegate = self
        self.libraryPicker.allowsEditing = false
        self.libraryPicker.sourceType = UIImagePickerControllerSourceType.SavedPhotosAlbum
        let libraryOption = UIAlertAction(title: "Photo Library", style: UIAlertActionStyle.Default, handler: {(action :UIAlertAction!) -> Void in
            self.presentViewController(self.libraryPicker, animated: true, completion: nil)
            })
        let cancelOption = UIAlertAction(title: "Cancel", style: UIAlertActionStyle.Cancel, handler: {(action :UIAlertAction!) -> Void in
            println(action.title)
            })
        self.actionController.addAction(cancelOption)
        self.actionController.addAction(libraryOption)
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
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
        //collectionView!.delegate = dataSource
        collectionView!.reloadData()
    }
    
    @IBAction func cameraButtonPressed(sender: AnyObject) {
        self.presentViewController(self.actionController, animated: true, completion: nil)
    }
    
    //#pragma mark - UIImagePickerControllerDelegate
    
     func imagePickerController(picker: UIImagePickerController!,
        didFinishPickingMediaWithInfo info: [NSObject : AnyObject]!) {
            let image = info[UIImagePickerControllerOriginalImage] as UIImage
            println(image.size)
            //reset zoomscales
            self.scrollView!.setZoomScale(1.0, animated: false)
            self.scrollView!.minimumZoomScale = 0.5
            
            self.imageView.frame.size = image.size
            self.imageView.contentMode = UIViewContentMode.ScaleAspectFill
            self.scrollView!.contentSize = image.size
            self.imageView.image = image
            
            //calculate proper zoom scale for lanscape or portrait
            let zoomFactor = min(image.size.width, image.size.height)
            let frameMinSide = min(self.view.frame.size.width, self.view.frame.size.height)
            self.scrollView!.setZoomScale(frameMinSide / zoomFactor, animated: true)
            self.scrollView!.minimumZoomScale = frameMinSide / zoomFactor

            //self.imageView.frame = CGRect(x: 0, y: 0, width: self.scrollView!.contentSize.width, height: self.scrollView!.contentSize.height)
            //self.scrollView!.zoomScale = 0.5
            self.dismissViewControllerAnimated(true, completion: nil)
            self.scrollView!.contentMode = UIViewContentMode.ScaleAspectFill
            
    }
    //#pragma mark - UIScrollViewDelegate
    func viewForZoomingInScrollView(scrollView: UIScrollView!) -> UIView! {
        return self.imageView
    }
    
    //#pragma mark - UICollectionViewDelegate
    func collectionView(collectionView: UICollectionView!,
        didSelectItemAtIndexPath indexPath: NSIndexPath!) {
            println(indexPath.row)
            var shape = self.dataSource!.shapeDataSource.shapes[indexPath.row]
            self.cutoutImageView!.image = shape.overlayImage
    }
    
    
}





















    