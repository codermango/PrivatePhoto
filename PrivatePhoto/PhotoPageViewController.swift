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
            
            var currentVC: PhotoViewController!
            if self.photoIndex == self.album.photoArray.count - 1 { // 如果是最后一张，删除后向前移动一张，否则都向后移动一张
                currentVC = self.viewControllerAtIndex(self.photoIndex - 1)
                self.album.deletePhotoByIndex(self.photoIndex)
                self.setViewControllers([currentVC], direction: UIPageViewControllerNavigationDirection.Reverse, animated: true, completion: nil)
                
            } else {
                currentVC = self.viewControllerAtIndex(self.photoIndex + 1)
                currentVC.photoIndex = currentVC.photoIndex - 1
                self.album.deletePhotoByIndex(self.photoIndex)
                self.setViewControllers([currentVC], direction: UIPageViewControllerNavigationDirection.Forward, animated: true, completion: nil)
            }

        }
        let cancelAction = UIAlertAction(title: "取消", style: UIAlertActionStyle.Cancel, handler: nil)
        alertController.addAction(deleteAction)
        alertController.addAction(cancelAction)
        self.presentViewController(alertController, animated: true, completion: nil)
        
        

    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
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
        if index == self.album.photoArray.count {
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
        vc.photoImage = self.album.photoArray[index]
        vc.photoIndex = index
        return vc
    }
    

}
