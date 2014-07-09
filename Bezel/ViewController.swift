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
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    override func viewDidAppear(animated: Bool) {
        super.viewDidAppear(animated)
        imageView!.contentMode = UIViewContentMode.ScaleAspectFill
        var image = UIImage(named: "road.jpg")
        
        
        imageView!.image = image
        self.testImageViewOverlay()
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
    
}





















    