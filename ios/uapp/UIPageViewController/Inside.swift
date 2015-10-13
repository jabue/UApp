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


class Inside: UIViewController, UITableViewDelegate, UITableViewDataSource,UIImagePickerControllerDelegate,UINavigationControllerDelegate{
    let post_word_size:CGFloat = 13.0
    
    var addbuttonorigenx: CGFloat!
    var addbuttonorigeny: CGFloat!
    
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
    var cellSize:[CGFloat]=[]
    
    var firsttimeflag:Bool = true
    var unitSize:CGFloat!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        unitSize = self.view.frame.width*(1/58)
        cellSize += [unitSize*15]
        //print(unitSize)
        numberofpost=0
        /*
        var loadingsubview = UIView()//(frame: CGRectMake(0, 0, self.tableView.bounds.size.width, self.tableView.contentSize.height))
        loadingsubview.backgroundColor = UIColor.blackColor()
        loadingsubview.alpha = 0.5
        var activityViewIndicator = UIActivityIndicatorView(activityIndicatorStyle: UIActivityIndicatorViewStyle.White)
        activityViewIndicator.color = UIColor.darkGrayColor()
        activityViewIndicator.frame = CGRectMake(self.view.bounds.size.width/2-activityViewIndicator.frame.width/2, self.view.bounds.size.width/2-activityViewIndicator.frame.height/2, activityViewIndicator.frame.width, activityViewIndicator.frame.height)
        activityViewIndicator.startAnimating()
        loadingsubview.addSubview(activityViewIndicator)
        self.view.addSubview(loadingsubview)
        */
        //dispatch_async(dispatch_get_main_queue(), {
        
        
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
                    self.cellSize += [self.unitSize*15]
                }
                print(a)
                conti=true
            }
            return nil
        })
        while !conti {
        }
        print("1213123213123")
        //self.tableView.reloadData()
        //self.firsttimeflag = false
        /*
        sleep(1)
        
        loadingsubview.removeFromSuperview()
        self.tableView.reloadData()
        self.firsttimeflag = false
        */
        //})
        
        
        tableView = UITableView()
        
        tableView.frame = CGRectMake(0, 0, self.view.frame.width, self.view.frame.height)
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
        
        addbuttonorigenx=self.tableView.bounds.size.width - unitSize*7
        addbuttonorigeny=self.tableView.bounds.size.height/2 - unitSize*2.5
        
        var addbutton=UIButton()
        addbutton.frame = CGRectMake(addbuttonorigenx, addbuttonorigeny, unitSize*5, unitSize*5)
        addbutton.setTitle("+", forState:UIControlState.Normal)
        addbutton.backgroundColor = UIColor.lightGrayColor()
        addbutton.addTarget(self,action:"addbuttonact:",forControlEvents:UIControlEvents.TouchUpInside)
        self.view.addSubview(addbutton)
        
    }
    
    override func viewDidAppear(animated: Bool){
        
    }
    
    func refreshData() {
        sleep(2)
        refreshControl.endRefreshing()
    }
    
    var infiniteScrollingView:UIView!
    private func setupInfiniteScrollingView() {
        
        //if !firsttimeflag{
        
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
        //}
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
    
    //var information:UITextView!
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell
    {
        
        var cell = tableView.dequeueReusableCellWithIdentifier("cell") as! TableViewCell!
        
        //print("111111111111111")
        //print(numberofpost)
        if (indexPath.row < numberofpost) {
        print("cell")
        print(indexPath.row)
        print(descriptions[indexPath.row])
            var postsize:CGFloat=0.0
            var picsize:CGFloat=0.0
            
            var rectRect:CGRect = CGRectMake(0,0,self.tableView.bounds.size.width, cellSize[indexPath.row])
            var viewincell = UIView(frame: rectRect)
            viewincell.backgroundColor = UIColor.groupTableViewBackgroundColor()
            cell.addSubview(viewincell)
            
            //头像
            let image = UIImage(named:"qq.png")
            var vImg = UIImageView(image: image);
            vImg.frame = CGRectMake(unitSize*2, unitSize*2, unitSize*5, unitSize*5)
            cell.addSubview(vImg)
            
            //name
            var rectRect3:CGRect = CGRectMake(unitSize*9,unitSize*2,100, unitSize*5)
            var name = UILabel(frame:rectRect3)
            name.font = UIFont.systemFontOfSize(post_word_size)
            name.text = userName[indexPath.row]
            cell.addSubview(name)
            
            //post time
        var outputtime = (postDate[indexPath.row] as NSString).substringWithRange(NSMakeRange(5, 11))
        var rectRect1:CGRect = CGRectMake(self.tableView.bounds.size.width-unitSize*2-100,unitSize*2,100, unitSize*5)
        var timeforpost = UILabel(frame:rectRect1)
        timeforpost.font = UIFont.systemFontOfSize(post_word_size)
        timeforpost.text = outputtime//"post time later"
        cell.addSubview(timeforpost)
            
            //post
            //print(descriptions)
            var information = UILabel()//(frame:rectRect2)
            information.frame.origin.x = unitSize*9
            information.frame.origin.y = unitSize*9
            information.frame.size.width = self.tableView.bounds.size.width - unitSize*12
            information.numberOfLines = 0
            information.backgroundColor = UIColor.blueColor()
            information.font = UIFont.systemFontOfSize(post_word_size)
            information.text = descriptions[indexPath.row]
            //information.editable = false
            information.lineBreakMode = NSLineBreakMode.ByWordWrapping
            let newSize = information.sizeThatFits(CGSize(width: self.tableView.bounds.size.width - unitSize*12, height: CGFloat.max))
            //postsize = newSize.height
            information.frame.size.height = newSize.height
        cell.addSubview(information)
        //print(descriptions[indexPath.row])
        
            print("height")
            print(indexPath.row)
            print(newSize.height)
        
        
        // zan
        var rectRectdianzan:CGRect = CGRectMake(0,unitSize*11 + newSize.height, self.tableView.bounds.size.width/3, unitSize*4)
        let dianzan = UIButton(frame: rectRectdianzan)
        dianzan.setTitle("zan!", forState:UIControlState.Normal)
        dianzan.backgroundColor = UIColor.greenColor()
        dianzan.addTarget(self,action:"buttonActions:",forControlEvents:UIControlEvents.TouchUpInside)
        cell.addSubview(dianzan)
        
        //huifu
            var rectRecthuifu:CGRect = CGRectMake(self.tableView.bounds.size.width/3,unitSize*11 + newSize.height, self.tableView.bounds.size.width/3, unitSize*4)
            let huifu = UIButton(frame: rectRecthuifu)
            huifu.setTitle("huifu!", forState:UIControlState.Normal)
            huifu.backgroundColor = UIColor.greenColor()
            huifu.addTarget(self,action:"buttonActions:",forControlEvents:UIControlEvents.TouchUpInside)
            cell.addSubview(huifu)
            
            //...
            var rectRectdiandiandian:CGRect = CGRectMake(self.tableView.bounds.size.width*2/3,unitSize*11 + newSize.height, self.tableView.bounds.size.width/3, unitSize*4)
            let diandiandian = UIButton(frame: rectRectdiandiandian)
            diandiandian.setTitle("diandiandian", forState:UIControlState.Normal)
            diandiandian.backgroundColor = UIColor.greenColor()
            diandiandian.addTarget(self,action:"buttonActions:",forControlEvents:UIControlEvents.TouchUpInside)
            cell.addSubview(diandiandian)
        //cellSize[indexPath.row] = postsize + (unitSize*15)
        
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
    var background:UIButton!
    func addbuttonact(sender:UIButton!){
        self.background = UIButton()
        background.frame = CGRectMake(0, 0, self.view.bounds.size.width, self.view.bounds.size.height)
        background.backgroundColor = UIColor.lightGrayColor()
        background.alpha = 0.6
        background.addTarget(self,action:"deletebg:",forControlEvents:UIControlEvents.TouchUpInside)
        self.view.addSubview(background)
        //print("addddddd")
        //sleep(3)
        //background.removeFromSuperview()
        
        var newpost=UIButton()
        newpost.frame = CGRectMake(addbuttonorigenx - unitSize*5, addbuttonorigeny - unitSize*7, unitSize*5, unitSize*5)
        newpost.setTitle("p", forState:UIControlState.Normal)
        newpost.backgroundColor = UIColor.lightGrayColor()
        newpost.addTarget(self,action:"toNewpPost:",forControlEvents:UIControlEvents.TouchUpInside)
        self.background.addSubview(newpost)
        
        var takephoto=UIButton()
        takephoto.frame = CGRectMake(addbuttonorigenx - unitSize*10, addbuttonorigeny, unitSize*5, unitSize*5)
        takephoto.setTitle("t", forState:UIControlState.Normal)
        takephoto.backgroundColor = UIColor.lightGrayColor()
        takephoto.addTarget(self,action:"takephotoPost:",forControlEvents:UIControlEvents.TouchUpInside)
        self.background.addSubview(takephoto)
        
        var choosephoto=UIButton()
        choosephoto.frame = CGRectMake(addbuttonorigenx - unitSize*5, addbuttonorigeny + unitSize*7, unitSize*5, unitSize*5)
        choosephoto.setTitle("c", forState:UIControlState.Normal)
        choosephoto.backgroundColor = UIColor.lightGrayColor()
        choosephoto.addTarget(self,action:"buttonActions:",forControlEvents:UIControlEvents.TouchUpInside)
        self.background.addSubview(choosephoto)
        
    }
    
    func deletebg(sender:UIButton!){
        self.background.removeFromSuperview()
    }
    
    func toNewpPost(sender:UIButton!){
        var bounds = UIScreen.mainScreen().bounds
        self.view.frame = CGRectMake(0, 0, bounds.size.width, bounds.size.height)
        var ph:PinglunandHuifuViewController!
        ph = UIStoryboard(name: "Main", bundle: nil).instantiateViewControllerWithIdentifier("PinglunandHuifuViewController") as! PinglunandHuifuViewController
        ph.view.frame.size.width = bounds.size.width
        ph.view.frame.size.height = bounds.size.height
        ph.view.frame.origin.x=0
        ph.view.frame.origin.y = 0
        self.view.addSubview(ph.view!)
    }
    
    func takephotoPost(sender:UIButton!){
        showpic()
    
    }
    
    
    func showpic()
    {
        var imagePicker = UIImagePickerController()
        imagePicker.delegate=self
        imagePicker.sourceType=UIImagePickerControllerSourceType.PhotoLibrary
        imagePicker.modalTransitionStyle=UIModalTransitionStyle.CoverVertical
        imagePicker.allowsEditing=true
        self.presentViewController(imagePicker, animated:true, completion: nil)
    }
    
    
    
    func imagePickerController(picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : AnyObject])
    {
        self.dismissViewControllerAnimated(true, completion:nil);
        let gotImage=info[UIImagePickerControllerOriginalImage]as! UIImage
        //let midImage:UIImage=self.imageWithImageSimple(gotImage,scaledToSize:CGSizeMake(1000.0,1000.0))//这是对图片进行缩放，因为固定了长宽，所以这个方法会变型，有需要的自已去完善吧， 这里只是粗略使用。
        //upload(midImage)//上传
    }
    
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath)
    {
        let cell = tableView.cellForRowAtIndexPath(indexPath)
        cell?.selectionStyle = UITableViewCellSelectionStyle.None
        
        print(indexPath.row)
        
        
        
        
    }

    func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat{
        
        //post infor
        if indexPath.row < numberofpost{
            //print(descriptions)
            var information = UILabel()//(frame:rectRect2)
            information.frame.origin.x = unitSize*9
            information.frame.origin.y = unitSize*9
            information.frame.size.width = self.tableView.bounds.size.width - unitSize*12
            information.numberOfLines = 0
            information.backgroundColor = UIColor.blueColor()
            information.font = UIFont.systemFontOfSize(post_word_size)
            information.text = descriptions[indexPath.row]
            information.lineBreakMode = NSLineBreakMode.ByWordWrapping
            var newSize = information.sizeThatFits(CGSize(width: self.tableView.bounds.size.width - unitSize*12, height: CGFloat.max))
            
            cellSize[indexPath.row]=unitSize*15+newSize.height
        }
        //print(cellSize[indexPath.row])
        return cellSize[indexPath.row];
    }
    
}