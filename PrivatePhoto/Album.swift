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
    
    
}
