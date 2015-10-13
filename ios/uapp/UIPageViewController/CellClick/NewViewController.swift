//
//  NewViewController.swift
//  CellClick
//
//  Created by Smallulu on 15/9/16.
//  Copyright © 2015年 Smallulu. All rights reserved.
//

import UIKit

class NewViewController: UIViewController {

    @IBOutlet weak var productLabel: UILabel!
    
    var titleStringViaSegue: String!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.productLabel.text = self.titleStringViaSegue
    }
    
}
