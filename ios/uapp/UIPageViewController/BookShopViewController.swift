//
//  BookShopViewController.swift
//  UIPageViewController
//
//  Created by joey on 15/9/16.
//  Copyright © 2015年 Vea Software. All rights reserved.
//

import UIKit


class BookShopViewController: UIViewController {
    
    @IBOutlet var subview: UIView!
    
    var setpage:SetBarViewController!
    var showsetbar:Bool!
    
    var setbarinfro:CGFloat = CGFloat!
    var speedofsetbar = SetBarSetting.speedofsetbar
    
    override func viewDidLoad() {
        super.viewDidLoad()
        print("MessageView loading...")
        setbarinfro = bounds.size.wideth * 2/3
        
        setpage = UIStoryboard(name: "Main", bundle: nil).instantiateViewControllerWithIdentifier("SetBarViewController") as! SetBarViewController
        
        self.view.addSubview(setpage.view!)
        setpage.view.frame.size.width = setbarinfro
        setpage.view.frame.origin.x = -setbarinfro
        showsetbar = false
        
        //hand swipe
        let leftSwipe = UISwipeGestureRecognizer(target: self, action: Selector("handleSwipes:"))
        
        var rightSwipe = UISwipeGestureRecognizer(target: self, action: Selector("handleSwipes:"))
        
        leftSwipe.direction = .Left
        rightSwipe.direction = .Right
        
        view.addGestureRecognizer(leftSwipe)
        view.addGestureRecognizer(rightSwipe)
        
        
    }
    
    func handleSwipes(sender:UISwipeGestureRecognizer){
        if (sender.direction == .Left && showsetbar == true){
            UIView.animateWithDuration(speedofsetbar , animations: {
                self.subview.frame.origin.x = self.subview.frame.origin.x - self.setbarinfro
                self.setpage.view.frame.origin.x = self.setpage.view.frame.origin.x - self.setbarinfro
                
            })
            showsetbar = false
            
        }
        if (sender.direction == .Right && showsetbar == false){
            UIView.animateWithDuration(speedofsetbar, animations: {
                self.subview.frame.origin.x = self.subview.frame.origin.x + self.setbarinfro
                self.setpage.view.frame.origin.x = self.setpage.view.frame.origin.x + self.setbarinfro
                
            })
            showsetbar = true
            
            
        }
    }
    
}