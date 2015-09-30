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
        
        UINavigationBar.appearance().barTintColor = UIColor(red: 53.0/255.0, green: 121.0/255.0, blue: 176.0/255.0, alpha: 1) //Nav bar background color
        
        navigationBar.frame.origin.y = -10 //Nav bar height
        
        UIBarButtonItem.appearance().tintColor = UIColor.whiteColor() //Nav bar itembutton tint color
        
        UINavigationBar.appearance().tintColor = UIColor.whiteColor() //Nav bar back button tint color
        
        UINavigationBar.appearance().titleTextAttributes = [NSForegroundColorAttributeName:UIColor.whiteColor(),NSFontAttributeName:UIFont(name: "Futura", size: 23)!] //Nav bar text color & text font & size
        
        let navBgImage:UIImage = UIImage(named: "Navback.png")!
        UINavigationBar.appearance().setBackgroundImage(navBgImage, forBarMetrics: .Default) //Nav bar background pic
        
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
