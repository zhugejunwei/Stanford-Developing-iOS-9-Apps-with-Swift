//
//  BoardView.swift
//  Brickout
//
//  Created by 诸葛俊伟 on 6/17/16.
//  Copyright © 2016 Stanford University. All rights reserved.
//

import UIKit

@IBDesignable
class BoardView: NamedBezierPathViews, UIDynamicAnimatorDelegate
{
    let lineColor = UIColor.cyanColor()
    let insideColor = UIColor.blackColor()
    
    private lazy var animator: UIDynamicAnimator = {
        let animator = UIDynamicAnimator(referenceView: self)
        animator.delegate = self
        return animator
    }()
    
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
    
    var boardSize: CGSize {
        let width = bounds.size.width / 4
        let height = width / 8
        return CGSize(width: width, height: height)
    }
    
    private var movedBoard: UIView?
    
    func addBoard() -> UIBezierPath
    {
        let boardPath = UIBezierPath(roundedRect: CGRect(origin: CGPoint(x: CGFloat.random(4) * boardSize.width, y: bounds.size.height - boardSize.height), size: boardSize), cornerRadius: 50)
        
        boardPath.lineWidth = 3.0
        lineColor.setStroke()
        boardPath.stroke()
        insideColor.setFill()
        boardPath.fill()
        
        return boardPath
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        let boardPath = addBoard()
        bezierPath[BrickView.PathInts.Board] = boardPath
    }
    
//    override func drawRect(rect: CGRect) {
//        addBoard()
//    }
    
    func moveBoard(recognizer: UIPanGestureRecognizer) {
        let gesturePoint = recognizer.locationInView(self)
        switch recognizer.state {
        case .Began:
            // create attachment
            if let boardToAttachTo = movedBoard where boardToAttachTo.superview != nil {
                attachment = UIAttachmentBehavior(item: boardToAttachTo, attachedToAnchor: gesturePoint)
            }
        //            lastDrop = nil
        case .Changed:
            // create attachment's anchor point
            attachment!.anchorPoint = gesturePoint
        default:
            attachment = nil
        }

    }

}
