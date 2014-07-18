//
//  ViewController.swift
//  Bezel
//
//  Created by John Clem on 7/9/14.
//  Copyright (c) 2014 Mind Diaper. All rights reserved.
//

import UIKit
import AssetsLibrary
import AVFoundation

class ViewController: UIViewController, UIImagePickerControllerDelegate,UINavigationControllerDelegate, UIScrollViewDelegate, UICollectionViewDelegate {
    
    var imageView : UIImageView!
    let imagePreviewQueue = NSOperationQueue()
    @IBOutlet var scrollView: UIScrollView?
    @IBOutlet var collectionView : UICollectionView?
    @IBOutlet var cutoutImageView: UIImageView?
    
    var currentShape = Shape(color: UIColor.blackColor(), size: CGSize(width: 640, height: 640), info: ["shapeName":"Anchor", "overlayImage":"anchor_black", "previewImage":"anchor"])

    var dataSource : BezelCollectionViewDataSource?
    let actionController = UIAlertController(title: "Image Source", message: "Select Your Choice Please", preferredStyle: UIAlertControllerStyle.ActionSheet)
    let cameraPicker = UIImagePickerController()
    let libraryPicker = UIImagePickerController()
    let libraryAlertView = UIAlertController(title: "Hello There", message: "", preferredStyle: UIAlertControllerStyle.Alert)
    let cameraAlertView = UIAlertController(title: "Hello There", message: "", preferredStyle: UIAlertControllerStyle.Alert)
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.collectionView!.delegate = self
        self.testCollectionViewDataSource()
        self.setupPickersAndAlertControllers()
        
        self.scrollView!.delegate = self
        self.scrollView!.minimumZoomScale = 0.5
        self.scrollView!.maximumZoomScale = 10
        self.imageView = UIImageView(frame: CGRect(x: 0, y: 0, width: self.scrollView!.frame.size.width, height: self.scrollView!.frame.size.width))
        self.scrollView!.addSubview(self.imageView)
        self.imageView.contentMode = UIViewContentMode.ScaleAspectFill
        
        var image = UIImage(named: "road.jpg")
        imageView!.image = image
    }
    
    func setupPickersAndAlertControllers(){
        
        //only add the camera option if a camera is on the device
        if UIImagePickerController.isSourceTypeAvailable(UIImagePickerControllerSourceType.Camera) {
            self.cameraPicker.delegate = self
            self.cameraPicker.allowsEditing = false
            self.cameraPicker.sourceType = UIImagePickerControllerSourceType.Camera
            let cameraOption = UIAlertAction(title: "Camera", style: UIAlertActionStyle.Default, handler: {(action :UIAlertAction!) -> Void in

            var cameraStatus = AVCaptureDevice.authorizationStatusForMediaType(AVMediaTypeVideo) as AVAuthorizationStatus
            switch cameraStatus {
                case .NotDetermined:
                    self.cameraAlertView.message = "We are about to ask for permission to let this app to use your camera."
                    self.presentViewController(self.cameraAlertView, animated: true, completion: {() -> Void in
                        })
                case .Authorized:
                self.presentViewController(self.cameraPicker, animated: true, completion: nil)
                case .Denied:
                    self.cameraAlertView.message = "You previously denied this app permission to use your camera, go to your privacy settings to fix this"
                    self.presentViewController(self.cameraAlertView, animated: true, completion: {() -> Void in
                        
                        })
                case .Restricted:
                    self.cameraAlertView.message = "You previously denied this app permission to use your camera, go to your privacy settings to fix this"
                    self.presentViewController(self.cameraAlertView, animated: true, completion: {() -> Void in
                        
                        })
                }
                })
             self.actionController.addAction(cameraOption)
            let cameraAlertOption = UIAlertAction(title: "Okay", style: UIAlertActionStyle.Default, handler: {(action :UIAlertAction!) -> Void in
                self.presentViewController(self.cameraPicker, animated: true, completion: nil)
                })
            self.cameraAlertView.addAction(cameraAlertOption)
        }
        //setup the photo library option
        self.libraryPicker.delegate = self
        self.libraryPicker.allowsEditing = false
        self.libraryPicker.sourceType = UIImagePickerControllerSourceType.SavedPhotosAlbum
        
        let libraryOption = UIAlertAction(title: "Photo Library", style: UIAlertActionStyle.Default, handler: {(action :UIAlertAction!) -> Void in
            
            var libraryStatus = ALAssetsLibrary.authorizationStatus()
            switch libraryStatus {
            case .NotDetermined:
                self.libraryAlertView.message = "We are about to ask for permission to let this app use your photo library"
                self.presentViewController(self.libraryAlertView, animated: true, completion: {() -> Void in
                    })
            case .Authorized:
                self.presentViewController(self.libraryPicker, animated: true, completion: nil)
                return
            case .Denied:
                self.libraryAlertView.message = "You previously denied this app permission to use your camera, go to your privacy settings to fix this"
                self.presentViewController(self.libraryAlertView, animated: true, completion: {() -> Void in
                    })
            case .Restricted:
                self.libraryAlertView.message = "You previously denied this app permission to use your camera, go to your privacy settings to fix this"
                self.presentViewController(self.libraryAlertView, animated: true, completion: {() -> Void in
                    })
            }
            })
        let cancelOption = UIAlertAction(title: "Cancel", style: UIAlertActionStyle.Cancel, handler: {(action :UIAlertAction!) -> Void in
            println(action.title)
            })
        self.actionController.addAction(cancelOption)
        self.actionController.addAction(libraryOption)
        
        let libraryAlertOption = UIAlertAction(title: "Okay", style: UIAlertActionStyle.Default, handler: {(action :UIAlertAction!) -> Void in
             self.presentViewController(self.libraryPicker, animated: true, completion: nil)
            })
        self.libraryAlertView.addAction(libraryAlertOption)
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }

    func testCollectionViewDataSource() {
        dataSource = BezelCollectionViewDataSource() { (color : UIColor!) in
            self.updateShapeColor(color)
        }
        collectionView!.dataSource = dataSource
        collectionView!.reloadData()
        if dataSource!.shapes.count > 0 {
            currentShape = dataSource!.shapes[0]
        }
    }
    
    func updateShapeColor (color : UIColor) {
        println("changed color to: \(color)")
        self.dataSource!.currentColor = color
        self.currentShape.setFillColor(self.dataSource!.currentColor)
        self.cutoutImageView!.image = currentShape.overlayImage
    }
    
    @IBAction func cameraButtonPressed(sender: AnyObject) {
        
        var libraryStatus = ALAssetsLibrary.authorizationStatus()
        var cameraStatus = AVCaptureDevice.authorizationStatusForMediaType(AVMediaTypeVideo)
        println(cameraStatus.toRaw())
        println(libraryStatus.toRaw())


        self.presentViewController(self.actionController, animated: true, completion: nil)
    }
    
    //#Pragma mark - UIImagePickerControllerDelegate
    
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
            
            imagePreviewQueue.addOperationWithBlock() {
                switch (self.dataSource!.selectedSection) {
                case 0: // Shapes
                    self.currentShape = self.dataSource!.shapes[indexPath.row]
                    self.currentShape.setFillColor(self.dataSource!.currentColor)
                default: // Backgrounds
                    self.currentShape.setFillPattern(self.dataSource!.backgroundDataSource.backgrounds[indexPath.row])
                    return
                }
                NSOperationQueue.mainQueue().addOperationWithBlock() {
                    self.cutoutImageView!.image = self.currentShape.overlayImage
                }
            }
    }
    
    
}





















    