//
//  ActivitiesViewController.swift
//  UIPageViewController
//
//  Created by zhaofei on 2015-08-26.
//  Copyright © 2015 Vea Software. All rights reserved.
//

import UIKit

class ActivitiesViewController: UIViewController {
    
    @IBOutlet var subview: UIView!
   
   //three page
    
    var setpage:SetBarViewController!
    var showsetbar:Bool!
    
    var setbarinfro:CGFloat = SetBarSetting.sizeofsetbar 
    var speedofsetbar = SetBarSetting.speedofsetbar
    
    var swipcount:Int!
    var bounds = UIScreen.mainScreen().bounds
    
    var sbv_1:Feeds!
    var sbv_2:HotTopic!
    var sbv_3:Discover!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        print("Activities page loading..")
        
        setpage = UIStoryboard(name: "Main", bundle: nil).instantiateViewControllerWithIdentifier("SetBarViewController") as! SetBarViewController
        
        self.view.addSubview(setpage.view!)
        setpage.view.frame.size.width = setbarinfro
        setpage.view.frame.origin.x = -setbarinfro
        showsetbar = false
        
        //add sbv1
        sbv_1 = UIStoryboard(name: "Main", bundle: nil).instantiateViewControllerWithIdentifier("Feeds") as! Feeds
        self.view.addSubview(sbv_1.view!)
        sbv_1.view.frame.size.width = bounds.size.width
        sbv_1.view.frame.size.height = bounds.size.height*2/3
        sbv_1.view.frame.origin.x=0
        sbv_1.view.frame.origin.y=bounds.size.height*1/3
        //add sbv2
        sbv_2 = UIStoryboard(name: "Main", bundle: nil).instantiateViewControllerWithIdentifier("HotTopic") as! HotTopic
        self.view.addSubview(sbv_2.view!)
        sbv_2.view.frame.size.width = bounds.size.width
        sbv_2.view.frame.size.height = bounds.size.height*2/3
        sbv_2.view.frame.origin.x=bounds.size.width
        sbv_2.view.frame.origin.y=bounds.size.height*1/3
        //add sbv3
        sbv_3 = UIStoryboard(name: "Main", bundle: nil).instantiateViewControllerWithIdentifier("Discover") as! Discover
        self.view.addSubview(sbv_3.view!)
        sbv_3.view.frame.size.width = bounds.size.width
        sbv_3.view.frame.size.height = bounds.size.height*2/3
        sbv_3.view.frame.origin.x=bounds.size.width*2
        sbv_3.view.frame.origin.y=bounds.size.height*1/3
        
        //hand swipe
        let leftSwipe = UISwipeGestureRecognizer(target: self, action: Selector("handleSwipes:"))
        
        var rightSwipe = UISwipeGestureRecognizer(target: self, action: Selector("handleSwipes:"))
        
        leftSwipe.direction = .Left
        rightSwipe.direction = .Right
        
        view.addGestureRecognizer(leftSwipe)
        view.addGestureRecognizer(rightSwipe)
        
        swipcount=1
        print(bounds.size.width)
    }
    
    func sbvSwipe(leftsp:Bool){
        var bsize = bounds.size.width
        if leftsp{
            bsize = -bsize
        }
        UIView.animateWithDuration(0.5 , animations: {
            self.sbv_1.view.frame.origin.x = self.sbv_1.view.frame.origin.x + bsize
            self.sbv_2.view.frame.origin.x = self.sbv_2.view.frame.origin.x + bsize
            self.sbv_3.view.frame.origin.x = self.sbv_3.view.frame.origin.x + bsize
            
        })
        
    }
       
    func handleSwipes(sender:UISwipeGestureRecognizer) ->Bool{
        
        if(sender.direction == .Left && swipcount < 3 && showsetbar == false){
            swipcount = swipcount+1
            print("11")
            sbvSwipe(true)
            return true
        }
        if(sender.direction == .Right && swipcount > 1 && showsetbar == false){
            swipcount = swipcount-1
            sbvSwipe(false)
            return true
        }
        
        if (sender.direction == .Left && showsetbar == true && swipcount == 1){
            UIView.animateWithDuration(speedofsetbar , animations: {
                self.subview.frame.origin.x = self.subview.frame.origin.x - self.setbarinfro
                self.setpage.view.frame.origin.x = self.setpage.view.frame.origin.x - self.setbarinfro
                self.sbv_1.view.frame.origin.x = self.sbv_1.view.frame.origin.x - self.setbarinfro
            
            })
            showsetbar = false
            return true
        }
        
        if (sender.direction == .Right && showsetbar == false && swipcount == 1){
            UIView.animateWithDuration(speedofsetbar, animations: {
                self.subview.frame.origin.x = self.subview.frame.origin.x + self.setbarinfro
                self.setpage.view.frame.origin.x = self.setpage.view.frame.origin.x + self.setbarinfro
                self.sbv_1.view.frame.origin.x = self.sbv_1.view.frame.origin.x + self.setbarinfro
            
            })
            showsetbar = true
            return true
            
        }

        return true
    }
    
    func transtocurrent(var transto:Int){
        var tempbooleg:Bool = false
        if transto < 0 {
            tempbooleg = true
            transto = -transto
        }
        
        for var i=0 ; i < transto ; i=i+1{
            sbvSwipe(tempbooleg)
        }
    }
    
    // swipcount
    
    @IBAction func feedbutton(sender: AnyObject) {
        let transstate = 1
        let transto = swipcount - transstate
        transtocurrent(transto)
        swipcount=1
    }
    @IBAction func hottopicbutton(sender: AnyObject) {
        let transstate = 2
        let transto = swipcount - transstate
        transtocurrent(transto)
        swipcount=2
    }
    @IBAction func discover(sender: AnyObject) {
        let transstate = 3
        let transto = swipcount - transstate
        transtocurrent(transto)
        swipcount=3
    }

    
    
    
    
    
    
}


