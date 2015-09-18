//
//  PushInside.swift
//  UIPageViewController
//
//  Created by EV Technologies Inc. on 2015-09-18.
//  Copyright © 2015 Vea Software. All rights reserved.
//

import UIKit

class PushInside: UIViewController {
    
    
    @IBOutlet weak var BtnCancel: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    //MARK: Button Cancel
    @IBAction func btnCancelPress(sender: AnyObject) {
        self.dismissViewControllerAnimated(true, completion: nil)
    }
    
}
