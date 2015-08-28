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

class SwitchViewController: UIViewController {
    
   var hamburgerView: HamburgerView?
    var firstViewController: UIViewController!
    var secondViewController: UIViewController!
    var trasitionInProgress : Bool!
    var currentSegueIdentifier = String()
    
    var buttonClickedinHome : String? // to indicate which button at the home page user clicked.
    
    override func viewDidLoad()
    {
        super.viewDidLoad()
        print("switch page load")
        print("button clike is: \(buttonClickedinHome)")
        navigationController!.navigationBar.clipsToBounds = true
        let tapGestureRecognizer = UITapGestureRecognizer(target: self, action: "hamburgerViewTapped")
        hamburgerView = HamburgerView(frame: CGRect(x: 0, y: 0, width: 20, height: 20))
        hamburgerView!.addGestureRecognizer(tapGestureRecognizer)
        navigationItem.leftBarButtonItem = UIBarButtonItem(customView: hamburgerView!)
        
        switch buttonClickedinHome! {
        case "Profile":
            print("go profile")
            self.currentSegueIdentifier = SegueIdentifierFirst
        case "Activities":
            print("go activities")
            self.currentSegueIdentifier = SegueIdentifierSecond
            
            
        default:
            print("switch error")
        }

        self.performSegueWithIdentifier(currentSegueIdentifier, sender: nil)
    }
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        print("go \(buttonClickedinHome)")
        
        if (segue.identifier == SegueIdentifierFirst) {
            self.firstViewController = segue.destinationViewController;
        }
        
        if (segue.identifier == SegueIdentifierSecond) {
            self.secondViewController = segue.destinationViewController;
        }
        
        // If we're going to the first view controller.
        if (segue.identifier == SegueIdentifierFirst) {
            // If this is not the first time we're loading this.
            if (self.childViewControllers.count > 0) {
                self.swapFromViewController(self.childViewControllers[0], toViewController: self.firstViewController!)
            }
            else {
                // If this is the very first time we're loading this we need to do
                // an initial load and not a swap.
                self.addChildViewController(segue.destinationViewController)
                let destView : UIView = (segue.destinationViewController).view
                //destView.autoresizingMask = UIViewAutoresizingFlexibleWith | UIViewAutoresizingflexibleHeight;
                destView.frame = CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height);
                self.view.addSubview(destView)
                segue.destinationViewController.didMoveToParentViewController(self)
            }
        }
            // By definition the second view controller will always be swapped with the
            // first one.
        else if (segue.identifier == SegueIdentifierSecond){
            self.addChildViewController(segue.destinationViewController)
            let destView : UIView = (segue.destinationViewController).view
            //destView.autoresizingMask = UIViewAutoresizingFlexibleWith | UIViewAutoresizingflexibleHeight;
            destView.frame = CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height);
            self.view.addSubview(destView)
            segue.destinationViewController.didMoveToParentViewController(self)

            
        }
    }
    
    func swapFromViewController(fromViewController: UIViewController, toViewController: UIViewController) -> Void {
        toViewController.view.frame =  CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height)
        fromViewController.willMoveToParentViewController(nil)
        self.addChildViewController(toViewController)
        self.transitionFromViewController(
            fromViewController,
            toViewController: toViewController,
            duration:1.0,
            options: UIViewAnimationOptions.TransitionCrossDissolve,
            animations: { () -> Void in
                
            },
            completion: { finished in
                fromViewController.removeFromParentViewController()
                toViewController.didMoveToParentViewController(self)
                self.trasitionInProgress = false
        })
        
        
        
    }
    
    
    func swapViewControllers() -> Void {
        if((self.trasitionInProgress) != nil){
            return
        }
        
        self.trasitionInProgress = true
        self.currentSegueIdentifier = (self.currentSegueIdentifier == SegueIdentifierFirst) ? SegueIdentifierSecond : SegueIdentifierFirst
        
        if((self.currentSegueIdentifier == SegueIdentifierFirst && self.firstViewController != nil) ){
            self.swapFromViewController(self.secondViewController!, toViewController: self.firstViewController!)
            return
        }
        
        if(self.currentSegueIdentifier == SegueIdentifierSecond && self.secondViewController != nil){
            self.swapFromViewController(self.firstViewController!, toViewController: self.secondViewController!)
        }
        
        self.performSegueWithIdentifier(self.currentSegueIdentifier, sender: nil)
        
    }
    
    
    
    var menuItem: NSDictionary? {
        didSet {
            if let newMenuItem = menuItem{
                //view.backgroundColor = UIColor(colorArray: newMenuItem["colors"] as! NSArray)
                //backgroundImageView?.image = UIImage(named: newMenuItem["bigImage"] as! String)
                print(newMenuItem["image"]!)
                switch newMenuItem["image"] as! String{
                case "Storage":
                    print("this is Storage")
                    
                case "logo":
                    print("this is logo")
                    //[[self navigationController] setNavigationBarHidden:YES animated:YES];
                    self.navigationController?.setNavigationBarHidden(true, animated: true)
                    self.performSegueWithIdentifier("backHomeSegue", sender: self)
                    
                    
                case "favourite":
                    print("this is favourite")
                    
                case "Message":
                    print("this is message")
                case "Activites":
                    print("this is Activites")
                default:
                    print("something wrong")
                }
                
            }
        }
    }

    

    
}
