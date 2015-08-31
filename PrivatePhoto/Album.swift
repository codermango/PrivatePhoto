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
    var photoArray: [Photo]!
    var albumName: String!
    
    init(name: String, photos: [Photo]) {
        self.albumName = name
        self.photoArray = photos
    }
    
    
    func addPhotoByImage(image: UIImage) {
        let nowDate = NSDate()
        let formatter = NSDateFormatter()
        formatter.dateFormat = "yyyy-MM-dd-HH-mm-ss"
        let dateString = formatter.stringFromDate(nowDate)
        let photoName = dateString
        let photo = Photo(name: photoName, image: image, isSelected: false)
        photoArray.append(photo) // 把图片加入到当前的相册Array中，接下来存到手机中
        
        let photoPath = NSHomeDirectory().stringByAppendingPathComponent("Documents/Albums/\(albumName)/\(photoName).png")
        let pngData = UIImagePNGRepresentation(image)
        if !pngData.writeToFile(photoPath, atomically: true) {
            println("新增图片保存失败！")
        }

    }
    
    func deletePhotoByIndex(index: Int) {
        photoArray.removeAtIndex(index)
        let albumPath = NSHomeDirectory().stringByAppendingPathComponent("Documents/Albums/\(albumName)")
        let sortedPhotoPath = sortedFileOrFolderPathsByCreationDate(albumPath)
        let deletePhotoPath = sortedPhotoPath[index]
        let fileManager = NSFileManager.defaultManager()
        if !fileManager.removeItemAtPath(deletePhotoPath, error: nil) {
            println("删除照片失败")
        }
    }
    
    
    
    // 取出文件夹中所有文件路径，按创建日期升序放到Array中返回，返回的是完整路径
    private func sortedFileOrFolderPathsByCreationDate(path: String) -> [String] {
        var filePathArray: [String] = []
        let fileManager = NSFileManager.defaultManager()
        let contents = fileManager.contentsOfDirectoryAtPath(path, error: nil) as! [String]
        for item in contents {
            if startsWith(item, ".") {
                continue
            }
            var filePath = path + "/" + item
            filePathArray.append(filePath)
        }
        
        // 排序 升序
        var sortedFilesArray = filePathArray.sorted { (file1: String, file2: String) -> Bool in
            var attr1 = fileManager.attributesOfItemAtPath(file1, error: nil)!
            var attr2 = fileManager.attributesOfItemAtPath(file2, error: nil)!
            var date1 = attr1[NSFileCreationDate]! as! NSDate
            var date2 = attr2[NSFileCreationDate]! as! NSDate
            if date1.timeIntervalSinceDate(date2) < 0 {
                return true
            } else {
                return false
            }
        }
        return sortedFilesArray
    }
    
}
