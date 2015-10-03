//
//  CalenderViewController.swift
//  UIPageViewController
//
//  Created by joey on 15/9/16.
//  Copyright © 2015年 Vea Software. All rights reserved.
//

import UIKit


class ScheduleViewController: UIViewController, SMRotaryProtocol {
    
    @IBOutlet var subview: UIView!
    
    var setpage:SetBarViewController!
    var showsetbar:Bool!
    
    var setbarinfro:CGFloat = SetBarSetting.sizeofsetbar
    var speedofsetbar = SetBarSetting.speedofsetbar
    
    var valueLabel = UILabel()
    var delegate: SMRotaryProtocol?
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        print("Schedule View loaded...")
        
        setpage = UIStoryboard(name: "Main", bundle: nil).instantiateViewControllerWithIdentifier("SetBarViewController") as! SetBarViewController
        
        self.view.addSubview(setpage.view!)
        setpage.view.frame.size.width = setbarinfro
        setpage.view.frame.origin.x = -setbarinfro
        showsetbar = false
        
        //hand swipe
        let leftSwipe = UISwipeGestureRecognizer(target: self, action: Selector("handleSwipes:"))
        let rightSwipe = UISwipeGestureRecognizer(target: self, action: Selector("handleSwipes:"))
        
        leftSwipe.direction = .Left
        rightSwipe.direction = .Right
        
        view.addGestureRecognizer(leftSwipe)
        view.addGestureRecognizer(rightSwipe)
        
        // Create sector label
        valueLabel = UILabel(frame: CGRectMake((self.view.bounds.size.width / 2)-110, 10, 220, 50))
        
        valueLabel.textAlignment = NSTextAlignment.Center
        valueLabel.text = "Welcome to Schedule"
        valueLabel.textColor = UIColor.redColor()
        self.view.addSubview(valueLabel)
        
        let screenSize: CGRect = UIScreen.mainScreen().bounds
        let screenWidth = screenSize.width
        let screenHeight = screenSize.height
        
        print("screen width=\(screenWidth), screen height=\(screenHeight)")
        
        let wheelDiameter = 2 * screenWidth / CGFloat( 1 + cos(2 * M_PI / 9))
        print("wheel diameter is \(wheelDiameter)")
        let wheel:SMRotaryWheel = SMRotaryWheel.init(frame: CGRectMake(0, 0, wheelDiameter, wheelDiameter), del: self, sectionsNum: 9)
        
        wheel.center = CGPoint(x: 200,y: 320)
        self.view.addSubview(wheel)
        
        let clockDiameter = wheelDiameter * 0.7
        
        let clockWheel: SMClockWheel = SMClockWheel.init(frame: CGRectMake(0, 0, clockDiameter, clockDiameter), del: self, sectionsNum: 21)
        clockWheel.center = CGPoint(x: 200, y: 320)
        self.view.addSubview(clockWheel)
        
        //let image = UIImage(named: "addButton.png") as UIImage?
        let add_btn = UIButton(type: UIButtonType.System) as UIButton
        
        add_btn.frame = CGRectMake(150, 270, 100, 100)
        add_btn.addTarget(self, action: "btnTouched:", forControlEvents:.TouchUpInside)
        self.view.addSubview(add_btn)
        
    }
    
    func btnTouched(sender:UIButton!){
        print("add class begin...")
        self.performSegueWithIdentifier("searchCourse_segue", sender: self)
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func wheelDidChangeValue(newValue:String) ->Void
    {
        self.valueLabel.text = newValue
        
        //print("(self.valueLabel.text) is Choosed.")
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