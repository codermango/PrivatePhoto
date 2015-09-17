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
        
//        let photoPath = NSHomeDirectory().stringByAppendingPathComponent("Documents/Albums/\(albumName)/\(photoName).png")
        let photoPath = NSHomeDirectory() + "/Documents/Albums/" + albumName + "/" + photoName + ".png"

        let pngData = UIImagePNGRepresentation(image)
        if !pngData!.writeToFile(photoPath, atomically: true) {
            print("新增图片保存失败！")
        }

    }
    
    func deletePhotoByIndex(index: Int) {
        photoArray.removeAtIndex(index)
//        let albumPath = NSHomeDirectory().stringByAppendingPathComponent("Documents/Albums/\(albumName)")
        let albumPath = NSHomeDirectory() + "/Documents/Albums/" + albumName
        let sortedPhotoPath = sortedFileOrFolderPathsByCreationDate(albumPath)
        let deletePhotoPath = sortedPhotoPath[index]
        let fileManager = NSFileManager.defaultManager()
        do {
            try fileManager.removeItemAtPath(deletePhotoPath)
        } catch _ {
            print("删除照片失败")
        }
    }
    
    func savePhotoToSystemAlbumByIndex(indexArray: [Int]) {
        for index in indexArray {
            let image = photoArray[index].photoImage
            UIImageWriteToSavedPhotosAlbum(image, self, nil, nil)
        }
    }
    
    
    
    // 取出文件夹中所有文件路径，按创建日期升序放到Array中返回，返回的是完整路径
    private func sortedFileOrFolderPathsByCreationDate(path: String) -> [String] {
        var filePathArray: [String] = []
        let fileManager = NSFileManager.defaultManager()
        let contents = (try! fileManager.contentsOfDirectoryAtPath(path)) 
        for item in contents {
            if item.characters.startsWith(".".characters) {
                continue
            }
            let filePath = path + "/" + item
            filePathArray.append(filePath)
        }
        
        // 排序 升序
        let sortedFilesArray = filePathArray.sort { (file1: String, file2: String) -> Bool in
            var attr1 = try! fileManager.attributesOfItemAtPath(file1)
            var attr2 = try! fileManager.attributesOfItemAtPath(file2)
            let date1 = attr1[NSFileCreationDate]! as! NSDate
            let date2 = attr2[NSFileCreationDate]! as! NSDate
            if date1.timeIntervalSinceDate(date2) < 0 {
                return true
            } else {
                return false
            }
        }
        return sortedFilesArray
    }
    
}
