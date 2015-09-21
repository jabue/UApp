//
//  LaunchAfter.swift
//  UIPageViewController
//
//  Created by EV Technologies Inc. on 2015-09-08.
//  Copyright © 2015 Vea Software. All rights reserved.
//
import UIKit

class LaunchAfter: UIViewController {
    
    // query if there is any selected school before
    func findSchoolInfo() -> String {
        var result:String = ""
        
        let paths = NSSearchPathForDirectoriesInDomains(.DocumentDirectory, .UserDomainMask, true) as NSArray
        let documentsDirectory = paths.objectAtIndex(0) as! NSString
        let path = documentsDirectory.stringByAppendingPathComponent("school name.plist")
        
        let resultDictionary = NSMutableDictionary(contentsOfFile: path)
        
        let schoolName:String = "school"
        if resultDictionary?.objectForKey(schoolName) != nil{
            result = (resultDictionary?.objectForKey(schoolName)) as! String
        }
        
        print("School Info \(result)")
        
        return result
    }
    
    func findemail() -> String{
        var result:String = ""
        
        let paths = NSSearchPathForDirectoriesInDomains(.DocumentDirectory, .UserDomainMask, true) as NSArray
        let documentsDirectory = paths.objectAtIndex(0) as! NSString
        let path = documentsDirectory.stringByAppendingPathComponent("userinf.plist")
        
        let resultDictionary = NSMutableDictionary(contentsOfFile: path)
        
        let schoolName:String = "email"
        if resultDictionary?.objectForKey(schoolName) != nil{
            result = (resultDictionary?.objectForKey(schoolName)) as! String
        }
        print("School Info \(result)")
        
        return result
    }
    
    func findpw() -> String{
        var result:String = ""
        
        let paths = NSSearchPathForDirectoriesInDomains(.DocumentDirectory, .UserDomainMask, true) as NSArray
        let documentsDirectory = paths.objectAtIndex(0) as! NSString
        let path = documentsDirectory.stringByAppendingPathComponent("userinf.plist")
        
        let resultDictionary = NSMutableDictionary(contentsOfFile: path)
        
        let schoolName:String = "pw"
        if resultDictionary?.objectForKey(schoolName) != nil{
            result = (resultDictionary?.objectForKey(schoolName)) as! String
        }
        print("School Info \(result)")
        
        return result
    }
    
    func firsttimelogin() -> String{
        var result:String = ""
        
        let paths = NSSearchPathForDirectoriesInDomains(.DocumentDirectory, .UserDomainMask, true) as NSArray
        let documentsDirectory = paths.objectAtIndex(0) as! NSString
        let path = documentsDirectory.stringByAppendingPathComponent("firsttimecheck.plist")
        
        let resultDictionary = NSMutableDictionary(contentsOfFile: path)
        
        let schoolName:String = "newuser"
        if resultDictionary?.objectForKey(schoolName) != nil{
            result = (resultDictionary?.objectForKey(schoolName)) as! String
        }
        print("School Info \(result)")
        
        return result
    }
    
    func firstTimeFlagChange() {
        
        //        let paths = NSSearchPathForDirectoriesInDomains(.DocumentDirectory, .UserDomainMask, true) as NSArray
        //        let documentsDirectory = paths.objectAtIndex(0) as! NSString
        //        let path = documentsDirectory.stringByAppendingPathComponent("firsttimecheck.plist")
        //
        //        let dict = NSMutableDictionary(contentsOfFile: path)
        //        //saving values
        //        dict!.setObject("2", forKey: "newuser")
        //
        //        dict!.writeToFile(path, atomically: true)
        //
        //        let resultDictionary = NSMutableDictionary(contentsOfFile: path)
        //
        //        print("Saved GameData.plist file is --> \(resultDictionary?.description)")
        
        
        let temp:String = "2"
        let paths = NSSearchPathForDirectoriesInDomains(.DocumentDirectory, .UserDomainMask, true) as NSArray
        let documentsDirectory = paths.objectAtIndex(0) as! NSString
        let path = documentsDirectory.stringByAppendingPathComponent("firsttimecheck.plist")
        
        var dict: NSMutableDictionary = ["XInitializerItem": "DoNotEverChangeMe"]
        //saving values
        dict.setObject(temp, forKey: "newuser")
        //...
        
        //writing to GameData.plist
        //dict.writeToFile(path, atomically: false)
        dict.writeToFile(path, atomically: true)
        
        let resultDictionary = NSMutableDictionary(contentsOfFile: path)
        
        print("Saved GameData.plist file is --> \(resultDictionary?.description)")
        
    }
    
    func trylogin(email:String, pw:String)->Bool{
        let Lambda = AWSLambda.defaultLambda()
        var pwd = ""
        var ret = 0
        //AWSLogger.defaultLogger().logLevel = .Verbose
        
        let request = AWSLambdaInvocationRequest()
        request.functionName = LambdaGetPassword
        let emailInput = email
        request.payload = "{\"user_id\": \"\(emailInput)\"}"
        print(request)
        Lambda.invoke(request).continueWithBlock({(task) -> AnyObject! in
            if let error = task.error {
                print("lambda invoke failed: [\(error)]")
                ret=1
            }
            else if let exception = task.exception {
                print("lambda invoke failed: [\(exception)]")
                ret=1
            }
            else{
                print("DEBUG: call lambda sucessfully")
                print(task.result)
                pwd = String(task.result.payload)
                // print("password= \"\(pwd)\"")
                if (pwd == "NotFound"){ // user_id not found
                    ret=1
                }
                else{ // return and compare password
                    if (pwd != pw){
                        ret=1
                    }
                    else{
                        print("skip to home page1.")
                        ret=2
                        
                        
                    }
                    
                }
                
            }
            return nil
        })
        //print("333333333")
        while ret == 0{
            //print(ret)
        }
        if ret == 2{
            return true
        }
        else{
            return false
        }
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // print("Runing here ....")
        //self.performSegueWithIdentifier("LaunchToFindSchool", sender: self)
        let schoolName:String = findSchoolInfo()
        let email:String = findemail()
        let pw:String = findpw()
        let ftlog:String = firsttimelogin()
        
        
        if ftlog.isEmpty{
            firstTimeFlagChange()
            dispatch_async(dispatch_get_main_queue(), {self.performSegueWithIdentifier("welcome", sender: self)
            });
            
        }
        else{
            if schoolName.isEmpty
            {
                // turn to select school view
                dispatch_async(dispatch_get_main_queue(), {self.performSegueWithIdentifier("LaunchToFindSchool", sender: self)
                });
                
            }
            else{
                var flag:Bool  = trylogin(email,pw: pw)
                print(flag)
                print("22222222222222 222 2 2 22 2 2 ")
                if flag {
                    dispatch_async(dispatch_get_main_queue(),{
                        self.performSegueWithIdentifier("tohomepage", sender: self)
                    });
                    
                }
                else{
                    dispatch_async(dispatch_get_main_queue(), {self.performSegueWithIdentifier("LaunchToLogin", sender: self)
                    });
                }
            }
        }
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
}