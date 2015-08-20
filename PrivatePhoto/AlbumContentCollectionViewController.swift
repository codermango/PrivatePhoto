//
//  AlbumDetailCollectionViewController.swift
//  PrivatePhoto
//
//  Created by Mark on 15/8/4.
//  Copyright (c) 2015年 codermango. All rights reserved.
//

import UIKit

let reuseIdentifier = "PhotoCell"

protocol UpdatePhotoNumberDelegate {
    func updatePhotoNumber(number: Int, index: Int)
}

class AlbumContentCollectionViewController: UICollectionViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    
    var album: Album!
    var delegate: UpdatePhotoNumberDelegate!
    
    var pageViewController: UIPageViewController!

    @IBAction func addPhotos(sender: AnyObject) {
        if UIImagePickerController.isSourceTypeAvailable(UIImagePickerControllerSourceType.PhotoLibrary) {
            let imagePickerController = UIImagePickerController()
            imagePickerController.sourceType = UIImagePickerControllerSourceType.PhotoLibrary
            imagePickerController.delegate = self
            self.presentViewController(imagePickerController, animated: true, completion: nil)
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
        // 给导航栏添加title
//        self.navigationItem.title = album.photoName
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func viewWillAppear(animated: Bool) {
        self.navigationController?.setToolbarHidden(false, animated: true)
    }
    
    override func viewWillDisappear(animated: Bool) {
        self.navigationController?.setToolbarHidden(true, animated: true)
    }

    
    // MARK: - Navigation

//    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
//        if segue.identifier == "toPhotoPage" {
//            if let indexPaths = self.collectionView?.indexPathsForSelectedItems() {
//                let nav = segue.destinationViewController as! UINavigationController
//                let destinationViewController = nav.topViewController as! PhotoPageViewController
//                destinationViewController.photoIndex = indexPaths[0].row
//                destinationViewController.albumPhotos = album.photoArray
//            }
//        }
//    }
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if segue.identifier == "toPhotoPage" {
            if let indexPaths = self.collectionView?.indexPathsForSelectedItems() {
                let destinationViewController = segue.destinationViewController as! PhotoPageViewController
                destinationViewController.photoIndex = indexPaths[0].row
                destinationViewController.albumPhotos = album.photoArray
            }
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
    
    func imagePickerController(picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [NSObject : AnyObject]) {
        let photo = info[UIImagePickerControllerOriginalImage]! as! UIImage
        album.addPhotoByImage(photo)
        picker.dismissViewControllerAnimated(true, completion: nil)
        self.collectionView?.reloadData()
//        self.delegate.updatePhotoNumber(album.photoArray.count, index: albumIndex)
    }

    

    
    
//    // 自定义函数
//    func getAllPhotos() {
//        let albumDirectory = NSHomeDirectory().stringByAppendingPathComponent("Documents/Albums/\(album.photoName)") // Album文件夹
//        
//        let fileManager = NSFileManager.defaultManager()
//        
//        var albumContent = fileManager.contentsOfDirectoryAtPath(albumDirectory, error: nil)!
//        for name in albumContent {
//            let photoPath = albumDirectory.stringByAppendingPathComponent(name as! String)
//            let image = UIImage(contentsOfFile: photoPath)
//            album.photoArray.append(image!)
//           
//        }
//    }
    

    
    

}














