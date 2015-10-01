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
                    self.postId += [String(json["Items"][i]["]post_id"]["S"])]
                    
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
        
        
    }
    
    override func viewDidAppear(animated: Bool) {
        
    }
    
    //MARK: - Tableview Delegate & Datasource
    func tableView(tableView:UITableView, numberOfRowsInSection section:Int) -> Int
    {
        return numberofpost
    }
    
    func numberOfSectionsInTableView(tableView: UITableView) -> Int
    {
        return 1
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell
    {
        var cell = tableView.dequeueReusableCellWithIdentifier("cell") as! TableViewCell!
        
        
        if (indexPath.row <= numberofpost-1) {
        print(indexPath.row)
        var rectRect1:CGRect = CGRectMake(80,0,100, 60)
        var timeforpost = UILabel(frame:rectRect1)
        timeforpost.text = "post time later"
        cell.addSubview(timeforpost)
        
        var rectRect2:CGRect = CGRectMake(0,80,300, 100)
        var information = UILabel(frame:rectRect2)
        information.text = postDate[indexPath.row]//"this is the first post, just test for length"
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
        
        
        }
        
        //cell.detailTextLabel?.text  = "hlello";
        
        //当下拉到底部，执行loadMore()  loadMoreEnabled &&
        if (indexPath.row == numberofpost-1) {
            
            self.tableView.tableFooterView = self.infiniteScrollingView
            print("get infor")
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