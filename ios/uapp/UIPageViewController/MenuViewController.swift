//
//  MenuViewController.swift
//  UIPageViewController
//
//  Created by lafeike on 2015-08-22.
//  Copyright © 2015 Vea Software. All rights reserved.
//

import UIKit

class MenuViewController: UITableViewController {
    
    lazy var menuItems: NSArray = {
        let path = NSBundle.mainBundle().pathForResource("MenuItems", ofType: "plist")
        return NSArray(contentsOfFile: path!)!
        }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        print("MenuViewController loading...")
        // Remove the drop shadow from the navigation bar
       // navigationController!.navigationBar.clipsToBounds = true
        print("parent=\(self.parentViewController)")
        
       //(parentViewController as! ContainerViewController).menuItem =
            (menuItems[0] as! NSDictionary)
    }
    
    var menuItem: NSDictionary? {
        didSet {
            if let newMenuItem = menuItem{
                //view.backgroundColor = UIColor(colorArray: newMenuItem["colors"] as! NSArray)
                //backgroundImageView?.image = UIImage(named: newMenuItem["bigImage"] as! String)
                print(newMenuItem["image"])
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
                    print("DetailViewController: something wrong")
                }
                
            }
        }
    }

    
   
    
    // MARK: - Table View
    
    // MARK: UITableViewDelegate
    override func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        tableView.deselectRowAtIndexPath(indexPath, animated: true)
        print("row = \(indexPath.row), parent = \(self.parentViewController)")
        let menuItem = menuItems[indexPath.row] as! NSDictionary
        (self.parentViewController as! ContainerViewController).menuItem = menuItem
    }
    
    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1
    }
    
    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return menuItems.count
    }
    
    override func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        // adjust row height so items all fit into view
        return max(60, CGRectGetHeight(view.bounds) / CGFloat(menuItems.count))
    }
    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("MenuItemCell") as! MenuItemCell
        let menuItem = menuItems[indexPath.row] as! NSDictionary
        cell.configureForMenuItem(menuItem)
        return cell
    }

}
