//
//  Discover.swift
//  UIPageViewController
//
//  Created by joey on 15/9/17.
//  Copyright © 2015年 Vea Software. All rights reserved.
//

import UIKit


class Discover: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    
    
    var tableView: UITableView!
    
    //var sectionInTable = ["1daf","2adsf","3adsfa"]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView = UITableView()
        tableView.frame = CGRectMake(0, 0, self.view.frame.width, self.view.frame.height*2/3)
        tableView.delegate = self
        tableView.dataSource = self
        tableView.registerClass(TableViewCell.self, forCellReuseIdentifier: "cell")
        self.view.addSubview(tableView)
        
        
        print(tableView.frame.height)
        print("1111")
        
        
    }
    
    override func viewDidAppear(animated: Bool) {
        
    }
    
    //MARK: - Tableview Delegate & Datasource
    func tableView(tableView:UITableView, numberOfRowsInSection section:Int) -> Int
    {
        return 3
    }
    
    func numberOfSectionsInTableView(tableView: UITableView) -> Int
    {
        return 1
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell
    {
        
        var cell = tableView.dequeueReusableCellWithIdentifier("cell") as! TableViewCell!
        
        var rectRect1:CGRect = CGRectMake(200,0,200, 50)
        var information1 = UILabel(frame:rectRect1)
        information1.text = "123123"
        cell.addSubview(information1)
        
        var rectRect2:CGRect = CGRectMake(200,50,200, 50)
        var information2 = UILabel(frame:rectRect2)
        information2.text = "xxxxxxxx"
        cell.addSubview(information2)
        //var rectRect:CGRect = CGRectMake(0,0,60, 60)
        
        var rectRect3:CGRect = CGRectMake(200,100,200, 50)
        var information3 = UILabel(frame:rectRect3)
        information3.text = "xxxxxxxx"
        cell.addSubview(information3)
        
        let image = UIImage(named:"qq.png")
        var vImg = UIImageView(image: image);
        vImg.frame = CGRectMake(0, 0, 150, 150)
        cell.addSubview(vImg)
        
        return cell;
    }
    
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath)
    {
        let cell = tableView.cellForRowAtIndexPath(indexPath)
        print(indexPath.row)
        
    }
    func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat{
        
        return 150.0;
    }

    
    
}