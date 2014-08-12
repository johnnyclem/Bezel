//
//  PhotoEditingViewController.swift
//  extension
//
//  Created by John Clem on 8/4/14.
//  Copyright (c) 2014 learnswift. All rights reserved.
//

import UIKit
import Photos
import PhotosUI

class PhotoEditingViewController: UIViewController, PHContentEditingController, UICollectionViewDataSource, UICollectionViewDelegate {

    var input: PHContentEditingInput?
    var filter = CIFilter(name: "CISepiaTone")
    var inputImage : UIImage!
    var selectedFilterName = "CISepiaTone"
    var ciContext = CIContext(options: nil)
    var availableFilters : NSArray?
    
    @IBOutlet var backgroundImageView : UIImageView!
    @IBOutlet var filterPreviewView : UIImageView!
    @IBOutlet var collectionView : UICollectionView!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Setup collectionView
        collectionView.alwaysBounceHorizontal = true
        collectionView.allowsMultipleSelection = false
        collectionView.allowsSelection = true
        
        // Load the available filters
        let plist = NSBundle.mainBundle().pathForResource("Filters", ofType: "plist")
        availableFilters = NSArray(contentsOfFile: plist)
        
        // Add the background image and UIEffectView for the blur
//        let effectView = UIVisualEffectView(effect: UIBlurEffect(style: UIBlurEffectStyle.Dark))
//        effectView.setTranslatesAutoresizingMaskIntoConstraints(false)
//        self.view.insertSubview(effectView, aboveSubview: backgroundImageView)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        
        self.collectionView.selectItemAtIndexPath(NSIndexPath(forRow: 0, inSection: 0), animated: true, scrollPosition: UICollectionViewScrollPosition.CenteredHorizontally)
        self.updateSelectionForCell(self.collectionView.cellForItemAtIndexPath(NSIndexPath(forRow: 0, inSection: 0)))
    }

    // MARK: - PHContentEditingController

    func canHandleAdjustmentData(adjustmentData: PHAdjustmentData?) -> Bool {
        // Inspect the adjustmentData to determine whether your extension can work with past edits.
        // (Typically, you use its formatIdentifier and formatVersion properties to do this.)
        var result = adjustmentData?.formatIdentifier == "com.minddiaper.bezel.extension"
        result &= adjustmentData?.formatVersion == "1.0"
        if result {
            return true
        } else {
            return false
        }
    }

    func startContentEditingWithInput(contentEditingInput: PHContentEditingInput?, placeholderImage: UIImage) {
        // Present content for editing, and keep the contentEditingInput for use when closing the edit session.
        // If you returned YES from canHandleAdjustmentData:, contentEditingInput has the original image and adjustment data.
        // If you returned NO, the contentEditingInput has past edits "baked in".
        input = contentEditingInput

        // Load input image
        if input?.mediaType == PHAssetMediaType.Image {
            inputImage = input?.displaySizeImage
        }
        // Load adjustment data, if any
        selectedFilterName = NSKeyedUnarchiver.unarchiveObjectWithData(input?.adjustmentData.data) as? String ?? "CISepiaTone"
        
        self.updateFilter()
        self.updateFilterPreview()
    }
    
    func cancelContentEditing() {
        // Clean up temporary files, etc.
        // May be called after finishContentEditingWithCompletionHandler: while you prepare output.
    }
    
    var shouldShowCancelConfirmation = false
        
    func finishContentEditingWithCompletionHandler(completionHandler: ((PHContentEditingOutput!) -> Void)!) {
        // Update UI to reflect that editing has finished and output is being rendered.
        
        // Render and provide output on a background queue.
        dispatch_async(dispatch_get_global_queue(CLong(DISPATCH_QUEUE_PRIORITY_DEFAULT), 0)) {
            // Create editing output from the editing input.
            let output = PHContentEditingOutput(contentEditingInput: self.input)
            // Provide new adjustments and render output to given location.
            let archivedData = NSKeyedArchiver.archivedDataWithRootObject(self.selectedFilterName)
             output.adjustmentData = PHAdjustmentData(formatIdentifier: "com.minddiaper.bezel.extension", formatVersion: "1.0", data: archivedData)
            // Get the full size image
            if let imageURL = self.input?.fullSizeImageURL {
                if let orientation = self.input?.fullSizeImageOrientation {
                    // Generate rendered JPEG data
                    var image = UIImage(contentsOfFile: imageURL.path)
                    image = self.transformedImage(image, withOrientation: orientation, usingFilter: self.filter)
                    let imageData = UIImageJPEGRepresentation(image, 0.9)
                    var error : NSError?
                    var success = imageData.writeToURL(output.renderedContentURL, options: NSDataWritingOptions.DataWritingAtomic, error: &error)
                    if success {
                        completionHandler?(output)
                    } else {
                        println("An error occured: \(error)")
                        completionHandler?(nil)
                    }
                }
            }
        }
    }

    func updateFilter() {
        filter = CIFilter(name: selectedFilterName)
        var inputImage = CIImage(CGImage: self.inputImage.CGImage)
        let orientation = self.orientationFromImageOrientation(self.inputImage.imageOrientation)
        inputImage = inputImage.imageByApplyingOrientation(Int32(orientation))
        filter.setValue(inputImage, forKey: kCIInputImageKey)
    }
    
    func updateFilterPreview() {
        if let outputImage = filter.outputImage {
            var cgImage = ciContext.createCGImage(outputImage, fromRect: outputImage.extent())
            let transformedImage = UIImage(CGImage: cgImage)
            filterPreviewView.image = transformedImage
        }
    }
    
    func orientationFromImageOrientation(imageOrientation: UIImageOrientation) -> Int {
        var orientation = 0
        switch imageOrientation {
            case .Up: orientation = 1
            case .Down: orientation = 3
            case .Left: orientation = 8
            case .Right: orientation = 6
            case .UpMirrored: orientation = 2
            case .DownMirrored: orientation = 4
            case .LeftMirrored: orientation = 5
            case .RightMirrored: orientation = 7
        }
        return orientation
    }

    func transformedImage(inputImage: UIImage, withOrientation orientation: Int32, usingFilter filter: CIFilter) -> UIImage {
        
        var outputImage = UIImage()
        
        var ciInputImage = CIImage(CGImage: inputImage.CGImage)
        ciInputImage = ciInputImage.imageByApplyingOrientation(orientation)
        
        self.filter.setValue(ciInputImage, forKey: kCIInputImageKey)
        if let ciOutputImage = self.filter.outputImage {
            let cgOutputImage = self.ciContext.createCGImage(ciOutputImage, fromRect: ciOutputImage.extent())
            outputImage = UIImage(CGImage: cgOutputImage)
        }
        
        return outputImage
    }
    
    //MARK: UICollectionViewDelegate
    func collectionView(collectionView: UICollectionView!, didSelectItemAtIndexPath indexPath: NSIndexPath!) {
        println("Selected Cell: \(indexPath)")
    }
    
    func updateSelectionForCell(cell: UICollectionViewCell) {
        let imageView = cell.viewWithTag(999) as UIImageView
        imageView.layer.borderColor = self.view.tintColor.CGColor
        imageView.layer.borderWidth = cell.selected ? 2.0 : 0.0
        
        let label = cell.viewWithTag(998) as UILabel
        label.textColor = cell.selected ? self.view.tintColor : UIColor.whiteColor()
    }
    
    //MARK: UICollectionViewDataSource
    
    func collectionView(collectionView: UICollectionView!, numberOfItemsInSection section: Int) -> Int {
        return availableFilters?.count ?? 0
    }
    
    func collectionView(collectionView: UICollectionView!, cellForItemAtIndexPath indexPath: NSIndexPath!) -> UICollectionViewCell! {
        let filterInfo = self.availableFilters?[indexPath.item] as NSDictionary
        let displayName = filterInfo["displayName"] as String
        let previewImageName = filterInfo["previewImage"] as String
        
        var cell = collectionView.dequeueReusableCellWithReuseIdentifier("PhotoFilterCell", forIndexPath: indexPath) as UICollectionViewCell
        
        let imageView = cell.viewWithTag(999) as UIImageView
        imageView.image = UIImage(named: previewImageName)

        let label = cell.viewWithTag(998) as UILabel
        label.text = displayName
        
        self.updateSelectionForCell(cell)

        return cell
    }
    
}
