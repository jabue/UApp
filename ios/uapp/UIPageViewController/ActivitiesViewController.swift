//
//  ActivitiesViewController.swift
//  UIPageViewController
//
//  Created by zhaofei on 2015-08-26.
//  Copyright © 2015 Vea Software. All rights reserved.
//

import UIKit
//import SwiftyJSON

class ActivitiesViewController: UIViewController {
    
    @IBOutlet var subview: UIView!
   
    @IBOutlet weak var post: UIButton!
   //three page
    
    var setpage:SetBarViewController!
    var showsetbar:Bool!
    
    var setbarinfro:CGFloat = SetBarSetting.sizeofsetbar 
    var speedofsetbar = SetBarSetting.speedofsetbar
    
    var swipcount:Int!
    var bounds = UIScreen.mainScreen().bounds
    
    var sbv_0:Inside!
    var sbv_1:Feeds!
    var sbv_2:HotTopic!
    var sbv_3:Discover!
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        print("Activities page loading..")
        
        setpage = UIStoryboard(name: "Main", bundle: nil).instantiateViewControllerWithIdentifier("SetBarViewController") as! SetBarViewController
        
        self.view.addSubview(setpage.view!)
        setpage.view.frame.size.width = setbarinfro
        setpage.view.frame.origin.x = -setbarinfro
        showsetbar = false
        
        //add sbv0
        sbv_0 = UIStoryboard(name: "Main", bundle: nil).instantiateViewControllerWithIdentifier("Inside") as! Inside
        sbv_0.view.frame.size.width = bounds.size.width
        sbv_0.view.frame.size.height = bounds.size.height*2/3
        sbv_0.view.frame.origin.x=0
        sbv_0.view.frame.origin.y=bounds.size.height*1/3
        self.view.addSubview(sbv_0.view!)
        
        //add sbv1
        sbv_1 = UIStoryboard(name: "Main", bundle: nil).instantiateViewControllerWithIdentifier("Feeds") as! Feeds
        sbv_1.view.frame.size.width = bounds.size.width
        sbv_1.view.frame.size.height = bounds.size.height*2/3
        sbv_1.view.frame.origin.x=bounds.size.width
        sbv_1.view.frame.origin.y=bounds.size.height*1/3
        self.view.addSubview(sbv_1.view!)

        //add sbv2
        sbv_2 = UIStoryboard(name: "Main", bundle: nil).instantiateViewControllerWithIdentifier("HotTopic") as! HotTopic
        self.view.addSubview(sbv_2.view!)
        sbv_2.view.frame.size.width = bounds.size.width
        sbv_2.view.frame.size.height = bounds.size.height*2/3
        sbv_2.view.frame.origin.x=bounds.size.width*2
        sbv_2.view.frame.origin.y=bounds.size.height*1/3
        //add sbv3
        sbv_3 = UIStoryboard(name: "Main", bundle: nil).instantiateViewControllerWithIdentifier("Discover") as! Discover
        self.view.addSubview(sbv_3.view!)
        sbv_3.view.frame.size.width = bounds.size.width
        sbv_3.view.frame.size.height = bounds.size.height*2/3
        sbv_3.view.frame.origin.x=bounds.size.width*3
        sbv_3.view.frame.origin.y=bounds.size.height*1/3
        
        //hand swipe
        let leftSwipe = UISwipeGestureRecognizer(target: self, action: Selector("handleSwipes:"))
        
        var rightSwipe = UISwipeGestureRecognizer(target: self, action: Selector("handleSwipes:"))
        
        leftSwipe.direction = .Left
        rightSwipe.direction = .Right
        
        view.addGestureRecognizer(leftSwipe)
        view.addGestureRecognizer(rightSwipe)
        
        swipcount=1
        //print(bounds.size.width)
        
        
        
