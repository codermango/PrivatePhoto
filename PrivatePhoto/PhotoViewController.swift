//
//  PhotoViewController.swift
//  PrivatePhoto
//
//  Created by Mark on 15/8/10.
//  Copyright (c) 2015年 codermango. All rights reserved.
//

import UIKit

class PhotoViewController: UIViewController, UIGestureRecognizerDelegate {
    
    var photoImage: UIImage!
    var photoIndex: Int!

    @IBOutlet weak var photoImageView: UIImageView!
    
    @IBAction func tapImage(sender: AnyObject) {
        if self.navigationController?.navigationBarHidden == true && self.navigationController?.toolbarHidden == true {
            self.navigationController?.setNavigationBarHidden(false, animated: true)
            self.navigationController?.setToolbarHidden(false, animated: true)
            self.view.backgroundColor = UIColor.whiteColor()
        } else if self.navigationController?.navigationBarHidden == false && self.navigationController?.toolbarHidden == false {
            self.navigationController?.setNavigationBarHidden(true, animated: true)
            self.navigationController?.setToolbarHidden(true, animated: true)
            self.view.backgroundColor = UIColor.blackColor()
        }
    }


    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        photoImageView.image = photoImage
        
        self.navigationController?.setToolbarHidden(false, animated: true)
        self.view.backgroundColor = UIColor.whiteColor()
        
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
    


}
