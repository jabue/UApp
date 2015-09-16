//
//  SetBarViewController.swift
//  UIPageViewController
//
//  Created by joey on 15/9/16.
//  Copyright © 2015年 Vea Software. All rights reserved.
//

import UIKit

class SetBarViewController: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func showhomepage(sender: AnyObject) {
        let myStoryBoard = self.storyboard
        let anotherView:UIViewController = (myStoryBoard?.instantiateViewControllerWithIdentifier("Home"))! as UIViewController
        self.presentViewController(anotherView, animated: true, completion: nil)
    }
    
}