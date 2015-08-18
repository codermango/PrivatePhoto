//
//  Privatephoto.swift
//  PrivatePhoto
//
//  Created by Mark on 15/8/18.
//  Copyright (c) 2015年 codermango. All rights reserved.
//

import Foundation
import UIKit

class Privatephoto {
    var albumArray: [Album] = []
    
    init () {
        // 首先新建Albums文件夹，如果存在就跳过
        createAlbumsFolder()
        
        let albumsDirectory = NSHomeDirectory().stringByAppendingPathComponent("Documents/Albums")
        let fileManger = NSFileManager.defaultManager()
        let albumNameArray = fileManger.contentsOfDirectoryAtPath(albumsDirectory, error: nil) as! [String]
        for albumName in albumNameArray {
            var albumPath = albumsDirectory.stringByAppendingPathComponent(albumName)
            var photosPath = filePathsInFolderByCreationDate(albumPath) // 升序的Array
            
            var photoArray: [UIImage] = []
            for photoPath in photosPath {
                var image = UIImage(contentsOfFile: photoPath)
                photoArray.append(image!)
            }
            var album = Album(name: albumName, photos: photoArray)
            albumArray.append(album)
        }
    }
    
    private func createAlbumsFolder() {
        let albumsDirectory = NSHomeDirectory().stringByAppendingPathComponent("Documents/Albums") // Albums文件夹
        let fileManager = NSFileManager.defaultManager()
        if !fileManager.fileExistsAtPath(albumsDirectory) {
            // Albums文件夹不存在，则新建Albums文件夹
            fileManager.createDirectoryAtPath(albumsDirectory, withIntermediateDirectories: false, attributes: nil, error: nil)
        }
    }
    
    // 取出文件夹中所有文件路径，按创建日期升序放到Array中返回，返回的是完整路径
    private func filePathsInFolderByCreationDate(folderPath: String) -> [String] {
        var filePathArray: [String] = []
        let fileManager = NSFileManager.defaultManager()
        let contents = fileManager.contentsOfDirectoryAtPath(folderPath, error: nil) as! [String]
        for item in contents {
            var filePath = folderPath + "/" + item;
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



    
    func createAlbum(name: String) {
        
    }
    
    func deleteAlbum(index: Int) {
        
    }
}