//
//  Setting.swift
//  PrivatePhoto
//
//  Created by Mark on 15/8/21.
//  Copyright (c) 2015年 codermango. All rights reserved.
//

import Foundation

class Setting {
    
    init () {
        // 读取plist文件获取登陆密码
        // 检查setting.plist是否存在，如果不存在则创建
        let settingPath = NSHomeDirectory().stringByAppendingPathComponent("Library/Preferences/setting.plist")
        let fileManager = NSFileManager.defaultManager()
        if !fileManager.fileExistsAtPath(settingPath) {
            if let bundlePath = NSBundle.mainBundle().pathForResource("setting", ofType: "plist") {
                fileManager.copyItemAtPath(bundlePath, toPath: settingPath, error: nil)
                var data = NSMutableDictionary(dictionary: ["launchPassword": ""])
                data.writeToFile(settingPath, atomically: true)
            }
        }
        
    }
    
    func getLaunchPassword() -> String {
        let settingPath = NSHomeDirectory().stringByAppendingPathComponent("Library/Preferences/setting.plist")
        let fileManager = NSFileManager.defaultManager()
        var data = NSMutableDictionary(contentsOfFile: settingPath)
        return data?.valueForKey("launchPassword") as! String
    }
}