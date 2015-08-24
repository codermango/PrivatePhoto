//
//  CheckmarkView.swift
//  PrivatePhoto
//
//  Created by Mark on 15/8/24.
//  Copyright (c) 2015年 codermango. All rights reserved.
//

import UIKit

class CheckmarkView: UIView {
    
    var borderWidth: CGFloat = 1.0
    var checkmarkLineWidth: CGFloat = 1.2
    var borderColor = UIColor.whiteColor()
    var bodyColor = UIColor(red: 20.0 / 255.0, green: 111.0 / 255.0, blue: 223.0 / 255.0, alpha: 1.0)
    var checkmarkColor: UIColor!
    
    // set shadow
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        self.layer.shadowColor = UIColor.grayColor().CGColor
        self.layer.shadowOffset = CGSizeMake(0, 0)
        self.layer.shadowOpacity = 0.6
        self.layer.shadowRadius = 2.0
    }

    required init(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    
    // Only override drawRect: if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func drawRect(rect: CGRect) {
        self.borderColor.setFill()
        UIBezierPath(ovalInRect: self.bounds).fill()
        
        self.bodyColor.setFill()
        UIBezierPath(ovalInRect: CGRectInset(self.bounds, self.borderWidth, self.borderWidth)).fill()
        
        let checkmarkPath = UIBezierPath()
        checkmarkPath.lineWidth = self.checkmarkLineWidth
        
        checkmarkPath.moveToPoint(CGPointMake(CGRectGetWidth(self.bounds) * (6.0 / 24.0), CGRectGetHeight(self.bounds) * (12.0 / 24.0)))
        checkmarkPath.addLineToPoint(CGPointMake(CGRectGetWidth(self.bounds) * (10.0 / 24.0), CGRectGetHeight(self.bounds) * (16.0 / 24.0)))
        checkmarkPath.addLineToPoint(CGPointMake(CGRectGetWidth(self.bounds) * (18.0 / 24.0), CGRectGetHeight(self.bounds) * (8.0 / 24.0)))
        self.checkmarkColor.setStroke()
        checkmarkPath.stroke()
    }


}
