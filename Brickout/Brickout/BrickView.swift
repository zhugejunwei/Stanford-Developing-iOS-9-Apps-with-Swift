//
//  BrickView.swift
//  Brickout
//
//  Created by 诸葛俊伟 on 6/17/16.
//  Copyright © 2016 Stanford University. All rights reserved.
//

import UIKit
import CoreMotion

@IBDesignable
class BrickView: NamedBezierPathViews, UIDynamicAnimatorDelegate
{
    private var boardSize: CGSize {
        let width = bounds.size.width / 4
        let height = width / 8
        return CGSize(width: width, height: height)
    }
    
    private lazy var animator: UIDynamicAnimator = {
        let animator = UIDynamicAnimator(referenceView: self)
        animator.delegate = self
        return animator
    }()
    
    private let ballBehavior = BallBehavior()
    
    var animating = false {
        didSet {
            if animating {
                animator.addBehavior(ballBehavior)
                updateRealGravity()
            } else {
                animator.removeBehavior(ballBehavior)
            }
        }
    }
    
    private var attachment: UIAttachmentBehavior? {
        willSet {
            if attachment != nil {
                animator.removeBehavior(attachment!)
            }
        }
        didSet {
            if attachment != nil {
                animator.addBehavior(attachment!)
            }
        }
    }
    
    var realGravity: Bool = false {
        didSet {
            updateRealGravity()
        }
    }
    
    private let motionManager = CMMotionManager()
    
    func updateRealGravity() {
        if realGravity {
            if motionManager.accelerometerAvailable && !motionManager.accelerometerActive {
                motionManager.accelerometerUpdateInterval = 0.25
                motionManager.startAccelerometerUpdatesToQueue(NSOperationQueue.mainQueue())
                { (data, error) in
                    if self.ballBehavior.dynamicAnimator != nil {
                        if var dx = data?.acceleration.x, var dy = data?.acceleration.y {
                            switch UIDevice.currentDevice().orientation {
                            case .Portrait: dy = -dy
                            case .PortraitUpsideDown: break
                            case .LandscapeRight: swap(&dx, &dy)
                            case .LandscapeLeft: swap(&dx, &dy); dy = -dy
                            default: dx = 0; dy = 0;
                            }
                            self.ballBehavior.gravity.gravityDirection = CGVector(dx: dx, dy: dy)
                        }
                    } else {
                        self.motionManager.stopAccelerometerUpdates()
                    }
                }
            }
        } else {
            motionManager.stopAccelerometerUpdates()
        }
    }
    
    private let bricksPerRow = 6
    private var brickSize: CGSize {
        let width = bounds.size.width / CGFloat(bricksPerRow)
        let height = width / 2
        return CGSize(width: width, height: height)
    }
    
    var brickArray = [Array<Int>]()
    
    // Append Bricks to brickArray, Int from 0...35, 6 rows, 6 columns.
    func appendBrickArray() {
        for column in 0...5 {
            var columnArray = Array<Int>()
            for row in 6*column...6*column+5 {
                columnArray.append(row)
            }
            brickArray.append(columnArray)
        }
    }
    
    struct PathInts {
        static let Brick = 0...35
        static let Barrier = 36
        static let Board = 50
        static let Ball = 51
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        // Bricks Location
        appendBrickArray()
        for rows in 0...5 {
            for bricks in 0...5 {
                let startPoint = CGPoint(x: CGPoint.zero.x + CGFloat(bricks) * brickSize.width, y: CGPoint.zero.y + CGFloat(rows) * brickSize.height)
                let brickPath = UIBezierPath(rect: CGRect(origin: startPoint, size: brickSize))
                bezierPath[brickArray[rows][bricks]] = brickPath
            }
        }
        
        // Barrier Location
        let barrierPath = UIBezierPath(ovalInRect: CGRect(center: CGPoint(x: bounds.mid.x, y: 10 * brickSize.height), size: brickSize))
        ballBehavior.addBarrier(barrierPath, named: PathInts.Barrier)
        bezierPath[PathInts.Barrier] = barrierPath
        
        // Board Location
        let boardPath = UIBezierPath(roundedRect: CGRect(origin: CGPoint(x: bounds.mid.x, y: bounds.size.height - boardSize.height), size: boardSize), cornerRadius: 50)
        
        bezierPath[PathInts.Board] = boardPath
        
        // Ball Location
//        let ballPath = UIBezierPath(arcCenter: CGPoint(x: bounds.mid.x + boardSize.width / 2, y: bounds.size.height - boardSize.height - boardSize.height/1.5), radius: boardSize.height/1.5, startAngle: 0, endAngle: CGFloat(M_PI * 2), clockwise: true)
//        bezierPath[PathInts.Ball] = ballPath
    }
    
    func startBall(recognizer: UITapGestureRecognizer) {
        
    }
//    
//    override func drawRect(rect: CGRect) {
//        addBall()
//    }
//    
//    func addBall() -> ()
//    {
//        let ballPath = UIBezierPath(arcCenter: CGPoint(x: bounds.mid.x + boardSize.width / 2, y: bounds.size.height - boardSize.height - boardSize.height/1.5), radius: boardSize.height/1.5, startAngle: 0, endAngle: CGFloat(M_PI * 2), clockwise: true)
//        
//        let frame = CGRect(
//        
//        let ball = UIView()
//
//        
//        ballBehavior.addItem(ball)
//    }
    

    
    
//    func moveBoard(recognizer: UIPanGestureRecognizer) {
//        let gesturePoint = recognizer.locationInView(self)
//        switch recognizer.state {
//        case .Began:
//            // create attachment
//            if let boardToAttachTo = movedBoard where boardToAttachTo.superview != nil {
//                attachment = UIAttachmentBehavior(item: boardToAttachTo, attachedToAnchor: gesturePoint)
//            }
//        //            lastDrop = nil
//        case .Changed:
//            // create attachment's anchor point
//            attachment!.anchorPoint = gesturePoint
//        default:
//            attachment = nil
//        }
//        
//    }
}
