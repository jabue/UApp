//
//  TableViewCell.swift
//  CellClick
//
//  Created by Smallulu on 15/9/16.
//  Copyright © 2015年 Smallulu. All rights reserved.
//

import UIKit

class customerCell: UITableViewCell {
    
    @IBOutlet weak var headerLabel: UILabel!
    
    func tableView(tableView: UITableView, viewForFooterInSection section: Int) -> UIView? {
        let footerView = UIView(frame: CGRectMake(0, 0, tableView.frame.size.width, 40))
        footerView.backgroundColor = UIColor.blackColor()
        
        return footerView
    }
    
    func tableView(tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        return 40.0
    }
}