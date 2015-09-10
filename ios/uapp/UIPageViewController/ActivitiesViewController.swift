//
//  ActivitiesViewController.swift
//  UIPageViewController
//
//  Created by zhaofei on 2015-08-26.
//  Copyright © 2015 Vea Software. All rights reserved.
//

import UIKit

class ActivitiesViewController: UIViewController {
    
    var hamburgerView: HamburgerView?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        print("Activities page loading..")
        // Remove the drop shadow from the navigation bar
        /*navigationController!.navigationBar.clipsToBounds = true
        let tapGestureRecognizer = UITapGestureRecognizer(target: self, action: "hamburgerViewTapped")
        hamburgerView = HamburgerView(frame: CGRect(x: 0, y: 0, width: 20, height: 20))
        hamburgerView!.addGestureRecognizer(tapGestureRecognizer)
        navigationItem.leftBarButtonItem = UIBarButtonItem(customView: hamburgerView!)*/
        
    }
    
    func hamburgerViewTapped() {
        let navigationController = parentViewController as! UINavigationController
        let containerViewController = navigationController.parentViewController as! ContainerViewController
        containerViewController.hideOrShowMenu(!containerViewController.showingMenu, animated: true)
    }
    
    

}
