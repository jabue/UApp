//
//  GeneralViewController.swift
//  CellClick
//
//  Created by Smallulu on 15/9/16.
//  Copyright © 2015年 Smallulu. All rights reserved.
//

import UIKit

class GeneralViewController: UIViewController {
    
    @IBOutlet weak var genLabel: UILabel!
    
    var titleStringViaSegue: String!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.genLabel.text = self.titleStringViaSegue
    }
    
}
