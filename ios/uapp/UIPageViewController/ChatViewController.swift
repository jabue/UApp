//
//  ChatViewController.swift
//  UIPageViewController
//
//  Created by EV Technologies Inc. on 2015-09-18.
//  Copyright © 2015 Vea Software. All rights reserved.
//

//
//  MessageViewController.swift
//  UIPageViewController
//
//  Created by zhaofei on 2015-08-28.
//  Copyright © 2015 Vea Software. All rights reserved.
//

import UIKit


class ChatViewController: UIViewController {
    
    @IBOutlet weak var BtnReturn: UIBarButtonItem!
    @IBOutlet weak var NavigationBar: UINavigationItem!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        NavigationBar.title = "Here to Chat"
    }
    
    @IBAction func btnReturnPress(sender: AnyObject) {
        self.dismissViewControllerAnimated(true, completion: nil)
    }
    
}

