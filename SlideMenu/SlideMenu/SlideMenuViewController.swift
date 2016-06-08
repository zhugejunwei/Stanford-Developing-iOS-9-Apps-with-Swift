//
//  ViewController.swift
//  SlideMenu
//
//  Created by 诸葛俊伟 on 6/7/16.
//  Copyright © 2016 Stanford University. All rights reserved.
//

import UIKit

class SlideMenuViewController: UIViewController, UIScrollViewDelegate, MenuViewDelegate {
    
    var menuView: MenuViewController?
    var scrollView: UIScrollView?
    var currentIndex = 0
    var isScroll = false
    
    override func viewDidLoad() {
        super.viewDidLoad()
        addButtonView()
        initUI()
        // Do any additional setup after loading the view, typically from a nib.
    }
    
    func addButtonView() {
        menuView = MenuViewController(frame: CGRectMake(0, 29.5, kSCREEN_WIDTH , 30))
        menuView?.menuDelegate = self
        self.view?.addSubview(menuView!)
    }
    
    func addScrollView() {
        addButtonView()
        scrollView = UIScrollView(frame: CGRectMake(0, (menuView?.frame.height)! + 30, kSCREEN_WIDTH, kSCREEN_HEIGHT - (menuView?.frame.height)! - 30))
        scrollView?.delegate = self
        scrollView?.showsHorizontalScrollIndicator = false
        
        
        scrollView?.backgroundColor = UIColor.whiteColor()
        scrollView?.contentSize = CGSizeMake(CGFloat(menuView!.titleArray.count) * kSCREEN_WIDTH, (scrollView?.frame.height)!)
        scrollView?.pagingEnabled = true
        self.view.addSubview(scrollView!)
    }
    
    func initUI() {
        self.addButtonView()
        self.addScrollView()
        let vcWidth = scrollView?.frame.width
        let vcHeight = scrollView?.frame.height
        
        for i in 0 ..< menuView!.titleArray.count{
            let firstVC  = UIViewController()
            firstVC.view.frame = CGRectMake(kSCREEN_WIDTH*CGFloat(i), 0, vcWidth!
                , vcHeight!)
            
            let r:CGFloat = CGFloat(CGFloat(arc4random_uniform(255))/CGFloat(255))
            let g:CGFloat = CGFloat(CGFloat(arc4random_uniform(255))/CGFloat(255))
            let b:CGFloat = CGFloat(CGFloat(arc4random_uniform(255))/CGFloat(255))
            firstVC.view.tag = i
            firstVC.view.backgroundColor = UIColor(red: r, green: g, blue: b, alpha: 1)
            self.addChildViewController(firstVC)
            scrollView?.addSubview(firstVC.view)
        }
    }
    
    func clickButton(button: UIButton) {
        let index : CGFloat = CGFloat(button.tag - 100)
        
        if let menuView = menuView{
            
            var p = menuView.convertPoint((menuView.blueLine?.frame.origin)!, toView: view)
            
            if index<CGFloat(menuView.titleArray.count-2) && p.x > view.bounds.width/2 + 15{
                p.x = menuView.buttonWidth
                var p2 =  view.convertPoint(p, toView: menuView)
                p2.y = 0
                UIView.animateWithDuration(0.2) {
                    menuView.contentOffset = p2
                }
            }else if index>CGFloat(2) && p.x < view.bounds.width/2 - 40{
                p.x = -menuView.buttonWidth
                var p2 =  view.convertPoint(p, toView: menuView)
                p2.y = 0
                UIView.animateWithDuration(0.2) {
                    menuView.contentOffset = p2
                }
            }
            
            if index <= 2 {
                UIView.animateWithDuration(0.2) {
                    menuView.contentOffset = CGPoint(x: 0, y: 0)
                }
            }
            if index>=CGFloat(menuView.titleArray.count-2) {
                UIView.animateWithDuration(0.2) {
                    menuView.contentOffset = CGPoint(x: menuView.contentSize.width-kSCREEN_WIDTH , y: 0)
                }
            }
            
            if !isScroll{
                UIView.animateWithDuration(0.2) {
                    self.scrollView?.contentOffset = CGPointMake(index * kSCREEN_WIDTH, 0)
                }
                
            }else{
                isScroll = false
            }
            
        }
        
    }
    
    func scrollViewDidEndDragging(scrollView: UIScrollView, willDecelerate decelerate: Bool) {
        
        scrollViewDidEndDecelerating(scrollView)
    }
    
    func scrollViewDidEndDecelerating(scrollView: UIScrollView) {
        // print(scrollView.contentOffset.x)
        if scrollView.isEqual(scrollView) {
            // print(scrollView.contentOffset.x)
            let index =  Int((scrollView.contentOffset.x)/kSCREEN_WIDTH)
            
            for subView in (menuView?.subviews)! {
                if subView.isKindOfClass(UIButton) {
                    let button : UIButton = (subView as? UIButton)!
                    if index == subView.tag - 100 {
                        isScroll = true
                        menuView?.clickButton(button)
                    }
                }
            }
        }
    }


}

