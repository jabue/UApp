//
//  Feeds.swift
//  UIPageViewController
//
//  Created by joey on 15/9/17.
//  Copyright © 2015年 Vea Software. All rights reserved.
//

import UIKit


class Feeds: UIViewController, UITableViewDelegate, UITableViewDataSource{
    
    
    //@IBOutlet var feedstable: UITableView!
    //@IBOutlet var tableView: UITableView!
    
    var tableView: UITableView!
    
    //var sectionInTable = ["1daf","2adsf","3adsfa"]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView = UITableView()
        
        /*
        sbv_1.view.frame.size.width = bounds.size.width
        sbv_1.view.frame.size.height = bounds.size.height*2/3
        sbv_1.view.frame.origin.x=0
        sbv_1.view.frame.origin.y=bounds.size.height*1/3
        self.view.addSubview(sbv_1.view!)
        */
        
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
        
        // let cell: UITableViewCell = UITableViewCell(style: UITableViewCellStyle.Subtitle, reuseIdentifier: "FriendCell")
        var cell = tableView.dequeueReusableCellWithIdentifier("cell") as! TableViewCell!
        
        
//        cell.imageView
        //cell.textLabel?.text = "hahahaha"
        /*
        var img = UIImage(named:"qq.png");
        var vImg = UIImageView(image: img);
        vImg.frame.origin = CGPoint(x:0,y:20);
        //vImg.frame = CGRect(x:0,y:20,width:120,height:120);
        self.view.addSubview(vImg);
        */
        
        
        var rectRect1:CGRect = CGRectMake(80,0,100, 60)
        var timeforpost = UILabel(frame:rectRect1)
        timeforpost.text = "post time later"
        cell.addSubview(timeforpost)
        
        var rectRect2:CGRect = CGRectMake(0,80,300, 100)
        var information = UILabel(frame:rectRect2)
        information.text = "this is the first post, just test for length"
        cell.addSubview(information)
        //var rectRect:CGRect = CGRectMake(0,0,60, 60)
        
        let image = UIImage(named:"qq.png")
        var vImg = UIImageView(image: image);
        vImg.frame = CGRectMake(0, 0, 50, 50)
        cell.addSubview(vImg)
        
        var rectRectdianzan:CGRect = CGRectMake(0,200,100, 50)
        let dianzan = UIButton(frame: rectRectdianzan)
        dianzan.setTitle("zan!", forState:UIControlState.Normal)
        dianzan.backgroundColor = UIColor.greenColor()
        dianzan.addTarget(self,action:"buttonActions:",forControlEvents:UIControlEvents.TouchUpInside)
        cell.addSubview(dianzan)
        
        
        //let image = cell.imageView
        //image.frame = CGRectMake(0, 0, 50, 50)

        
        
        
        
        //cell.imageView!.image = UIImage(named:"qq.png");
        
        //cell.imageView?.frame ＝ frame:CGRectMake(0, 0, 300, 50)
        //cell.imageView?.frame.size.width = 50
        
        //cell.imageView!.layer.masksToBounds = true;
        //cell.imageView!.layer.cornerRadius = 5;
        //cell.imageView!.layer.borderWidth = 2;
        //cell.imageView!.layer.borderColor = UIColor.yellowColor().CGColor;
        
        cell.detailTextLabel?.text  = "hlello";
        
        
        
        return cell;
        
        
    }
    
    func buttonActions(sender: UIButton!) {
        print("tapped button")
        
        print(tableView.frame.height)
    }
    
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath)
    {
        let cell = tableView.cellForRowAtIndexPath(indexPath)
        
        print(indexPath.row)
//        
//        if cell!.selected
//        {
//            if cell!.accessoryType == UITableViewCellAccessoryType.Checkmark
//            {
//                selectedFriends.removeAtIndex(selectedFriends.indexOf((cell?.textLabel?.text)!)!)
//                cell!.accessoryType = UITableViewCellAccessoryType.None
//            }
//            else
//            {
//                selectedFriends.append(friendsArray[indexPath.row])
//                cell!.accessoryType = UITableViewCellAccessoryType.Checkmark
//            }
//            
//        }
//        else
//        {
//            cell!.accessoryType = UITableViewCellAccessoryType.None
//        }
    }
    func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat{
        
        return 400.0;
    }

    
    
}