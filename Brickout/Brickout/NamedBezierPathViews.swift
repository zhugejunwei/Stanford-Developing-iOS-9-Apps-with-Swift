//
//  NamedBezierPathViews.swift
//  Brickout
//
//  Created by 诸葛俊伟 on 6/17/16.
//  Copyright © 2016 Stanford University. All rights reserved.
//

import UIKit

class NamedBezierPathViews: UIView
{
    var strokeColor = UIColor.blackColor()
    var bezierPath = [Int:UIBezierPath]() { didSet { setNeedsDisplay() } }
    
    override func drawRect(rect: CGRect) {
        for (_, path) in bezierPath {
            UIColor.random.setFill()
            path.fill()
            strokeColor.setStroke()
            path.lineWidth = 2.0
            path.stroke()
        }
    }
    
}
