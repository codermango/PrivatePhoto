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
    var albumIndex: Int!
    var delegate: UpdatePhotoNumberDelegate!

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
        self.navigationItem.title = album.photoName
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

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if segue.identifier == "toPhotoView" {
            if let indexPaths = self.collectionView?.indexPathsForSelectedItems() {
                let nav = segue.destinationViewController as! UINavigationController
                let destinationViewController = nav.topViewController as! PhotoViewController
                destinationViewController.photoImage = album.photoArray[indexPaths[0].row]
            }
        }
    }
    

    // MARK: UICollectionViewDataSource

    override func numberOfSectionsInCollectionView(collectionView: UICollectionView) -> Int {
        //#warning Incomplete method implementation -- Return the number of sections
        return 1
    }


    override func collectionView(collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        //#warning Incomplete method implementation -- Return the number of items in the section
        return album.photoArray.count
    }

    override func collectionView(collectionView: UICollectionView, cellForItemAtIndexPath indexPath: NSIndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCellWithReuseIdentifier(reuseIdentifier, forIndexPath: indexPath) as! AlbumContentCollectionViewCell
    
//        println(album.photoArray.count)
        cell.imageView.image = album.photoArray[indexPath.row]
    
        return cell
    }

    // MARK: UICollectionViewDelegate

    /*
    // Uncomment this method to specify if the specified item should be highlighted during tracking
    override func collectionView(collectionView: UICollectionView, shouldHighlightItemAtIndexPath indexPath: NSIndexPath) -> Bool {
        return true
    }
    */

    /*
    // Uncomment this method to specify if the specified item should be selected
    override func collectionView(collectionView: UICollectionView, shouldSelectItemAtIndexPath indexPath: NSIndexPath) -> Bool {
        return true
    }
    */

    /*
    // Uncomment these methods to specify if an action menu should be displayed for the specified item, and react to actions performed on the item
    override func collectionView(collectionView: UICollectionView, shouldShowMenuForItemAtIndexPath indexPath: NSIndexPath) -> Bool {
        return false
    }

    override func collectionView(collectionView: UICollectionView, canPerformAction action: Selector, forItemAtIndexPath indexPath: NSIndexPath, withSender sender: AnyObject?) -> Bool {
        return false
    }

    override func collectionView(collectionView: UICollectionView, performAction action: Selector, forItemAtIndexPath indexPath: NSIndexPath, withSender sender: AnyObject?) {
    
    }
    */
    
    
    // UIImagePickerControllerDelegate
    func imagePickerController(picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [NSObject : AnyObject]) {
        let photo = info[UIImagePickerControllerOriginalImage]! as! UIImage
        let nowDate = NSDate()
        let formatter = NSDateFormatter()
        formatter.dateFormat = "yyyy-MM-dd-HH-mm-ss"
        let dateString = formatter.stringFromDate(nowDate)
        let photoName = dateString
        album.photoArray.append(photo)
        picker.dismissViewControllerAnimated(true, completion: nil)
        self.collectionView?.reloadData()
        
        //把选择的图片存到文件系统Album
        let photoPath = NSHomeDirectory().stringByAppendingPathComponent("Documents/Albums/\(album.photoName)/\(photoName).png")
        let pngData = UIImagePNGRepresentation(photo)
        pngData.writeToFile(photoPath, atomically: true)
        self.delegate.updatePhotoNumber(album.photoArray.count, index: albumIndex)
    }

    
    
    // 自定义函数
    func getAllPhotos() {
        let albumDirectory = NSHomeDirectory().stringByAppendingPathComponent("Documents/Albums/\(album.photoName)") // Album文件夹
        
        let fileManager = NSFileManager.defaultManager()
        
        var albumContent = fileManager.contentsOfDirectoryAtPath(albumDirectory, error: nil)!
        for name in albumContent {
            let photoPath = albumDirectory.stringByAppendingPathComponent(name as! String)
            let image = UIImage(contentsOfFile: photoPath)
            album.photoArray.append(image!)
           
        }
    }
    
    

}
