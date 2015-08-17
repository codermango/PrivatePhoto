//
//  PhotoPageViewController.swift
//  PrivatePhoto
//
//  Created by Mark on 15/8/15.
//  Copyright (c) 2015年 codermango. All rights reserved.
//

import UIKit

class PhotoPageViewController: UIPageViewController, UIPageViewControllerDataSource {

    var photoIndex: Int!
    var albumPhotos: [UIImage]!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
        // 尝试开始使用UIPageViewController
        var currentVC = viewControllerAtIndex(photoIndex) as UIViewController
        
//        var imageView = UIImageView(frame: self.view.frame)
//        imageView.image = albumPhotos[photoIndex]
//        currentVC.view.addSubview(imageView)
        
        var viewControllers = [currentVC]
        self.dataSource = self
        self.setViewControllers(viewControllers, direction: UIPageViewControllerNavigationDirection.Forward, animated: true, completion: nil)
        
        self.view.frame = CGRectMake(0, 0, self.view.frame.width, self.view.frame.size.height)
        self.didMoveToParentViewController(self)

    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    // MARK: UIPageViewControllerDataSource
    
    func pageViewController(pageViewController: UIPageViewController, viewControllerBeforeViewController viewController: UIViewController) -> UIViewController? {
        var vc = viewController as! PhotoViewController
        var index = vc.photoIndex
        if index == 0 || index == NSNotFound {
            return nil
        }
        index!--
        return self.viewControllerAtIndex(index)
    }
    
    func pageViewController(pageViewController: UIPageViewController, viewControllerAfterViewController viewController: UIViewController) -> UIViewController? {
        var vc = viewController as! PhotoViewController
        var index = vc.photoIndex
        if index == NSNotFound {
            return nil
        }
        index!++
        if index == self.albumPhotos.count {
            return nil
        }
        return self.viewControllerAtIndex(index)
    }
    
    
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */
    
    
    func viewControllerAtIndex(index: Int) -> PhotoViewController {
        var vc = self.storyboard?.instantiateViewControllerWithIdentifier("PhotoViewController") as! PhotoViewController
        vc.photoImage = self.albumPhotos[index]
        vc.photoIndex = index
        return vc
    }
    

}
