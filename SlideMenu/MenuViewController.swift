//
//  MenuViewController.swift
//  SlideMenu
//
//  Created by 诸葛俊伟 on 6/7/16.
//  Copyright © 2016 Stanford University. All rights reserved.
//

import UIKit

protocol MenuViewDelegate {
    func clickButton(_ button: UIButton)
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
        self.backgroundColor = UIColor.groupTableViewBackground
        self.showsHorizontalScrollIndicator = false
        self.showsVerticalScrollIndicator = false
        addSubviewFrame(frame)
    }

    func addSubviewFrame(_ frame: CGRect)
    {
        buttonWidth = frame.width/5
        
        self.contentSize = CGSize(width: CGFloat(titleArray.count)*buttonWidth, height: frame.height)
        
        for i in 0..<titleArray.count {
            let button = UIButton(frame:CGRect(x: (CGFloat(Float(i)))*buttonWidth, y: 0, width: buttonWidth, height: frame.height))
            button.titleLabel?.font = UIFont.systemFont(ofSize: 12)
            button.setTitle(titleArray[i], for: UIControlState())
            button.tag = 100 + i
            button.setTitleColor(UIColor(red: 52/255, green: 61/255, blue: 0x6B/255, alpha: 1.0), for: UIControlState())
            
            if i == 0 {
                button.setTitleColor(UIColor(red: 0xF5/255, green: 91/255, blue: 59/255, alpha: 1.0) , for: UIControlState())
            }
            button.addTarget(self, action: #selector(MenuViewController.clickButton(_:)), for: UIControlEvents.touchUpInside)
            self.addSubview(button)
        }
        
        let blueView = UIView(frame: CGRect(x: 5, y: frame.height - 1, width: buttonWidth - 10, height: 1))
        blueView.backgroundColor = UIColor(red: 0xF5/255, green: 91/255, blue: 59/255, alpha: 1.0)
        self.blueLine = blueView
        self.addSubview(blueLine!)
    }
    
    func clickButton(_ sender: UIButton) {
        let index = sender.tag - 100
        for subview in self.subviews {
            if subview.isKind(of: UIButton.self) {
                let button = subview as! UIButton
                button.setTitleColor(UIColor(red: 52/255, green: 61/255, blue: 0x6B/255, alpha: 1), for: UIControlState())
            }
        }
        UIView.animate(withDuration: 0.2, animations: {
            self.blueLine?.frame = CGRect(x: 5 + (self.blueLine!.frame.width + 10) * CGFloat(index), y: self.blueLine!.frame.origin.y, width: self.blueLine!.frame.width, height: self.blueLine!.frame.height)
            
            sender.setTitleColor(UIColor(red: 0xF5/255, green: 91/255, blue: 59/255, alpha: 1.0), for: UIControlState())
        }) 
        self.menuDelegate?.clickButton(sender)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
