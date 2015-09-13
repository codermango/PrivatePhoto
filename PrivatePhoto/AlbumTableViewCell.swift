//
//  AlbumTableViewCell.swift
//  PrivatePhoto
//
//  Created by Mark on 15/8/3.
//  Copyright (c) 2015年 codermango. All rights reserved.
//

import UIKit

class AlbumTableViewCell: UITableViewCell {
    
    @IBOutlet weak var albumImageView1: UIImageView!
    @IBOutlet weak var albumImageView2: UIImageView!
    @IBOutlet weak var albumImageView3: UIImageView!
    @IBOutlet weak var albumNameLabel: UILabel!
    @IBOutlet weak var albumPhotoNumberLabel: UILabel!

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
