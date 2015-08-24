//
//  MenuItemCell.swift
//  UIPageViewController
//
//  Created by lafeike on 2015-08-22.
//  Copyright © 2015 Vea Software. All rights reserved.
//

import UIKit

class MenuItemCell: UITableViewCell {
    @IBOutlet weak var menuItemImageView: UIImageView!
    
    func configureForMenuItem(menuItem: NSDictionary) {
        menuItemImageView.image = UIImage(named: menuItem["image"] as! String)
        backgroundColor = UIColor(colorArray: menuItem["colors"] as! NSArray)
    }

}
