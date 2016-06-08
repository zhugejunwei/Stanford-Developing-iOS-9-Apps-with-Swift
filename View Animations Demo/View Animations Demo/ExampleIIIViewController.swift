//
//  ExampleIIIViewController.swift
//  View Animations Demo
//
//  Created by Joyce Echessa on 1/30/15.
//  Copyright (c) 2015 Appcoda. All rights reserved.
//

import UIKit

class ExampleIIIViewController: UIViewController {
    
    var alertView: UIView!

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
        createView()
    }
    
    func createView() {
        
        // Create a red view
        let alertWidth: CGFloat = view.bounds.width
        let alertHeight: CGFloat = view.bounds.height
        let alertViewFrame: CGRect = CGRectMake(0, 0, alertWidth, alertHeight)
        alertView = UIView(frame: alertViewFrame)
        alertView.backgroundColor = UIColor.redColor()
        
        // Create an image view and add it to this view
        let imageView = UIImageView(frame: CGRectMake(0, 0, alertWidth, alertHeight/2))
        imageView.image = UIImage(named: "bike_traveler.png")
        alertView.addSubview(imageView)
        
        // Create a button and set a listener on it for when it is tapped. Then the button is added to the alert view
        let button = UIButton(type: UIButtonType.System) as UIButton
        button.setTitle("Dismiss", forState: UIControlState.Normal)
        button.backgroundColor = UIColor.whiteColor()
        let buttonWidth: CGFloat = alertWidth/2
        let buttonHeight: CGFloat = 40
        button.frame = CGRectMake(alertView.center.x - buttonWidth/2, alertView.center.y - buttonHeight/2, buttonWidth, buttonHeight)
        
        button.addTarget(self, action: #selector(ExampleIIIViewController.dismissAlert), forControlEvents: UIControlEvents.TouchUpInside)
        
        alertView.addSubview(button)
        view.addSubview(alertView)
    }
    
    func dismissAlert() {
        
        let bounds = alertView.bounds
        let smallFrame = CGRectInset(alertView.frame, alertView.frame.size.width / 4, alertView.frame.size.height / 4)
        let finalFrame = CGRectOffset(smallFrame, 0, bounds.size.height)
        
        let snapshot = alertView.snapshotViewAfterScreenUpdates(false)
        snapshot.frame = alertView.frame
        view.addSubview(snapshot)
        alertView.removeFromSuperview()
        
        UIView.animateKeyframesWithDuration(4, delay: 0, options: .CalculationModeCubic, animations: {
            UIView.addKeyframeWithRelativeStartTime(0.0, relativeDuration: 0.5) {
                snapshot.frame = smallFrame
            }
            UIView.addKeyframeWithRelativeStartTime(0.5, relativeDuration: 0.5) {
                snapshot.frame = finalFrame
            }
        }, completion: nil)
                
    }

}
