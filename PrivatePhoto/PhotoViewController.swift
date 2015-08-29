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
    var navigationBarHidden: Bool!
    var toolbarHidden: Bool!
    var bgColor: UIColor!

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
    


}
