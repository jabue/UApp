//
//  SwitchViewController.swift
//  UIPageViewController
//
//  Created by zhaofei on 2015-08-27.
//  Copyright © 2015 Vea Software. All rights reserved.
//

import UIKit

let SegueIdentifierFirst = "switchProfileSegue"
let SegueIdentifierSecond = "switchActivitiesSegue"
let SegueIdentifierThird = "switchMessageSegue"
let SegueIdentifierForth = "switchSetting"

class SwitchViewController: UIViewController {
    
    var hamburgerView: HamburgerView?
    var firstViewController: UIViewController!
    var secondViewController: UIViewController!
    var thirdViewController: UIViewController!
    var forthViewController: UIViewController!
    
    var trasitionInProgress : Bool!
    var currentSegueIdentifier = String()
    
    var buttonClickedinHome : String? // to indicate which button at the home page user clicked, passed from the parent view.
    
    override func viewDidLoad()
    {
        super.viewDidLoad()
        print("switch page load...")
        print("button clike is: \(buttonClickedinHome)")
        if let _ = buttonClickedinHome {
            print("button clike is: \(buttonClickedinHome)")
            let tapGestureRecognizer = UITapGestureRecognizer(target: self, action: "hamburgerViewTapped")
            hamburgerView = HamburgerView(frame: CGRect(x: 0, y: 0, width: 20, height: 20))
            
            hamburgerView!.addGestureRecognizer(tapGestureRecognizer)
            navigationItem.leftBarButtonItem = UIBarButtonItem(customView: hamburgerView!)
            
            switch buttonClickedinHome! { // buttonClickedinHome is passed from the HomeViewController.
            case "Profile":
                print("go profile")
                self.currentSegueIdentifier = SegueIdentifierFirst
            case "Activities":
                print("go activities")
                self.currentSegueIdentifier = SegueIdentifierSecond
            case "Message":
                print("go Message")
                self.currentSegueIdentifier = SegueIdentifierThird
            case "Setting":
                print("go Setting")
                self.currentSegueIdentifier = SegueIdentifierForth
                
                
            default:
                print("switch error")
            }
            
            self.performSegueWithIdentifier(currentSegueIdentifier, sender: nil)
            
        }
       
    }
    
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        
        var back = false
        print("prepare segue : \(segue.identifier)")
        switch segue.identifier! {
        case SegueIdentifierFirst:
                self.firstViewController = segue.destinationViewController
        case SegueIdentifierSecond:
                self.secondViewController = segue.destinationViewController
        case SegueIdentifierThird:
                self.thirdViewController = segue.destinationViewController
        case SegueIdentifierForth:
                self.forthViewController = segue.destinationViewController
        case "backHomeSegue":
            back = true
            print("go back to home page")
        
        default:
            print("error: no such segue.")
        }
        if !back
        {
            print("debug in switchViewController's prepareForSegue()")
            self.addChildViewController(segue.destinationViewController)
            let destView : UIView = (segue.destinationViewController).view
        
            destView.autoresizingMask = [.FlexibleWidth , .FlexibleHeight]
            destView.frame = CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height)
            self.view.addSubview(destView)
            segue.destinationViewController.didMoveToParentViewController(self)
        }else{
            print("debug2 in switchViewController's prepareForSegue()")
            
        }
        
        
    }
    
    var menuItem: NSDictionary? {
        didSet {
            if let newMenuItem = menuItem{
                print(newMenuItem["image"]!)
                
                switch newMenuItem["image"] as! String{
                case "Storage":
                    print("this is Storage")
                    
                case "logousmall":
                    print("this is logo, will go home page")
                    
                case "favourite":
                    print("this is favourite")
                    
                case "MessageW":
                    print("this is message")
                    
                    self.performSegueWithIdentifier("switchMessageSegue", sender: nil)
                case "ActivitiesW":
                    print("this is Activites")
                    self.performSegueWithIdentifier("switchActivitiesSegue", sender: nil)
                default:
                    print("SwitchViewController: something wrong")
                }
                
            }
        }
    }

    

    
}
