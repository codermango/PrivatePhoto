//
//  AlbumDetailCollectionViewController.swift
//  PrivatePhoto
//
//  Created by Mark on 15/8/4.
//  Copyright (c) 2015年 codermango. All rights reserved.
//

import UIKit

let reuseIdentifier = "PhotoCell"


class AlbumContentCollectionViewController: UICollectionViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    
    var album: Album!
    var selectedPhotoIndex: [Int] = []
    var selectEnabled = false
    var pageViewController: UIPageViewController!
    var toolbar: UIToolbar!


    
    @IBAction func clickSelect(sender: AnyObject) {
        
        if self.selectEnabled { // 为选择界面，则切换回正常界面
            self.selectEnabled = false
            toolbar = createToolBarByStatus("normal")
            self.view.addSubview(toolbar)
            self.navigationItem.rightBarButtonItem?.title = "选择"
            self.selectedPhotoIndex = []
            
        } else {
            self.selectEnabled = true
            toolbar = createToolBarByStatus("select")
            self.view.addSubview(toolbar)
            self.navigationItem.rightBarButtonItem?.title = "取消"
        }
    
    }
    
    
    @IBAction func backToAlbumContentCollectionView(segue: UIStoryboardSegue) {
        
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Register cell classes
        self.collectionView!.registerClass(UICollectionViewCell.self, forCellWithReuseIdentifier: "Cell")

        // Do any additional setup after loading the view.

        self.navigationItem.title = album.albumName
        toolbar = createToolBarByStatus("normal")
        self.view.addSubview(toolbar)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    
    // MARK: - Navigation

    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if segue.identifier == "toPhotoPage" {
            if let indexPaths = self.collectionView?.indexPathsForSelectedItems() {
                let nav = segue.destinationViewController as! UINavigationController
                let destinationViewController = nav.topViewController as! PhotoPageViewController
                destinationViewController.photoIndex = indexPaths[0].row
                destinationViewController.album = album
            }
        }
    }
    
    override func shouldPerformSegueWithIdentifier(identifier: String?, sender: AnyObject?) -> Bool {
        if selectEnabled {
            return false
        } else {
            return true
        }
    }
    

    // MARK: UICollectionViewDataSource

    override func numberOfSectionsInCollectionView(collectionView: UICollectionView) -> Int {
        return 1
    }


    override func collectionView(collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return album.photoArray.count
    }

    override func collectionView(collectionView: UICollectionView, cellForItemAtIndexPath indexPath: NSIndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCellWithReuseIdentifier(reuseIdentifier, forIndexPath: indexPath) as! AlbumContentCollectionViewCell
        cell.imageView.image = album.photoArray[indexPath.row]
        return cell
    }
    

    // MARK: UICollectionViewDelegate
    
    override func collectionView(collectionView: UICollectionView, didSelectItemAtIndexPath indexPath: NSIndexPath) {
        if selectEnabled {
            let selectedCell = collectionView.cellForItemAtIndexPath(indexPath) as! AlbumContentCollectionViewCell
            
            // 如果点击的cell在selectedPhotoIndex中，则删除掉，切变成未选择状态
            if contains(self.selectedPhotoIndex, indexPath.row) {
                let index = find(self.selectedPhotoIndex, indexPath.row)
                self.selectedPhotoIndex.removeAtIndex(index!)
                selectedCell.alpha = 1.0
            } else {
                self.selectedPhotoIndex.append(indexPath.row)
                selectedCell.alpha = 0.3
            }
            println(self.selectedPhotoIndex)
        }
    }
    
    
    
    
    
    // MARK: UIImagePickerControllerDelegate
    
    func imagePickerController(picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [NSObject : AnyObject]) {
        let photo = info[UIImagePickerControllerOriginalImage]! as! UIImage
        album.addPhotoByImage(photo)
        picker.dismissViewControllerAnimated(true, completion: nil)
        self.collectionView?.reloadData()
    }

    
    
    // 自定义
    
    func createToolBarByStatus(status: String) -> UIToolbar {
        let toolbar = UIToolbar(frame: CGRectMake(0, UIScreen.mainScreen().bounds.size.height - 44, self.view.frame.width, 44))
        let flexibleSpace = UIBarButtonItem(barButtonSystemItem: UIBarButtonSystemItem.FlexibleSpace, target: nil, action: nil)
        if status == "normal" {
            let addPhotoItem = UIBarButtonItem(title: "添加", style: UIBarButtonItemStyle.Plain, target: self, action: "addPhotos")
            toolbar.setItems([flexibleSpace, addPhotoItem, flexibleSpace], animated: true)
        } else if status == "select" {
            let deletePhotoItem = UIBarButtonItem(barButtonSystemItem: UIBarButtonSystemItem.Trash, target: self, action: nil)
            toolbar.setItems([flexibleSpace, deletePhotoItem], animated: true)
        }
        return toolbar
    }
    
    func addPhotos() {
        if UIImagePickerController.isSourceTypeAvailable(UIImagePickerControllerSourceType.PhotoLibrary) {
            let imagePickerController = UIImagePickerController()
            imagePickerController.sourceType = UIImagePickerControllerSourceType.PhotoLibrary
            imagePickerController.delegate = self
            self.presentViewController(imagePickerController, animated: true, completion: nil)
        }
        
    }
    
    
    
    
    
}














