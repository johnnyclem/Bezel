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
    @IBOutlet var collectionView : UICollectionView?
    
    var dataSource : BezelCollectionViewDataSource?
    var photoEditor : PhotoEditController?
    
    let cameraPicker = UIImagePickerController()
    let libraryPicker = UIImagePickerController()
    let actionController = UIAlertController(title: "Image Source", message: "Select Your Choice Please", preferredStyle: UIAlertControllerStyle.ActionSheet)

    override func viewDidLoad() {
        super.viewDidLoad()
        self.setupCollectionViewDataSource()
        self.setupPickersAndActionController()
        
        self.scrollView!.delegate = self
        self.scrollView!.minimumZoomScale = 0.5
        self.scrollView!.maximumZoomScale = 10
        self.imageView = UIImageView(frame: CGRect(x: 0, y: 0, width: self.scrollView!.frame.size.width, height: self.scrollView!.frame.size.height))
        self.scrollView!.addSubview(self.imageView)
        self.imageView.contentMode = UIViewContentMode.ScaleAspectFill
        
        imageView!.contentMode = UIViewContentMode.ScaleAspectFill
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
    
    func setupCollectionViewDataSource() {
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
            self.photoEditor = PhotoEditController(image: image)
            self.imageView.frame.size = image.size
            self.imageView.contentMode = UIViewContentMode.ScaleAspectFill
            self.scrollView!.contentSize = image.size
            self.dismissViewControllerAnimated(true, completion: {
                let defaultShape = Shape(previewImage: UIImage(named: "bolt_black.png"))
                if let compositedImage = self.photoEditor!.imageWithShape(defaultShape) {
                    self.imageView.image = compositedImage
                }
            })
    }
    //#pragma mark - UIScrollViewDelegate
    func viewForZoomingInScrollView(scrollView: UIScrollView!) -> UIView! {
        return self.imageView
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
}





















    