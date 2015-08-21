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
    var album: Album!
    
    @IBAction func deletePhoto(sender: AnyObject) {
        // 先获取要删除的照片，分别从privatePhoto和文件夹中将其删除
        let alertController = UIAlertController(title: nil, message: nil, preferredStyle: UIAlertControllerStyle.ActionSheet)
        let deleteAction = UIAlertAction(title: "删除照片", style: UIAlertActionStyle.Default) { (action: UIAlertAction!) -> Void in
            self.album.deletePhotoByIndex(self.photoIndex)
            self.dismissViewControllerAnimated(true, completion: nil)
        }
        let cancelAction = UIAlertAction(title: "取消", style: UIAlertActionStyle.Cancel, handler: nil)
        alertController.addAction(deleteAction)
        alertController.addAction(cancelAction)
        self.presentViewController(alertController, animated: true, completion: nil)
        
        

    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        self.automaticallyAdjustsScrollViewInsets = false;
        // 尝试开始使用UIPageViewController
        var currentVC = viewControllerAtIndex(photoIndex) as UIViewController
        var viewControllers = [currentVC]
        self.dataSource = self
        self.setViewControllers(viewControllers, direction: UIPageViewControllerNavigationDirection.Forward, animated: true, completion: nil)
        self.didMoveToParentViewController(self)

    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    // MARK: UIPageViewControllerDataSource
    
    func pageViewController(pageViewController: UIPageViewController, viewControllerBeforeViewController viewController: UIViewController) -> UIViewController? {
        var vc = viewController as! PhotoViewController
        self.photoIndex = vc.photoIndex
        if self.photoIndex == 0 || self.photoIndex == NSNotFound {
            return nil
        }
        self.photoIndex!--
        return self.viewControllerAtIndex(self.photoIndex)
    }
    
    func pageViewController(pageViewController: UIPageViewController, viewControllerAfterViewController viewController: UIViewController) -> UIViewController? {
        var vc = viewController as! PhotoViewController
        self.photoIndex = vc.photoIndex
        if self.photoIndex == NSNotFound {
            return nil
        }
        self.photoIndex!++
        if self.photoIndex == self.album.photoArray.count {
            return nil
        }
        return self.viewControllerAtIndex(self.photoIndex)
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
        vc.photoImage = self.album.photoArray[index]
        vc.photoIndex = index
        return vc
    }
    

}
