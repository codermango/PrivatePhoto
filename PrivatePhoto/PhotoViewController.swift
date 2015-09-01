//
//  PhotoViewController.swift
//  PrivatePhoto
//
//  Created by Mark on 15/8/10.
//  Copyright (c) 2015年 codermango. All rights reserved.
//

import UIKit

class PhotoViewController: UIViewController, UIGestureRecognizerDelegate, UIScrollViewDelegate {
    
    var photoImage: UIImage!
    var photoIndex: Int!
    var navigationBarHidden: Bool!
    var toolbarHidden: Bool!
    var bgColor: UIColor!

    @IBOutlet weak var scrollView: UIScrollView!
    @IBOutlet weak var photoImageView: UIImageView!
    
    
    @IBAction func tapImage(sender: AnyObject) {
        if navigationBarHidden == false {
            self.view.backgroundColor = UIColor.blackColor()
            bgColor = UIColor.blackColor()
        } else if navigationBarHidden == true {
            self.view.backgroundColor = UIColor.whiteColor()
            bgColor = UIColor.whiteColor()
        }
        navigationBarHidden = !navigationBarHidden
        toolbarHidden = !toolbarHidden
        self.navigationController?.setNavigationBarHidden(navigationBarHidden, animated: true)
        self.navigationController?.setToolbarHidden(toolbarHidden, animated: true)
    }



    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
        scrollView.contentSize = photoImageView.sizeThatFits(photoImage.size)
        let scaleWidth = scrollView.frame.size.width / scrollView.contentSize.width
        let scaleHeight = scrollView.frame.size.height / scrollView.contentSize.height
        let minScale = min(scaleWidth, scaleHeight);
        scrollView.minimumZoomScale = 1.0;
        
        scrollView.maximumZoomScale = 2.0
        scrollView.showsHorizontalScrollIndicator = false
        scrollView.showsVerticalScrollIndicator = false
        scrollView.delegate = self

        
        photoImageView.image = photoImage
        
        self.navigationController?.setToolbarHidden(toolbarHidden, animated: true)
        self.navigationController?.setNavigationBarHidden(navigationBarHidden, animated: true)
        self.view.backgroundColor = bgColor
        
        
        
    }
    
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */
    

    
    // MARK: UIScrollViewDelegate
    
    func viewForZoomingInScrollView(scrollView: UIScrollView) -> UIView? {
        return photoImageView
    }
    
    // 自定义
    
    func centerScrollViewContents() {
        let boundsSize = scrollView.bounds.size
        var contentsFrame = photoImageView.frame
        
        if contentsFrame.size.width < boundsSize.width {
            contentsFrame.origin.x = (boundsSize.width - contentsFrame.size.width) / 2.0
        } else {
            contentsFrame.origin.x = 0.0
        }
        
        if contentsFrame.size.height < boundsSize.height {
            contentsFrame.origin.y = (boundsSize.height - contentsFrame.size.height) / 2.0
        } else {
            contentsFrame.origin.y = 0.0
        }
        
        photoImageView.frame = contentsFrame
    }
    

}
