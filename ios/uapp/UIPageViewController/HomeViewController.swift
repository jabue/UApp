//
//  HomeViewController.swift
//  
//
//  Created by lafeike on 2015-08-22.
//
//

import UIKit

class HomeViewController: UIViewController {
    
    var buttonClicked = String()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        print("home page load...")

        // Do any additional setup after loading the view.
    }
    
    @IBAction func showMessage(sender: UIButton) {
        buttonClicked = "Message"
        print("showMessage")
        self.performSegueWithIdentifier("showProfile", sender: self)
    }
    
    @IBAction func showProfile(sender: UIButton) {
        buttonClicked = "Profile"
        print("showProfile")
        self.performSegueWithIdentifier("showProfile", sender: self)
        
    }
    
    @IBAction func showSetting(sender: UIButton) {
        buttonClicked = "Setting"
        print("showSetting")
        self.performSegueWithIdentifier("showProfile", sender: self)
    }
   
    @IBAction func showActivities(sender: UIButton) {
        buttonClicked = "Activities"
        self.performSegueWithIdentifier("showProfile", sender: self)
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject!) {
        
        // Create a new variable to store the instance of ContainerViewController
        print("HomeViewConroller debug")
        let destinationVC = segue.destinationViewController as! ContainerViewController
        destinationVC.buttonClickedinHome = buttonClicked
    }
}