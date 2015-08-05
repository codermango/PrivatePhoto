//
//  HomeTableViewController.swift
//  PrivatePhoto
//
//  Created by Mark on 15/8/3.
//  Copyright (c) 2015年 codermango. All rights reserved.
//

import UIKit

class HomeTableViewController: UITableViewController {
    
    var albumArray: [Album] = []
    
    @IBAction func addAlbum(sender: AnyObject) {
        let addAlbumAlertController = UIAlertController(title: "新相册", message: "请输入相册名称", preferredStyle: UIAlertControllerStyle.Alert)
        addAlbumAlertController.addTextFieldWithConfigurationHandler { (textField: UITextField!) -> Void in
            textField.placeholder = "相册名"
        }
        
        let cancelAction = UIAlertAction(title: "取消", style: UIAlertActionStyle.Cancel, handler: nil)
        let saveAction = UIAlertAction(title: "保存", style: UIAlertActionStyle.Default) { (action: UIAlertAction!) -> Void in
            // 点击保存之后新建一个相册，并存到albumArray中
            let newAlbumNameTextField = addAlbumAlertController.textFields?.first as! UITextField
            var album = Album()
            album.name = newAlbumNameTextField.text
            self.albumArray.append(album)
            self.tableView.reloadData()
            
            // 在沙盒NSHomeDirectory中的Documents文件夹中新建Albums文件夹，用于存放相册
            let homeDirectory = NSHomeDirectory() as String // 沙盒根路径
            let documentsDirectory = homeDirectory.stringByAppendingPathComponent("Documents") // Documents路径
            let albumsDirectory = documentsDirectory.stringByAppendingPathComponent("Albums") // Albums文件夹
            let fileManager = NSFileManager.defaultManager()
            let albumDirector = albumsDirectory.stringByAppendingPathComponent(album.name)
            fileManager.createDirectoryAtPath(albumDirector, withIntermediateDirectories: false, attributes: nil, error: nil)
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

    // MARK: - Table view data source

    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1
    }

    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.albumArray.count
    }

    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = self.tableView.dequeueReusableCellWithIdentifier("AlbumCell", forIndexPath: indexPath) as! AlbumTableViewCell
        let album = albumArray[indexPath.row]
        cell.albumNameLabel.text = album.name
        cell.albumPhotoNumberLabel.text = String(album.photoArray.count)

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
                destinationViewController.album = albumArray[indexPath.row]
            }
            
        }
        
    }
    
    
    // 自定义函数
    
    func createAlbumsFolder() {
        let homeDirectory = NSHomeDirectory() as String // 沙盒根路径
        let documentsDirectory = homeDirectory.stringByAppendingPathComponent("Documents") // Documents路径
        let albumsDirectory = documentsDirectory.stringByAppendingPathComponent("Albums") // Albums文件夹
        let fileManager = NSFileManager.defaultManager()
        if !fileManager.fileExistsAtPath(albumsDirectory) {
            // Albums文件夹不存在，则新建Albums文件夹
            fileManager.createDirectoryAtPath(albumsDirectory, withIntermediateDirectories: false, attributes: nil, error: nil)
        }
    }
    
    func getAllAlbums() {
        let homeDirectory = NSHomeDirectory() as String // 沙盒根路径
        let documentsDirectory = homeDirectory.stringByAppendingPathComponent("Documents") // Documents路径
        let albumsDirectory = documentsDirectory.stringByAppendingPathComponent("Albums") // Albums文件夹
        let fileManager = NSFileManager.defaultManager()

        var albumsContent = fileManager.contentsOfDirectoryAtPath(albumsDirectory, error: nil)!
        for name in albumsContent {
            var album = Album()
            album.name = name as! String
            albumArray.append(album)
        }
    }
    

}