        //let cm = CommonFunc()
        //print("school is \(cm.getSchool()), user is \(cm.getEmail())")
        print("connect to sever...")
        let Lambda = AWSLambda.defaultLambda()
        let request = AWSLambdaInvocationRequest()
        request.functionName = LambdaGetActivities
        request.payload = "{\"post_date\": \"2015-09-15 12:00:03\"}"
        //"{\"school\": \"Simon Fraser University(SFU)\"}"
        
        
        print(request)
        var data:String!
        
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
                data = String(task.result.payload)
                //print(data)
                
                
            }
            return nil
        })
        /*
        let jsonObject : AnyObject! = NSJSONSerialization.
            
            
            
            
            
            JSONObjectWithData(data, options: NSJSONReadingOptions.MutableContainers, error: nil)
        if let statusesArray = jsonObject as? NSArray{
            if let aStatus = statusesArray[0] as? NSDictionary{
                if let user = aStatus["user"] as? NSDictionary{
                    if let userName = user["name"] as? NSDictionary{
                        //终于我们得到了`name`
                        
                    }
                }
            }
        }
*/
        //let datas = NSData(contentsOfFile: data)!
        /*
        let json = JSON(data:datas)
        var str = NSString(data: datas, encoding: NSUTF8StringEncoding)
        //city.text = weatherinfo.objectForKey("city") as String
        let jsonObject : AnyObject! = NSJSONSerialization.JSONObjectWithData(dataFromTwitter, options: NSJSONReadingOptions.MutableContainers, error: nil)
        if let statusesArray = jsonObject as? NSArray{
            if let aStatus = statusesArray[0] as? NSDictionary{
                if let user = aStatus["user"] as? NSDictionary{
                    if let userName = user["name"] as? NSDictionary{
                        //终于我们得到了`name`
                        
                    }
                }
            }
        }
        */
        //print(str)
        
        //post.hidden = true
    }
    
    func sbvSwipe(leftsp:Bool){
        var bsize = bounds.size.width
        if leftsp{
            bsize = -bsize
        }
        UIView.animateWithDuration(0.5 , animations: {
            self.sbv_0.view.frame.origin.x = self.sbv_0.view.frame.origin.x + bsize
            self.sbv_1.view.frame.origin.x = self.sbv_1.view.frame.origin.x + bsize
            self.sbv_2.view.frame.origin.x = self.sbv_2.view.frame.origin.x + bsize
            self.sbv_3.view.frame.origin.x = self.sbv_3.view.frame.origin.x + bsize
            
        })
        
    }
    
    func handleSwipes(sender:UISwipeGestureRecognizer) ->Bool{
        
        if(sender.direction == .Left && swipcount < 4 && showsetbar == false){
            swipcount = swipcount+1
            print("11")
            sbvSwipe(true)
            return true
        }
        if(sender.direction == .Right && swipcount > 1 && showsetbar == false){
            swipcount = swipcount-1
            sbvSwipe(false)
            return true
        }
        
        if (sender.direction == .Left && showsetbar == true && swipcount == 1){
            UIView.animateWithDuration(speedofsetbar , animations: {
                self.subview.frame.origin.x = self.subview.frame.origin.x - self.setbarinfro
                self.setpage.view.frame.origin.x = self.setpage.view.frame.origin.x - self.setbarinfro
                self.sbv_0.view.frame.origin.x = self.sbv_0.view.frame.origin.x - self.setbarinfro
            
            })
            showsetbar = false
            return true
        }
        
        if (sender.direction == .Right && showsetbar == false && swipcount == 1){
            UIView.animateWithDuration(speedofsetbar, animations: {
                self.subview.frame.origin.x = self.subview.frame.origin.x + self.setbarinfro
                self.setpage.view.frame.origin.x = self.setpage.view.frame.origin.x + self.setbarinfro
                self.sbv_0.view.frame.origin.x = self.sbv_0.view.frame.origin.x + self.setbarinfro
            
            })
            showsetbar = true
            return true
            
        }

        return true
    }
    

    func transtocurrent(var transto:Int){
        var tempbooleg:Bool = false
        if transto < 0 {
            tempbooleg = true
            transto = -transto
        }
        
        for var i=0 ; i < transto ; i=i+1{
            sbvSwipe(tempbooleg)
        }
    }
    
    // swipcount
    @IBAction func Insidebutton(sender: AnyObject) {
        let transstate = 1
        let transto = swipcount - transstate
        transtocurrent(transto)
        swipcount=1
    }
    @IBAction func feedbutton(sender: AnyObject) {
        let transstate = 2
        let transto = swipcount - transstate
        transtocurrent(transto)
        swipcount=2
    }
    @IBAction func hottopicbutton(sender: AnyObject) {
        let transstate = 3
        let transto = swipcount - transstate
        transtocurrent(transto)
        swipcount=3
    }
    @IBAction func discover(sender: AnyObject) {
        let transstate = 4
        let transto = swipcount - transstate
        transtocurrent(transto)
        swipcount=4
    }

    
    
    
    
    @IBAction func addbutton(sender: AnyObject) {
        post.hidden = false
        
    }
    
    @IBAction func newposting(sender: AnyObject) {
        print("123123")
    }
    
    @IBAction func np(sender: UIButton, forEvent event: UIEvent) {
        print("123123123")
    }
    
    
}


