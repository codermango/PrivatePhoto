//
//  Album.swift
//  PrivatePhoto
//
//  Created by Mark on 15/8/4.
//  Copyright (c) 2015年 codermango. All rights reserved.
//

import Foundation
import UIKit

class Album {
    var photoArray: [UIImage]!
    var albumName: String!
    
    init(name: String, photos: [UIImage]) {
        self.albumName = name
        self.photoArray = photos
    }
    
    
    func addPhotoByImage(image: UIImage) {
        let nowDate = NSDate()
        let formatter = NSDateFormatter()
        formatter.dateFormat = "yyyy-MM-dd-HH-mm-ss"
        let dateString = formatter.stringFromDate(nowDate)
        let photoName = dateString
        photoArray.append(image) // 把图片加入到当前的相册Array中，接下来存到手机中
        
        let photoPath = NSHomeDirectory().stringByAppendingPathComponent("Documents/Albums/\(albumName)/\(photoName).png")
        let pngData = UIImagePNGRepresentation(image)
        if !pngData.writeToFile(photoPath, atomically: true) {
            println("新增图片保存失败！")
        }

    }
    
    
}
