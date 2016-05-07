//
//  triangle.swift
//  FaceIt
//
//  Created by 诸葛俊伟 on 5/6/16.
//  Copyright © 2016 Stanford University. All rights reserved.
//

import UIKit

class triangle: UIView {

    
    override func drawRect(rect: CGRect)
    {
        
        let path = UIBezierPath()
        
        path.moveToPoint(CGPoint(x: 80,y: 50))
        path.addLineToPoint(CGPoint(x: 140,y: 150))
        path.addLineToPoint(CGPoint(x: 10,y: 150))
        
        path.closePath()
        
        UIColor.greenColor().setFill() // 注意这是UIColor中的方法
        UIColor.redColor().setStroke() // 注意这是UIColor中的方法
        path.lineWidth = 3.0 // 这是UIBezierPath中的属性
        path.fill() // UIBezierPath中的方法
        path.stroke() // UIBezierPath中的方法
    }

    

}
