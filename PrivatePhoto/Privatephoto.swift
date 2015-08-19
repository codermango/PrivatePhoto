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
        let albumNamePathArray = sortedFileOrFolderPathsByCreationDate(albumsDirectory)
        for albumNamePath in albumNamePathArray {
            var albumName = getNameOfPath(albumNamePath)
            var photosPath = sortedFileOrFolderPathsByCreationDate(albumNamePath) // 升序的Array
            
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
    private func sortedFileOrFolderPathsByCreationDate(path: String) -> [String] {
        var filePathArray: [String] = []
        let fileManager = NSFileManager.defaultManager()
        let contents = fileManager.contentsOfDirectoryAtPath(path, error: nil) as! [String]
        for item in contents {
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
    
    // 根据一个路径获取一个文件或文件夹的名字
    private func getNameOfPath(path: String) -> String {
        var index = path.rangeOfString("/", options: NSStringCompareOptions.BackwardsSearch, range: nil, locale: nil)!
        var name = path.substringFromIndex(index.endIndex)
        return name
    }


    
    func createAlbumWithName(name: String) {
        let albumDirectory = NSHomeDirectory().stringByAppendingPathComponent("Documents/Albums/\(name)")
        let fileManager = NSFileManager.defaultManager()
        if fileManager.fileExistsAtPath(albumDirectory) { // 如果有同名album，则不创建
            return
        }
        if fileManager.createDirectoryAtPath(albumDirectory, withIntermediateDirectories: true, attributes: nil, error: nil) {
            let album = Album(name: name, photos: [])
            albumArray.append(album)
        } else {
            println("创建失败")
        }
        
    }
    
    func deleteAlbumByIndex(index: Int) {
        let deleteAlbumName = albumArray[index].albumName
        let albumDirectory = NSHomeDirectory().stringByAppendingPathComponent("Documents/Albums/\(deleteAlbumName)")
        let fileManager = NSFileManager.defaultManager()
        if fileManager.fileExistsAtPath(albumDirectory) { // 如果存在就删除，实际上没必要判断，理论上都是对应好的
            fileManager.removeItemAtPath(albumDirectory, error: nil)
            albumArray.removeAtIndex(index)
        }
    }
}
















