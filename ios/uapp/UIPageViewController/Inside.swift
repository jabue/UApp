//
//  Inside.swift
//  Uapp
//
//  Created by joey on 15/9/24.
//  Copyright © 2015年 Vea Software. All rights reserved.
//

//
//  Feeds.swift
//  UIPageViewController
//
//  Created by joey on 15/9/17.
//  Copyright © 2015年 Vea Software. All rights reserved.
//


import UIKit


class Inside: UIViewController, UITableViewDelegate, UITableViewDataSource{
    
    
    var tableView: UITableView!
    
    var refreshControl: UIRefreshControl!
    //var bounds = UIScreen.mainScreen().bounds
    
    var numberofpost:Int!
    var postDate:[String]=[]
    var postId:[String]=[]
    var likes:[String]=[]
    var userId:[String]=[]
    var descriptions:[String]=[]
    var userName:[String]=[]
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        var conti:Bool=false
        //let cm = CommonFunc()
        //print("school is \(cm.getSchool()), user is \(cm.getEmail())")
        print("connect to sever...")
        let Lambda = AWSLambda.defaultLambda()
        let request = AWSLambdaInvocationRequest()
        request.functionName = LambdaGetActivities
        request.payload = "{\"post_date\": \"2015-09-15 12:00:03\"}"
        //"{\"school\": \"Simon Fraser University(SFU)\"}"
        
        
        print(request)
        var json:JSON!
        
        Lambda.invoke(request).continueWithBlock({(task) -> AnyObject! in
            if let error = task.error {
                print("lambda invoke failed: [\(error)]")
            }
            else if let exception = task.exception {
                print("lambda invoke failed: [\(exception)]")
            }
            else{
                print("DEBUG: call lambda sucessfully")
                //print(task.result)
                json = JSON(task.result.payload)
                print(json)
                let a:Int = Int(String(json["Count"]))!
                
                self.numberofpost = a
                for (var i=0;i<a;i++){
                    print("23333333333")
                    print(String(json["Items"][i]["post_date"]["S"]))
                    self.postDate += [String(json["Items"][i]["post_date"]["S"])]
                    self.postId += [String(json["Items"][i]["post_id"]["S"])]
                    self.likes += [String(json["Items"][i]["likes"]["N"])]
                    self.userId += [String(json["Items"][i]["user_id"]["S"])]
                    self.descriptions += [String(json["Items"][i]["description"]["S"])]
                    self.userName += [String(json["Items"][i]["user_name"]["S"])]
                }
                print(a)
                conti=true
            }
            return nil
        })
        while !conti {
        }
        print("1213123213123")
        
        
        

        tableView = UITableView()
        
        tableView.frame = CGRectMake(0, 0, self.view.frame.width, self.view.frame.height*2/3)
        tableView.delegate = self
        tableView.dataSource = self
        tableView.registerClass(TableViewCell.self, forCellReuseIdentifier: "cell")
        //tableView.selec
        self.view.addSubview(tableView)
        
        // add refresh
        refreshControl = UIRefreshControl()
        refreshControl?.addTarget(self, action: "refreshData", forControlEvents: UIControlEvents.ValueChanged)
        tableView.addSubview(refreshControl)
        
