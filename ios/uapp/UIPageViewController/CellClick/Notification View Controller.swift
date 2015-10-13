//
//  NotificationViewController.swift
//  CellClick
//
//  Created by Smallulu on 15/9/16.
//  Copyright © 2015年 Smallulu. All rights reserved.
//

import UIKit

class NotificationViewController: UIViewController {
    
    @IBOutlet weak var NotiLabel: UILabel!
    
    var titleStringViaSegue: String!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.NotiLabel.text = self.titleStringViaSegue
    }
    
}
