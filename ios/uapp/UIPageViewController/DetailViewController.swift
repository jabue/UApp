//
//  DetailViewController.swift
//  UIPageViewController
//
//  Created by lafeike on 2015-08-22.
//  Copyright © 2015 Vea Software. All rights reserved.
//

import UIKit


class DetailViewController: UIViewController {

    @IBOutlet weak var backgroundImageView: UIImageView!
    
    @IBOutlet var subview: UIView!
    var setpage:SetBarViewController!
    var showsetbar:Bool!
    
    var setbarinfro:CGFloat = SetBarSetting.sizeofsetbar as! CGFloat
    var speedofsetbar = SetBarSetting.speedofsetbar
    
    override func viewDidLoad() {
        super.viewDidLoad()
        print("profile page loading...")
        
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
    
    override func preferredStatusBarStyle() -> UIStatusBarStyle {
        //let rawValue =  UIColor(red: 36.0/255.0, green: 138.0/255.0, blue: 177.0/255.0, alpha: 1)
        return  UIStatusBarStyle.Default
    }
    
    func handleSwipes(sender:UISwipeGestureRecognizer){
        if (sender.direction == .Left && showsetbar == true){
            UIView.animateWithDuration(speedofsetbar, animations: {
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