        self.setupInfiniteScrollingView()
        
        
    }
    
    func refreshData() {
        sleep(2)
        refreshControl.endRefreshing()
    }
    
    var infiniteScrollingView:UIView!
    private func setupInfiniteScrollingView() {
        
        self.infiniteScrollingView = UIView(frame: CGRectMake(0, self.tableView.contentSize.height, self.tableView.bounds.size.width, 60))
        self.infiniteScrollingView!.autoresizingMask = UIViewAutoresizing.FlexibleWidth
        self.infiniteScrollingView!.backgroundColor = UIColor.whiteColor()
        var activityViewIndicator = UIActivityIndicatorView(activityIndicatorStyle: UIActivityIndicatorViewStyle.White)
        activityViewIndicator.color = UIColor.darkGrayColor()
        activityViewIndicator.frame = CGRectMake(self.infiniteScrollingView!.frame.size.width/2-activityViewIndicator.frame.width/2, self.infiniteScrollingView!.frame.size.height/2-activityViewIndicator.frame.height/2, activityViewIndicator.frame.width, activityViewIndicator.frame.height)
        activityViewIndicator.startAnimating()
        self.infiniteScrollingView!.addSubview(activityViewIndicator)
        sleep(2)
        infiniteScrollingView.removeFromSuperview()
        //activityViewIndicator.stopAnimating()
    }
    
    override func viewDidAppear(animated: Bool) {
        
    }
    
    //MARK: - Tableview Delegate & Datasource
    func tableView(tableView:UITableView, numberOfRowsInSection section:Int) -> Int
    {
        return numberofpost+1
    }
    
    func numberOfSectionsInTableView(tableView: UITableView) -> Int
    {
        return 1
    }
    
    var temp:Int = 0;
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell
    {
        
        var cell = tableView.dequeueReusableCellWithIdentifier("cell") as! TableViewCell!
        
        
        
        if (indexPath.row < numberofpost) {
        print(indexPath.row)
            
            var rectRect:CGRect = CGRectMake(0,0,self.tableView.bounds.size.width, 400)
            var viewincell = UIView(frame: rectRect)
            viewincell.backgroundColor = UIColor.whiteColor()
            cell.addSubview(viewincell)

            
            //post time
        var outputtime = (postDate[indexPath.row] as NSString).substringWithRange(NSMakeRange(5, 11))
        var rectRect1:CGRect = CGRectMake(200,0,100, 60)
        var timeforpost = UILabel(frame:rectRect1)
        timeforpost.text = outputtime//"post time later"
        cell.addSubview(timeforpost)
        
            //post infor
        var rectRect2:CGRect = CGRectMake(0,80,300, 100)
        var information = UILabel(frame:rectRect2)
        information.text = descriptions[indexPath.row]
        cell.addSubview(information)
        //print(descriptions[indexPath.row])
        
            //头像
        let image = UIImage(named:"qq.png")
        var vImg = UIImageView(image: image);
        vImg.frame = CGRectMake(0, 0, 50, 50)
        cell.addSubview(vImg)
            
            //name
        var rectRect3:CGRect = CGRectMake(100,0,100, 60)
        var name = UILabel(frame:rectRect3)
        name.text = userName[indexPath.row]
        cell.addSubview(name)
        
        
        var rectRectdianzan:CGRect = CGRectMake(0,200,100, 50)
        let dianzan = UIButton(frame: rectRectdianzan)
        dianzan.setTitle("zan!", forState:UIControlState.Normal)
        dianzan.backgroundColor = UIColor.greenColor()
        dianzan.addTarget(self,action:"buttonActions:",forControlEvents:UIControlEvents.TouchUpInside)
        cell.addSubview(dianzan)
        
            
        }
        /*
        if temp != indexPath.row{
            tableView.reloadData()
            temp = indexPath.row
        //cell.detailTextLabel?.text  = "hlello";
        }
*/
        if (indexPath.row == numberofpost) {
            print("get infor")
            self.tableView.tableFooterView = self.infiniteScrollingView
            /*
            cell.removeFromSuperview()
            
            
            */
            /*
            var rectRect:CGRect = CGRectMake(0,0,self.tableView.bounds.size.width, 100)
            var viewincell = UIView(frame: rectRect)
            viewincell.backgroundColor = UIColor.whiteColor()
            cell.addSubview(viewincell)
            
            var rectRect4:CGRect = CGRectMake(100,0,100, 60)
            var last = UILabel(frame:rectRect4)
            last.text = "load more"
            cell.addSubview(last)
            */
            //sleep(2)
            
            //tableView.reloadData()
            
            //loadMore()
            //infiniteScrollingView.removeFromSuperview()
            //self.tableView.tableFooterView?.removeFromSuperview()
        }
        return cell;
        
        
    }
    
    func buttonActions(sender: UIButton!) {
        print("tapped button")
        
        print(tableView.frame.height)
    }
    
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath)
    {
        let cell = tableView.cellForRowAtIndexPath(indexPath)
        cell?.selectionStyle = UITableViewCellSelectionStyle.None
        
        print(indexPath.row)
        /*
        var bounds = UIScreen.mainScreen().bounds
        
        self.view.frame = CGRectMake(0, 0, bounds.size.width, bounds.size.height)
        
        var ph:PinglunandHuifuViewController!
        ph = UIStoryboard(name: "Main", bundle: nil).instantiateViewControllerWithIdentifier("PinglunandHuifuViewController") as! PinglunandHuifuViewController
        
        ph.view.frame.size.width = bounds.size.width
        ph.view.frame.size.height = bounds.size.height
        ph.view.frame.origin.x=0
        ph.view.frame.origin.y = 0
        self.view.addSubview(ph.view!)
        
        */
    }

    func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat{
        
        return 400.0;
    }
    
    
    
}