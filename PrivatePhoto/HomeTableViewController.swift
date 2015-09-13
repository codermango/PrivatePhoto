//
//  HomeTableViewController.swift
//  PrivatePhoto
//
//  Created by Mark on 15/8/3.
//  Copyright (c) 2015年 codermango. All rights reserved.
//

import UIKit

class HomeTableViewController: UITableViewController {
    
    var privatePhoto: Privatephoto!
    
    
    @IBAction func addAlbum(sender: AnyObject) {
        let addAlbumAlertController = UIAlertController(title: "新相册", message: "请输入相册名称", preferredStyle: UIAlertControllerStyle.Alert)
            addAlbumAlertController.addTextFieldWithConfigurationHandler { (textField: UITextField!) -> Void in
            textField.placeholder = "相册名"
        }
        
        let cancelAction = UIAlertAction(title: "取消", style: UIAlertActionStyle.Cancel, handler: nil)
        let saveAction = UIAlertAction(title: "保存", style: UIAlertActionStyle.Default) { (action: UIAlertAction!) -> Void in
            // 点击保存之后新建一个相册，并存到albumArray中
            let newAlbumNameTextField = addAlbumAlertController.textFields?.first as! UITextField
            let newAlbumName = newAlbumNameTextField.text
            
            self.privatePhoto.createAlbumWithName(newAlbumName)
            self.tableView.reloadData()
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
        
        privatePhoto = Privatephoto()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func viewWillAppear(animated: Bool) {
        self.tableView.reloadData()
    }

    // MARK: - Table view data source

    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1
    }

    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.privatePhoto.albumArray.count
    }

    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = self.tableView.dequeueReusableCellWithIdentifier("AlbumCell", forIndexPath: indexPath) as! AlbumTableViewCell
        cell.albumImageView1.image = privatePhoto.albumArray[indexPath.row].photoArray[0].photoImage
        cell.albumImageView2.image = privatePhoto.albumArray[indexPath.row].photoArray[1].photoImage
        cell.albumImageView3.image = privatePhoto.albumArray[indexPath.row].photoArray[2].photoImage

        cell.albumNameLabel.text = privatePhoto.albumArray[indexPath.row].albumName
        cell.albumPhotoNumberLabel.text = String(privatePhoto.albumArray[indexPath.row].photoArray.count)
        return cell
    }
    

    /*
    // Override to support conditional editing of the table view.
    override func tableView(tableView: UITableView, canEditRowAtIndexPath indexPath: NSIndexPath) -> Bool {
        // Return NO if you do not want the specified item to be editable.
        return true
    }
    */

    
    // Override to support editing the table view.
    override func tableView(tableView: UITableView, commitEditingStyle editingStyle: UITableViewCellEditingStyle, forRowAtIndexPath indexPath: NSIndexPath) {
        if editingStyle == .Delete {
            // 弹出对话框询问是否删除
            let confirmAlertController = UIAlertController(title: "", message: "删除相册后相册内所有照片将要被删除！", preferredStyle: UIAlertControllerStyle.Alert)
            let okAction = UIAlertAction(title: "确定", style: UIAlertActionStyle.Default, handler: { (action: UIAlertAction!) -> Void in
                self.privatePhoto.deleteAlbumByIndex(indexPath.row)
                tableView.deleteRowsAtIndexPaths([indexPath], withRowAnimation: .Fade)
            })
            let cancelAction = UIAlertAction(title: "取消", style: UIAlertActionStyle.Cancel, handler: nil)
            confirmAlertController.addAction(okAction)
            confirmAlertController.addAction(cancelAction)
            self.presentViewController(confirmAlertController, animated: true, completion: nil)
            
        }
    }


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
                let tappedAlbum = privatePhoto.albumArray[indexPath.row]
                destinationViewController.album = tappedAlbum
            }
            
        }
        
    }

    

}
