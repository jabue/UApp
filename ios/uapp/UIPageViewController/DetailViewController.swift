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
        // Remove the drop shadow from the navigation bar
        navigationController!.navigationBar.clipsToBounds = true
        let tapGestureRecognizer = UITapGestureRecognizer(target: self, action: "hamburgerViewTapped")
        hamburgerView = HamburgerView(frame: CGRect(x: 0, y: 0, width: 20, height: 20))
        hamburgerView!.addGestureRecognizer(tapGestureRecognizer)
        navigationItem.leftBarButtonItem = UIBarButtonItem(customView: hamburgerView!)

    }
    
    func hamburgerViewTapped() {
        let navigationController = parentViewController as! UINavigationController
        let containerViewController = navigationController.parentViewController as! ContainerViewController
        containerViewController.hideOrShowMenu(!containerViewController.showingMenu, animated: true)
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
