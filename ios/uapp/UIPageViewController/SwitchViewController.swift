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
    
    var firstViewController: UIViewController!
    var secondViewController: UIViewController!
    var trasitionInProgress : Bool!
    var currentSegueIdentifier = String()
    
    var buttonClickedinHome : String? // to indicate which button at the home page user clicked.
    
    override func viewDidLoad()
    {
        super.viewDidLoad()
        self.trasitionInProgress = false
        self.currentSegueIdentifier = SegueIdentifierFirst
        self.performSegueWithIdentifier(currentSegueIdentifier, sender: nil)
    }
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
       
    
        // Instead of creating new VCs on each seque we want to hang on to existing
        // instances if we have it. Remove the second condition of the following
        // two if statements to get new VC instances instead.
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
            self.swapFromViewController(self.childViewControllers[0], toViewController: self.secondViewController!)
            
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
    

    
}
