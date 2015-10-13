//
//  PinglunandHuifuViewController.swift
//  UIPageViewController
//
//  Created by joey on 15/9/21.
//  Copyright © 2015年 Vea Software. All rights reserved.
//

import UIKit

class PinglunandHuifuViewController: UIViewController {
    
    @IBOutlet var posttitle: UITextField!
    
    @IBOutlet var postinfor: UITextView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view, typically from a nib.
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func send(sender: AnyObject) {
    }
    
}
