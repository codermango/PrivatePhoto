//
//  Photo.swift
//  PrivatePhoto
//
//  Created by Mark on 15/8/28.
//  Copyright (c) 2015年 codermango. All rights reserved.
//

import Foundation
import UIKit

class Photo {
    var photoImage: UIImage!
    var photoName: String!
    var isSelected: Bool!
    
    init(name: String, image: UIImage, isSelected: Bool) {
        self.photoName = name
        self.photoImage = image
        self.isSelected = isSelected
    }
}