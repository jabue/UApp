//
//  File.swift
//  UIPageViewController
//
//  Created by lafeike on 2015-08-22.
//  Copyright © 2015 Vea Software. All rights reserved.
//

import UIKit

extension UIColor {
    convenience init(colorArray array: NSArray) {
        let r = array[0] as! CGFloat
        let g = array[1] as! CGFloat
        let b = array[2] as! CGFloat
        self.init(red: r/255.0, green: g/255.0, blue: b/255.0, alpha:1.0)
    }
}