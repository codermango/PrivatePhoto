//
//  SettingTableViewController.swift
//  PrivatePhoto
//
//  Created by Mark on 15/9/6.
//  Copyright (c) 2015年 codermango. All rights reserved.
//

import UIKit

class SettingTableViewController: UITableViewController {
    
    

    override func viewDidLoad() {
        super.viewDidLoad()

        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    // MARK: - Table view data source

    override func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        let setting = Setting()
        if setting.isPasswordSet() {
            self.performSegueWithIdentifier("toSetNewPassword", sender: self)
        } else {
            self.performSegueWithIdentifier("toCreatePassword", sender: self)
        }
        
    }



    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using [segue destinationViewController].
        // Pass the selected object to the new view controller.
    }
    */

}
