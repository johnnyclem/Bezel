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
    
    let imageProcessingQueue = NSOperationQueue()
    
    var currentColor = UIColor.whiteColor()
    var currentImage = UIImage(named: "road.jpg")
    var dataSource : BezelCollectionViewDataSource!
    var imageView : UIImageView!
    var pickingBackground = false
    var hasBackgroundTexture = false
    
    @IBOutlet var scrollView: UIScrollView!
    @IBOutlet var collectionView : UICollectionView!
    @IBOutlet var containerView : UIView!
    @IBOutlet var cutoutImageView: UIImageView!
    
    lazy var currentShape : Shape = {
        let defaultColor = UIColor.blackColor()
        let defaultSize = CGSize(width: 640, height: 640)
        let defaultShapeInfo = [ "shapeName" : "Anchor", "overlayImage" : "anchor_black", "previewImage" : "anchor" ]
        return Shape(color: defaultColor, size: defaultSize, info: defaultShapeInfo)
    }()
    
    var actionController = UIAlertController(title: "Image Source", message: "Select Your Choice Please", preferredStyle: UIAlertControllerStyle.ActionSheet)

    var libraryPicker = UIImagePickerController()
    var libraryAlertView = UIAlertController(title: "Hello There", message: "", preferredStyle: UIAlertControllerStyle.Alert)
    
    var cameraPicker = UIImagePickerController()
    var cameraAlertView = UIAlertController(title: "Hello There", message: "", preferredStyle: UIAlertControllerStyle.Alert)
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.setupImageQueues()
        self.setupCollectionViewDataSource()
        self.setupPickersAndAlertControllers()
        self.setupScrollView()
    }

    func setupScrollView() {
        self.scrollView.delegate = self
        self.scrollView.minimumZoomScale = 1.0
        self.scrollView.maximumZoomScale = 10
        self.imageView = UIImageView(frame: CGRect(x: 0, y: 0, width: self.scrollView.frame.size.width, height: self.scrollView.frame.size.width))
        self.scrollView.addSubview(self.imageView)
        self.imageView.contentMode = UIViewContentMode.ScaleAspectFill
        self.imageView.image = self.currentImage
    }
    
    func setupImageQueues() {
        imageProcessingQueue.qualityOfService = NSQualityOfService.UserInitiated
    }
    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
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

    func setupCollectionViewDataSource() {
        self.dataSource = BezelCollectionViewDataSource() { (color : UIColor!) in
            self.updateShapeColor(color)
        }
        self.collectionView.delegate = self
        self.collectionView.dataSource = self.dataSource
        if let firstShape = self.dataSource.shapes.first {
            self.currentShape = firstShape
            self.collectionView.reloadData()
        }
    }
    
    func updateShapeColor (color : UIColor) {
        imageProcessingQueue.addOperationWithBlock { () -> Void in
            self.currentColor = color
            self.dataSource.currentColor = self.currentColor
            self.currentShape.setFillColor(self.currentColor)
            NSOperationQueue.mainQueue().addOperationWithBlock({ () -> Void in
                self.cutoutImageView.image = self.currentShape.overlayImage
            })
        }
    }
    
    @IBAction func cameraButtonPressed(sender: AnyObject) {
        var libraryStatus = ALAssetsLibrary.authorizationStatus()
        var cameraStatus = AVCaptureDevice.authorizationStatusForMediaType(AVMediaTypeVideo)
        self.presentViewController(self.actionController, animated: true, completion: nil)
    }
    @IBAction func shareButtonPressed(sender: AnyObject) {
        self.imageProcessingQueue.addOperationWithBlock {
            if self.hasBackgroundTexture {
                if let outputImage = self.currentShape.imageWithBackground(self.currentShape.overlayImage, backgroundColor: nil, originalImage: self.currentImage) {
                    let activitiesController = UIActivityViewController(activityItems: [outputImage], applicationActivities: nil)
                    NSOperationQueue.mainQueue().addOperationWithBlock({
                        self.presentViewController(activitiesController, animated: true, completion: nil)
                    })
                }
            } else {
                if let outputImage = self.currentShape.imageWithBackground(nil, backgroundColor: self.currentShape.fillColor, originalImage: self.currentImage) {
                    let activitiesController = UIActivityViewController(activityItems: [outputImage], applicationActivities: nil)
                    NSOperationQueue.mainQueue().addOperationWithBlock({
                        self.presentViewController(activitiesController, animated: true, completion: nil)
                    })
                }
            }
        }
    }

    //#Pragma mark - UIImagePickerControllerDelegate
    
     func imagePickerController(picker: UIImagePickerController!,
        didFinishPickingMediaWithInfo info: [NSObject : AnyObject]!) {
            if let image = info[UIImagePickerControllerOriginalImage] as? UIImage {
                if self.pickingBackground {
                    self.handleBackgroundPickedImage(image)
                } else {
                    self.handleMainPickedImage(image)
                }
            }
    }
    
    func handleBackgroundPickedImage(image: UIImage) {
        self.dismissViewControllerAnimated(true) {
            self.imageProcessingQueue.addOperationWithBlock({
                let thumb = UIImage(image: image, scaledToFillToSize: CGSize(width: 140, height: 140))
                let fullImage = UIImage(image: image, scaledToFillToSize: CGSize(width: 640, height: 640))
                self.dataSource.backgrounds.append(fullImage)
                self.dataSource.backgroundThumbs.append(thumb)
                NSOperationQueue.mainQueue().addOperationWithBlock({
                    self.collectionView.reloadData()
                    self.collectionView.selectItemAtIndexPath(NSIndexPath(forItem: self.dataSource.backgrounds.count, inSection: 0), animated: true, scrollPosition: UICollectionViewScrollPosition.CenteredVertically)
                    self.pickingBackground = false
                })
            })
        }
    }
    
    func handleMainPickedImage(image: UIImage) {
        self.imageProcessingQueue.addOperationWithBlock({
            self.dismissViewControllerAnimated(true, completion: {
                
                //reset zoomscales
                self.scrollView.setZoomScale(1.0, animated: false)
                self.scrollView.minimumZoomScale = 0.125
                
                // reset imageView
                self.imageView.frame.size = image.size
                self.imageView.contentMode = UIViewContentMode.ScaleAspectFill
                self.scrollView.contentSize = image.size
                self.imageView.image = image
                
                //calculate proper zoom scale for lanscape or portrait
                let zoomFactor = min(image.size.width, image.size.height)
                let frameMinSide = min(self.view.frame.size.width, self.view.frame.size.height)
                
                //set new zoomscales
                self.scrollView.setZoomScale(frameMinSide / zoomFactor, animated: true)
                self.scrollView.minimumZoomScale = frameMinSide / zoomFactor
                
            })
        })
    }
    
    //#pragma mark - UIScrollViewDelegate
    func viewForZoomingInScrollView(scrollView: UIScrollView!) -> UIView! {
        return self.imageView
    }
    
    //#pragma mark - UICollectionViewDelegate
    func collectionView(collectionView: UICollectionView!,
        didSelectItemAtIndexPath indexPath: NSIndexPath!) {
        self.imageProcessingQueue.addOperationWithBlock() {
            self.applyShapeForIndexPath(indexPath)
        }
    }
    
    func applyShapeForIndexPath(indexPath: NSIndexPath) {
        switch (self.dataSource.selectedSection) {
        case 0: // Shapes
            self.currentShape = self.dataSource.shapes[indexPath.item]
            self.dataSource.currentShape = self.currentShape
            self.hasBackgroundTexture = false
        default: // Backgrounds
            if indexPath.item == self.dataSource.backgroundThumbs.count - 1 {
                self.pickingBackground = true
                self.cameraButtonPressed(self)
            } else {
                self.currentColor = UIColor(patternImage: self.dataSource.backgrounds[indexPath.item])
                self.hasBackgroundTexture = false
            }
        }
        
        self.currentShape.setFillColor(self.currentColor)
        NSOperationQueue.mainQueue().addOperationWithBlock { () -> Void in
            self.cutoutImageView.image = self.currentShape.overlayImage
        }
    }
}





















    