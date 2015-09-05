//
//  Setting.swift
//  PrivatePhoto
//
//  Created by Mark on 15/8/21.
//  Copyright (c) 2015年 codermango. All rights reserved.
//

import Foundation

class Setting {
    
    var launchPassword: String!
    
    init() {
        if let password = NSUserDefaults.standardUserDefaults().valueForKey("launchPassword") as? String {
            launchPassword = password
        }
    }
    
    
    func createPassword(password: String) {
        NSUserDefaults.standardUserDefaults().setObject(password, forKey: "launchPassword")
    }
    
    func modifyPassword(newPassword: String) {
        NSUserDefaults.standardUserDefaults().setValue(newPassword, forKey: "launchPassword")
    }
    
}