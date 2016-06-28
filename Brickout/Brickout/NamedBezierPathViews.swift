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
    var bezierPath = [Int:UIBezierPath]() { didSet { setNeedsDisplay() } }
    
    override func drawRect(rect: CGRect) {
        for (int, path) in bezierPath {
            if int == 36 {
                UIColor.redColor().setFill()
                path.fill()
                UIColor.cyanColor().setStroke()
                path.stroke()
            } else {
                UIColor.random.setFill()
                path.fill()
                UIColor.darkGrayColor().setStroke()
                path.stroke()
            }
        }
    }
    
}
