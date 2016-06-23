//
//  BrickViewController.swift
//  Brickout
//
//  Created by 诸葛俊伟 on 6/17/16.
//  Copyright © 2016 Stanford University. All rights reserved.
//

import UIKit

class BrickViewController: UIViewController
{
    @IBOutlet weak var gameView: BrickView!
    @IBOutlet weak var boardView: BoardView! {
        didSet {
            boardView.addGestureRecognizer(UIPanGestureRecognizer(target: self, action: #selector(BoardView.moveBoard(_:))))
        }
    }
    
    
    override func viewWillAppear(animated: Bool) {
//        boardView.addBoard()
        super.viewDidAppear(animated)
        gameView.animating = true
    }

}
