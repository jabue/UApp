//
//  DetailViewController.swift
//  UIPageViewController
//
//  Created by lafeike on 2015-08-22.
//  Copyright © 2015 Vea Software. All rights reserved.
//

import UIKit


class DetailViewController: UIViewController {

    @IBOutlet weak var backgroundImageView: UIImageView!
    var hamburgerView: HamburgerView?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        print("profile page loading...")
        // Remove the drop shadow from the navigation bar
        //navigationController!.navigationBar.clipsToBounds = true
        let tapGestureRecognizer = UITapGestureRecognizer(target: self, action: "hamburgerViewTapped")
        hamburgerView = HamburgerView(frame: CGRect(x: 0, y: 0, width: 20, height: 20))
        hamburgerView!.addGestureRecognizer(tapGestureRecognizer)
        //navigationItem.leftBarButtonItem = UIBarButtonItem(customView: hamburgerView!)
        //self.view.backgroundColor = UIColor(red: 36.0/255.0, green: 138.0/255.0, blue: 177.0/255.0, alpha: 1)
        

    }
    
    override func preferredStatusBarStyle() -> UIStatusBarStyle {
        //let rawValue =  UIColor(red: 36.0/255.0, green: 138.0/255.0, blue: 177.0/255.0, alpha: 1)
        return  UIStatusBarStyle.Default
    }
    
    
    func hamburgerViewTapped() {
        //let navigationController = parentViewController as! UINavigationController
        let containerViewController = parentViewController as! ContainerViewController
        containerViewController.hideOrShowMenu(!containerViewController.showingMenu, animated: true)
    }
    
    
    }
