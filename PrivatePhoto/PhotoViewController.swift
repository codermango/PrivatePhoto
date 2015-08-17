//
//  PhotoViewController.swift
//  PrivatePhoto
//
//  Created by Mark on 15/8/10.
//  Copyright (c) 2015年 codermango. All rights reserved.
//

import UIKit

class PhotoViewController: UIViewController, UIGestureRecognizerDelegate {
    
    var isNavigationBarHidden = false
    var isToolBarHidden = false
    var photoImage: UIImage!
    var photoIndex: Int!

    @IBOutlet weak var photoImageView: UIImageView!
    
    
    @IBAction func handleTapPhotoView(sender: AnyObject) {
        if isNavigationBarHidden && isToolBarHidden {
            self.navigationController?.setNavigationBarHidden(false, animated: true)
            self.navigationController?.setToolbarHidden(false, animated: true)
            self.view.backgroundColor = UIColor.whiteColor()
        } else if !isNavigationBarHidden && !isToolBarHidden {
            self.navigationController?.setNavigationBarHidden(true, animated: true)
            self.navigationController?.setToolbarHidden(true, animated: true)
            self.view.backgroundColor = UIColor.blackColor()
        }
        isNavigationBarHidden = !isNavigationBarHidden
        isToolBarHidden = !isToolBarHidden

    }


    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        photoImageView.image = photoImage
        
        self.navigationController?.setToolbarHidden(false, animated: true)
        self.navigationController?.setNavigationBarHidden(false, animated: true)
        self.view.backgroundColor = UIColor.whiteColor()
        
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func viewDidAppear(animated: Bool) {
        self.navigationController?.setNavigationBarHidden(!isNavigationBarHidden, animated: true)
        self.navigationController?.setToolbarHidden(!isToolBarHidden, animated: true)
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */
    
    

    
    // 自定义函数
    
//    func generateAllPhotoViewControllers() -> [PhotoViewController] {
//        var photoViewControllers: [PhotoViewController] = []
//        
//        for photoImage in album.photoArray {
//            var vc = self.storyboard?.instantiateViewControllerWithIdentifier("PhotoViewController") as! PhotoViewController
//            vc.photoImage = photoImage
//            photoViewControllers.append(vc)
//        }
//        
//        return photoViewControllers
//    }
    


}
