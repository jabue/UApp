//
//  NavigationController.swift
//  UIPageViewController
//
//  Created by Xi Wang on 15/8/25.
//  Copyright © 2015年 Vea Software. All rights reserved.
//

import UIKit

class NavigationController: UINavigationController {

    override func viewDidLoad() {
        
        UINavigationBar.appearance().barTintColor = UIColor(red: 42.0/255.0, green: 98.0/255.0, blue: 158.0/255.0, alpha: 1)
        navigationBar.frame.origin.y = -10
        UINavigationBar.appearance().tintColor = UIColor.whiteColor()
        UINavigationBar.appearance().titleTextAttributes = [NSForegroundColorAttributeName:UIColor.whiteColor(),NSFontAttributeName:UIFont(name: "Futura", size: 23)!]
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
