//
//  SettingViewController.swift
//  UITableViewController
//
//  Created by Loui on 2015-08-28.
//  Copyright © 2015 Vea Software. All rights reserved.
//

import UIKit


class SettingViewController: UIViewController {
    
    @IBOutlet var subview: UIView!
    
    var setpage:SetBarViewController!
    var showsetbar:Bool!
    
    var setbarinfro:CGFloat = SetBarSetting.sizeofsetbar
    var speedofsetbar = SetBarSetting.speedofsetbar
    
    var settingsub:ViewControllerSetting!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        print("MessageView loaded...")
        
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
        /*
        settingsub = UIStoryboard(name: "Main", bundle: nil).instantiateViewControllerWithIdentifier("settingstartpage") as! ViewControllerSetting
        self.subview.addSubview(settingsub.view!)

        var rootViewController = ViewControllerSetting()
        var rootNavigationController = UINavigationController(rootViewController: rootViewController)
        rootNavigationController.pushViewController(rootViewController, animated: false)
        */
        var storyboard = UIStoryboard(name: "Main", bundle: nil)
        var rootViewController = storyboard.instantiateViewControllerWithIdentifier("settingstartpage")
        self.subview.addSubview(rootViewController.view!)
        
        //rootViewController = rootNavigationController
        
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