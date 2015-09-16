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
    
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject!) {
        
        // Create a new variable to store the instance of ContainerViewController
        print("HomeViewConroller debug")
            }
}