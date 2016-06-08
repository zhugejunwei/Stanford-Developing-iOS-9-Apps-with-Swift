//
//  MenuViewController.swift
//  SlideMenu
//
//  Created by 诸葛俊伟 on 6/7/16.
//  Copyright © 2016 Stanford University. All rights reserved.
//

import UIKit

protocol MenuViewDelegate {
    func clickButton(button: UIButton)
}

class MenuViewController: UIScrollView
{
    let titleArray = ["热门","新上榜", "日报", "七日热门", "三十日热门", "市集", "有奖活动", "简书出版", "简书播客"]
    let padding: CGFloat = 15
    var buttonWidth: CGFloat = 0
    var blueLine: UIView?
    var menuDelegate: MenuViewDelegate?
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.backgroundColor = UIColor.groupTableViewBackgroundColor()
        self.showsHorizontalScrollIndicator = false
        self.showsVerticalScrollIndicator = false
        addSubviewFrame(frame)
    }

    func addSubviewFrame(frame: CGRect)
    {
        buttonWidth = frame.width/5
        
        self.contentSize = CGSizeMake(CGFloat(titleArray.count)*buttonWidth, frame.height)
        
        for i in 0..<titleArray.count {
            let button = UIButton(frame:CGRectMake((CGFloat(Float(i)))*buttonWidth, 0, buttonWidth, frame.height))
            button.titleLabel?.font = UIFont.systemFontOfSize(12)
            button.setTitle(titleArray[i], forState: UIControlState.Normal)
            button.tag = 100 + i
            button.setTitleColor(UIColor(red: 52/255, green: 61/255, blue: 0x6B/255, alpha: 1.0), forState: UIControlState.Normal)
            
            if i == 0 {
                button.setTitleColor(UIColor(red: 0xF5/255, green: 91/255, blue: 59/255, alpha: 1.0) , forState: UIControlState.Normal)
            }
            button.addTarget(self, action: #selector(MenuViewController.clickButton(_:)), forControlEvents: UIControlEvents.TouchUpInside)
            self.addSubview(button)
        }
        
        let blueView = UIView(frame: CGRectMake(5, frame.height - 1, buttonWidth - 10, 1))
        blueView.backgroundColor = UIColor(red: 0xF5/255, green: 91/255, blue: 59/255, alpha: 1.0)
        self.blueLine = blueView
        self.addSubview(blueLine!)
    }
    
    func clickButton(sender: UIButton) {
        let index = sender.tag - 100
        for subview in self.subviews {
            if subview.isKindOfClass(UIButton) {
                let button = subview as! UIButton
                button.setTitleColor(UIColor(red: 52/255, green: 61/255, blue: 0x6B/255, alpha: 1), forState: UIControlState.Normal)
            }
        }
        UIView.animateWithDuration(0.2) {
            self.blueLine?.frame = CGRectMake(5 + (self.blueLine!.frame.width + 10) * CGFloat(index), self.blueLine!.frame.origin.y, self.blueLine!.frame.width, self.blueLine!.frame.height)
            
            sender.setTitleColor(UIColor(red: 0xF5/255, green: 91/255, blue: 59/255, alpha: 1.0), forState: UIControlState.Normal)
        }
        self.menuDelegate?.clickButton(sender)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
