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

        // Do any additional setup after loading the view.
    }
    
    @IBAction func showMessage(sender: UIButton) {
        buttonClicked = "Message"
        self.performSegueWithIdentifier("showProfile", sender: self)
    }
    
    @IBAction func showProfile(sender: UIButton) {
        buttonClicked = "Profile"
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
        let destinationVC = segue.destinationViewController as! ContainerViewController
        destinationVC.buttonClickedinHome = buttonClicked
    }
}
    
   

    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */
