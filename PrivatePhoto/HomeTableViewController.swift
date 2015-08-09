//
//  HomeTableViewController.swift
//  PrivatePhoto
//
//  Created by Mark on 15/8/3.
//  Copyright (c) 2015年 codermango. All rights reserved.
//

import UIKit

class HomeTableViewController: UITableViewController, UpdatePhotoNumberDelegate {
    
    struct AlbumForShow {
        var name: String!
        var number: Int!
        var picture: UIImage!
    }
    
    var albumForShowArray: [AlbumForShow] = []
    
    @IBAction func addAlbum(sender: AnyObject) {
        let addAlbumAlertController = UIAlertController(title: "新相册", message: "请输入相册名称", preferredStyle: UIAlertControllerStyle.Alert)
        addAlbumAlertController.addTextFieldWithConfigurationHandler { (textField: UITextField!) -> Void in
            textField.placeholder = "相册名"
        }
        
        let cancelAction = UIAlertAction(title: "取消", style: UIAlertActionStyle.Cancel, handler: nil)
        let saveAction = UIAlertAction(title: "保存", style: UIAlertActionStyle.Default) { (action: UIAlertAction!) -> Void in
            // 点击保存之后新建一个相册，并存到albumArray中
            let newAlbumNameTextField = addAlbumAlertController.textFields?.first as! UITextField
            var albumForShow = AlbumForShow()
            albumForShow.name = newAlbumNameTextField.text
            self.albumForShowArray.append(albumForShow)
            self.tableView.reloadData()
            
            // 在沙盒NSHomeDirectory中的Documents文件夹中新建用户新建的文件夹
            let albumPath = NSHomeDirectory().stringByAppendingPathComponent("Documents/Albums/\(albumForShow.name)")
            let fileManager = NSFileManager.defaultManager()
            fileManager.createDirectoryAtPath(albumPath, withIntermediateDirectories: false, attributes: nil, error: nil)
        }
        addAlbumAlertController.addAction(cancelAction)
        addAlbumAlertController.addAction(saveAction)

        self.presentViewController(addAlbumAlertController, animated: true, completion: nil)

    }

    override func viewDidLoad() {
        super.viewDidLoad()

        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem()
        
        createAlbumsFolder() // 新建Albums文件夹
        getAllAlbums() //获取所有相册，显示在首页

    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        self.tableView.reloadData()
    }

    // MARK: - Table view data source

    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1
    }

    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.albumForShowArray.count
    }

    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = self.tableView.dequeueReusableCellWithIdentifier("AlbumCell", forIndexPath: indexPath) as! AlbumTableViewCell
        let albumForShow = albumForShowArray[indexPath.row]
        cell.albumNameLabel.text = albumForShow.name
        cell.albumPhotoNumberLabel.text = String(albumForShow.number)

        return cell
    }
    

    /*
    // Override to support conditional editing of the table view.
    override func tableView(tableView: UITableView, canEditRowAtIndexPath indexPath: NSIndexPath) -> Bool {
        // Return NO if you do not want the specified item to be editable.
        return true
    }
    */

    /*
    // Override to support editing the table view.
    override func tableView(tableView: UITableView, commitEditingStyle editingStyle: UITableViewCellEditingStyle, forRowAtIndexPath indexPath: NSIndexPath) {
        if editingStyle == .Delete {
            // Delete the row from the data source
            tableView.deleteRowsAtIndexPaths([indexPath], withRowAnimation: .Fade)
        } else if editingStyle == .Insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }    
    }
    */

    /*
    // Override to support rearranging the table view.
    override func tableView(tableView: UITableView, moveRowAtIndexPath fromIndexPath: NSIndexPath, toIndexPath: NSIndexPath) {

    }
    */

    /*
    // Override to support conditional rearranging of the table view.
    override func tableView(tableView: UITableView, canMoveRowAtIndexPath indexPath: NSIndexPath) -> Bool {
        // Return NO if you do not want the item to be re-orderable.
        return true
    }
    */

    
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using [segue destinationViewController].
        // Pass the selected object to the new view controller.
        if segue.identifier == "toAlbumContent" {
            if let indexPath = self.tableView.indexPathForSelectedRow() {
                let destinationViewController = segue.destinationViewController as! AlbumContentCollectionViewController
                // 获取点击的相册中所有照片，存入albumArray中对应的album
                let albumForShow = albumForShowArray[indexPath.row]
                
                let albumName = albumForShow.name
                var albumPhotos: [UIImage] = []
                
                let albumPath = NSHomeDirectory().stringByAppendingPathComponent("Documents/Albums/\(albumName)")
                let fileManager = NSFileManager.defaultManager()
                let photos = fileManager.contentsOfDirectoryAtPath(albumPath, error: nil)!
                
                for photo in photos {
                    var photoPath = albumPath.stringByAppendingPathComponent(photo as! String)
                    var image = UIImage(contentsOfFile: photoPath)
                    if (image != nil) {
                        albumPhotos.append(image!)
                    }
                }
                let album = Album(name: albumName, photos: albumPhotos)
                destinationViewController.album = album
                destinationViewController.albumIndex = indexPath.row
                destinationViewController.delegate = self
            }
            
        }
        
    }
    
    
    // 自定义函数
    
    func createAlbumsFolder() {
        let albumsDirectory = NSHomeDirectory().stringByAppendingPathComponent("Documents/Albums") // Albums文件夹
        let fileManager = NSFileManager.defaultManager()
        if !fileManager.fileExistsAtPath(albumsDirectory) {
            // Albums文件夹不存在，则新建Albums文件夹
            fileManager.createDirectoryAtPath(albumsDirectory, withIntermediateDirectories: false, attributes: nil, error: nil)
        }
    }
    
    // 首页出现时运行
    func getAllAlbums() {
        let albumsDirectory = NSHomeDirectory().stringByAppendingPathComponent("Documents/Albums") // Albums文件夹
        let fileManager = NSFileManager.defaultManager()
        let albumsContent = fileManager.contentsOfDirectoryAtPath(albumsDirectory, error: nil)!
        
        for albumName in albumsContent {
            var albumPath = albumsDirectory.stringByAppendingPathComponent(albumName as! String)
            var content = fileManager.contentsOfDirectoryAtPath(albumPath, error: nil)!
            var photoNumber = content.count
            var albumForShow = AlbumForShow()
            albumForShow.name = albumName as! String
            albumForShow.number = photoNumber
            albumForShowArray.append(albumForShow)
        }
    }
    
    func updatePhotoNumber(number: Int, index: Int) {
        self.albumForShowArray[index].number = number
    }

    

}
