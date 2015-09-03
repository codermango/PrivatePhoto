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
    
    init () {
        // 读取plist文件获取登陆密码
        // 检查setting.plist是否存在，如果不存在则创建
        let settingDir = NSBundle.mainBundle().pathForResource("setting", ofType: "plist")
        println(settingDir)
    }
}