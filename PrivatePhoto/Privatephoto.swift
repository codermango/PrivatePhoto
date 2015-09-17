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
//        let albumsDirectory = NSHomeDirectory().stringByAppendingPathComponent("Documents/Albums")
        let albumsDirectory = NSHomeDirectory() + "/Documents/Albums"
        let albumNamePathArray = sortedFileOrFolderPathsByCreationDate(albumsDirectory)
        for albumNamePath in albumNamePathArray {
            let albumName = getNameOfPath(albumNamePath)
            if albumName.characters.startsWith(".".characters) {
                continue
            }
            let photosPath = sortedFileOrFolderPathsByCreationDate(albumNamePath) // 升序的Array
            
            var photoArray: [Photo] = []
            for photoPath in photosPath {
                let image = UIImage(contentsOfFile: photoPath)
                let name = getNameOfPath(photoPath)
                if name.characters.startsWith(".".characters) {
                    continue
                }
                let photo = Photo(name: name, image: image!, isSelected: false)
                photoArray.append(photo)
            }
            let album = Album(name: albumName, photos: photoArray)
            albumArray.append(album)
        }
    }
    
    private func createAlbumsFolder() {
//        let albumsDirectory = NSHomeDirectory().stringByAppendingPathComponent("Documents/Albums") // Albums文件夹
        let albumsDirectory = NSHomeDirectory() + "/Documents/Albums"
        let fileManager = NSFileManager.defaultManager()
        if !fileManager.fileExistsAtPath(albumsDirectory) {
            do {
                // Albums文件夹不存在，则新建Albums文件夹
                try fileManager.createDirectoryAtPath(albumsDirectory, withIntermediateDirectories: false, attributes: nil)
            } catch _ {
            }
        }
    }
    
    // 取出文件夹中所有文件路径，按创建日期升序放到Array中返回，返回的是完整路径
    private func sortedFileOrFolderPathsByCreationDate(path: String) -> [String] {
        var filePathArray: [String] = []
        let fileManager = NSFileManager.defaultManager()
        let contents = (try! fileManager.contentsOfDirectoryAtPath(path)) 
        for item in contents {
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
    
    // 根据一个路径获取一个文件或文件夹的名字
    private func getNameOfPath(path: String) -> String {
        let index = path.rangeOfString("/", options: NSStringCompareOptions.BackwardsSearch, range: nil, locale: nil)!
        let name = path.substringFromIndex(index.endIndex)
        return name
    }


    
    func createAlbumWithName(name: String) {
//        let albumDirectory = NSHomeDirectory().stringByAppendingPathComponent("Documents/Albums/\(name)")
        let albumDirectory = NSHomeDirectory() + "/Documents/Albums/" + name

        let fileManager = NSFileManager.defaultManager()
        if fileManager.fileExistsAtPath(albumDirectory) { // 如果有同名album，则不创建
            return
        }
        do {
            try fileManager.createDirectoryAtPath(albumDirectory, withIntermediateDirectories: true, attributes: nil)
            let album = Album(name: name, photos: [])
            albumArray.append(album)
        } catch _ {
            print("创建失败")
        }
        
    }
    
    func deleteAlbumByIndex(index: Int) {
        let deleteAlbumName = albumArray[index].albumName
//        let albumDirectory = NSHomeDirectory().stringByAppendingPathComponent("Documents/Albums/\(deleteAlbumName)")
        let albumDirectory = NSHomeDirectory() + "/Documents/Albums/" + deleteAlbumName

        let fileManager = NSFileManager.defaultManager()
        if fileManager.fileExistsAtPath(albumDirectory) { // 如果存在就删除，实际上没必要判断，理论上都是对应好的
            do {
                try fileManager.removeItemAtPath(albumDirectory)
            } catch _ {
            }
            albumArray.removeAtIndex(index)
        }
    }
}
















