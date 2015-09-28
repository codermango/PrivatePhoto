//
//  AlbumDetailCollectionViewController.swift
//  PrivatePhoto
//
//  Created by Mark on 15/8/4.
//  Copyright (c) 2015年 codermango. All rights reserved.
//

import UIKit

let reuseIdentifier = "PhotoCell"


class AlbumContentCollectionViewController: UICollectionViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate, UICollectionViewDelegateFlowLayout {
    
    var album: Album!
    var selectEnabled = false
    var pageViewController: UIPageViewController!
    var toolbar: UIToolbar = UIToolbar(frame: CGRectMake(0, UIScreen.mainScreen().bounds.size.height - 44, UIScreen.mainScreen().bounds.size.width, 44))
    
    var selectedIndexPathArray: [NSIndexPath] = []


    @IBOutlet var albumCollectionView: UICollectionView!

    
    @IBAction func clickSelect(sender: AnyObject) {
        
        if self.selectEnabled { // 为选择界面，则切换回正常界面
            self.selectEnabled = false
            self.navigationItem.hidesBackButton = false
            toolbar = createToolBarByStatus("normal")
            self.view.addSubview(toolbar)
            self.navigationItem.rightBarButtonItem?.title = "选择"
            self.selectedIndexPathArray = []
            self.collectionView?.reloadData()
            
        } else {
            self.selectEnabled = true
            toolbar = createToolBarByStatus("select")
            let items = toolbar.items! as [UIBarButtonItem]
            for item in items {
                item.enabled = false
            }
            self.view.addSubview(toolbar)
            self.navigationItem.rightBarButtonItem?.title = "取消"
            self.navigationItem.hidesBackButton = true
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
        let layout: UICollectionViewFlowLayout! = self.albumCollectionView.collectionViewLayout as! UICollectionViewFlowLayout
        let availableWidthForCells: CGFloat = CGRectGetWidth(self.albumCollectionView.frame) - layout.sectionInset.left - layout.sectionInset.right - layout.minimumInteritemSpacing * 3
        let cellWidth = availableWidthForCells / 4
        layout.itemSize = CGSizeMake(cellWidth, cellWidth)

        
        
        toolbar = createToolBarByStatus("normal")
        self.collectionView?.alwaysBounceVertical = true
        
        
        
        self.navigationItem.title = album.albumName
        
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
                destinationViewController.previousController = self
            }
        }
    }
    
    override func shouldPerformSegueWithIdentifier(identifier: String, sender: AnyObject?) -> Bool {
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

        cell.imageView.alpha = 1.0
        cell.imageView.image = album.photoArray[indexPath.row].photoImage
        if self.selectedIndexPathArray.contains(indexPath) {
            cell.imageView.alpha = 0.3
        }
        return cell
    }
    

    // MARK: UICollectionViewDelegate
    
    override func collectionView(collectionView: UICollectionView, didSelectItemAtIndexPath indexPath: NSIndexPath) {
        if selectEnabled {
            let selectedCell = collectionView.cellForItemAtIndexPath(indexPath) as! AlbumContentCollectionViewCell
            // 如果点击的cell在selectedPhotoIndex中，则删除掉，切变成未选择状态
            if self.selectedIndexPathArray.contains(indexPath) {
                let index = self.selectedIndexPathArray.indexOf(indexPath)
                self.selectedIndexPathArray.removeAtIndex(index!)
                selectedCell.imageView.alpha = 1.0
            } else {
                self.selectedIndexPathArray.append(indexPath)
                selectedCell.imageView.alpha = 0.3
            }
            
            let items = toolbar.items! as [UIBarButtonItem]
            if self.selectedIndexPathArray.isEmpty {
                for item in items {
                    item.enabled = false
                }
            } else {
                for item in items {
                    item.enabled = true
                }
            }

            print(self.selectedIndexPathArray)
        }
    }
    
    
    
    
    // MARK: UIImagePickerControllerDelegate
    
    func imagePickerController(picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : AnyObject]) {
        let image = info[UIImagePickerControllerOriginalImage]! as! UIImage
        album.addPhotoByImage(image)
        picker.dismissViewControllerAnimated(true, completion: nil)
        self.collectionView?.reloadData()
    }

    
    
    // 自定义
    
    func createToolBarByStatus(status: String) -> UIToolbar {
        toolbar.items = []
        let flexibleSpace = UIBarButtonItem(barButtonSystemItem: UIBarButtonSystemItem.FlexibleSpace, target: nil, action: nil)
        if status == "normal" {
            let addPhotoItem = UIBarButtonItem(title: "添加", style: UIBarButtonItemStyle.Plain, target: self, action: "addPhotos")
            toolbar.setItems([flexibleSpace, addPhotoItem, flexibleSpace], animated: true)
        } else if status == "select" {
            let deletePhotoItem = UIBarButtonItem(barButtonSystemItem: UIBarButtonSystemItem.Trash, target: self, action: "deletePhotos")
            let actionItem = UIBarButtonItem(barButtonSystemItem: UIBarButtonSystemItem.Action, target: self, action: "showActions")
            toolbar.setItems([actionItem, flexibleSpace, deletePhotoItem], animated: true)
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
    
    func deletePhotos() {
        self.selectedIndexPathArray.sortInPlace({$0.row > $1.row}) // 排序是为了删除时不会产生索引错误
        let numOfDeletePhotos = self.selectedIndexPathArray.count
        let alertController = UIAlertController(title: nil, message: nil, preferredStyle: UIAlertControllerStyle.ActionSheet)
        let cancelActioin = UIAlertAction(title: "取消", style: UIAlertActionStyle.Cancel, handler: nil)
        let deleteAction = UIAlertAction(title: "删除\(numOfDeletePhotos)张图片", style: UIAlertActionStyle.Destructive) { (action: UIAlertAction) -> Void in
            for indexPath in self.selectedIndexPathArray {
                self.album.deletePhotoByIndex(indexPath.row)
            }
            self.collectionView?.deleteItemsAtIndexPaths(self.selectedIndexPathArray)
            
            self.selectedIndexPathArray = []
            let items = self.toolbar.items! as [UIBarButtonItem]
            for item in items {
                item.enabled = false
            }
            
        }
        
        alertController.addAction(deleteAction)
        alertController.addAction(cancelActioin)
        self.presentViewController(alertController, animated: true, completion: nil)
    }
    
    
    func showActions() {
        let alertController = UIAlertController(title: nil, message: nil, preferredStyle: UIAlertControllerStyle.ActionSheet)
        let cancelActioin = UIAlertAction(title: "取消", style: UIAlertActionStyle.Cancel, handler: nil)
        let saveAction = UIAlertAction(title: "保存图片", style: UIAlertActionStyle.Default) { (action: UIAlertAction) -> Void in
            self.album.savePhotoToSystemAlbumByIndex(self.selectedIndexPathArray.map({$0.row}))
            self.selectedIndexPathArray = []
            self.collectionView?.reloadData()
        }
        alertController.addAction(saveAction)
        alertController.addAction(cancelActioin)
        self.presentViewController(alertController, animated: true, completion: nil)
    }
    
}














