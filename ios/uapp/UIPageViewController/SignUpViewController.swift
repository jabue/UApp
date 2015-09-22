//
//  SignUpViewController.swift
//  UIPageViewController
//
//  Created by zhaofei on 2015-08-13.
//  Copyright © 2015 Vea Software. All rights reserved.
//

import UIKit


class SignUpViewController: UIViewController,UITextFieldDelegate {
    
    @IBOutlet var test: UILabel!
    
    @IBOutlet weak var emailTextField: UITextField!
    @IBOutlet weak var segmentControl: UISegmentedControl!
    @IBOutlet weak var pwdAgainTextField: UITextField!
    @IBOutlet weak var pwdTextField: UITextField!
    @IBOutlet weak var btnSubmit: UIButton!
    @IBOutlet weak var forgotPwdTextField: UITextView!
    
    var loginOrSignup = 1 // default signup
    
    var listVidos:NSMutableArray!//userinfor
    
    func textFieldDidBeginEditing(textField: UITextField) {
        animateViewMoving(true, moveValue: 100)
    }
    func textFieldDidEndEditing(textField: UITextField) {
        animateViewMoving(false, moveValue: 100)
    }
    
    func animateViewMoving (up:Bool, moveValue :CGFloat){
        var movementDuration:NSTimeInterval = 0.1
        var movement:CGFloat = ( up ? -moveValue : moveValue)
        UIView.beginAnimations( "animateView", context: nil)
        UIView.setAnimationBeginsFromCurrentState(true)
        UIView.setAnimationDuration(movementDuration )
        self.view.frame = CGRectOffset(self.view.frame, 0,  movement)
        UIView.commitAnimations()
    }
    
    override func viewDidLoad()
    {
        super.viewDidLoad()
        
        emailTextField.delegate = self //set delegate to textfile
        pwdAgainTextField.delegate = self //set delegate to textfile
        pwdTextField.delegate = self //set delegate to textfile
        
        
        forgotPwdTextField.hidden == true
        let value = UIInterfaceOrientation.Portrait.rawValue
        UIDevice.currentDevice().setValue(value, forKey: "orientation")

        print("SignuUpViewController begin...")
        /*
        var ban = NSBundle.mainBundle()
        //读取plist文件路径
        let plistpath = ban.pathForResource("tgs", ofType: "plist")!
        //读取plist内容放到NSMutableArray内
        listVidos = NSMutableArray(contentsOfFile: plistpath)
        */
        
        let paths = NSSearchPathForDirectoriesInDomains(.DocumentDirectory, .UserDomainMask, true) as NSArray
        let documentsDirectory = paths.objectAtIndex(0) as! NSString
        let path = documentsDirectory.stringByAppendingPathComponent("userinf.plist")
        saveemailandpw()
        
        var listData1: NSDictionary = NSDictionary()
        listData1 = NSDictionary(contentsOfFile: path)!
        
        var semaill = listData1.objectForKey("email")
        var spww = listData1.objectForKey("pw")
        
        //var spw = listData.objectForKey("pw")
        //print(semaill!)
        //test.text = String(semaill!)
        
        
        var listData: NSDictionary = NSDictionary()
        
        var filePath = NSBundle.mainBundle().pathForResource("userinf.plist", ofType:nil )
        listData = NSDictionary(contentsOfFile: filePath!)!
    
        var semail = listData.objectForKey("email")
        var spw = listData.objectForKey("pw")
        print(semail!)
        if semail != nil {
            segmentControl.selectedSegmentIndex = 1
            pwdAgainTextField.hidden = true
            forgotPwdTextField.hidden = true
            loginOrSignup = 0
            //segmentControl.selectedSegmentIndex{}
            
            emailTextField.text = String(semaill!)
            pwdTextField.text = String(spww!)
            //trylogin()
            
        }
        //resetemailandpw()
        
    }
    
    
    override func viewDidLayoutSubviews() {
        
        
        let border = CALayer()
        let width = CGFloat(1.0)
        border.borderColor = UIColor.lightGrayColor().CGColor
        border.frame = CGRect(x: 0, y: emailTextField.frame.size.height - width, width:  emailTextField.frame.size.width, height: emailTextField.frame.size.height)
        border.borderWidth = width
        
        emailTextField.layer.addSublayer(border)
        emailTextField.layer.masksToBounds = true
        
        let border2 = CALayer()
        
        border2.borderColor = UIColor.lightGrayColor().CGColor
        border2.frame = CGRect(x: 0, y: pwdTextField.frame.size.height - width, width:  pwdTextField.frame.size.width, height: pwdTextField.frame.size.height)
        border2.borderWidth = width
        
        pwdTextField.layer.addSublayer(border2)
         pwdTextField.layer.masksToBounds = true
        
        let border3 = CALayer()
        
        border3.borderColor = UIColor.lightGrayColor().CGColor
        border3.frame = CGRect(x: 0, y: pwdTextField.frame.size.height - width, width:  pwdTextField.frame.size.width, height: pwdTextField.frame.size.height)
        border3.borderWidth = width
        
        pwdAgainTextField.layer.addSublayer(border3)
         pwdAgainTextField.layer.masksToBounds = true
        
    }
    
    
    
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func shouldAutorotate() -> Bool {
        return false
    }
    
    
    
    @IBAction func indexChanged(sender: UISegmentedControl) {
        switch segmentControl.selectedSegmentIndex
        {
            case 0:
                print("signup")
                loginOrSignup = 1 // sign up flag
                pwdAgainTextField.hidden = false
                forgotPwdTextField.hidden = true
                emailTextField.text = ""
                pwdTextField.text = ""
                pwdAgainTextField.text = ""
            case 1:
                print("login")
                loginOrSignup = 0 // login flag
                pwdAgainTextField.hidden = true
                forgotPwdTextField.hidden = false
                emailTextField.text = ""
                pwdTextField.text = ""
                pwdAgainTextField.text = ""
            default:
                break;
        }
        
    }
    
    //blink click returns
    override func touchesBegan(touches: Set<UITouch>, withEvent event: UIEvent?) {
        self.view.endEditing(true)
    }
    
    func textFieldShouldReturn(textField: UITextField) -> Bool {   //delegate method
        print("textfiled=\(textField)")
        print("loginorSignup?\(loginOrSignup)")
        if textField == self.emailTextField {
            self.pwdTextField.becomeFirstResponder()
        }
        if textField == self.pwdTextField && loginOrSignup == 0 {
            print("pwd")
            textField.resignFirstResponder()
        }
        if textField == self.pwdTextField && loginOrSignup == 1 {
            print("pwd and signup")
            self.pwdAgainTextField.becomeFirstResponder()
        }
        if textField == self.pwdAgainTextField {
            textField.resignFirstResponder()
        }
        return true
        
    }
    
    func checkEmail(emailAddress : String) -> Bool{
        if(emailAddress.isEmpty){
            return false
        }
        else{
            return true
        }
        
        
    }
    
    func checkPassword(pwd1:String, pwd2:String) -> Bool{
        print("pwd1 = \(pwd1), pwd2=\(pwd2)")
        if(pwd1.isEmpty){
            return false
        }
        if(pwd1 != pwd2){
            return false
        }
        return true
    }
    
    @IBAction func buttonSubmit(sender: UIButton) {
        trylogin()
    }
    
    func checkEmailTypeOK(emailstr : String) -> Bool{
        //emailstr.hasPrefix("1")
        let at = "@"
        let dot = "."
        //let subString = (emailstr as NSString).substringWithRange(at)
        //var nsString: NSString = emailstr
        let subRangeat = (emailstr as NSString).rangeOfString(at)   //子范围
        let subRangedot = (emailstr as NSString).rangeOfString(dot)
        //let subString = (emailstr as NSString).substringWithRange(subRange)
        if (subRangeat.length != 0 && subRangedot.length != 0){
            return true
            
        }
        //test.text=subString
        return false
    }
    
    func trylogin(){
        if checkEmailTypeOK(emailTextField.text!) {
            trylogin1()
        }
    }
    
    func trylogin1(){
        
        /*
        print("//////////////////")
        print(pwdTextField.text)
        print(emailTextField.text)
        print(loginOrSignup)
        print("//////////////////")
        */
        
        /*
        var listData: NSDictionary = NSDictionary()
        
        var filePath = NSBundle.mainBundle().pathForResource("userinf.plist", ofType:nil )
        listData = NSDictionary(contentsOfFile: filePath!)!
        
        var semail = listData.objectForKey("email")
        var spw = listData.objectForKey("pw")
        
        listData.setValue("3", forKeyPath: "emailll")
        //listData.setValue("3", forKey: "emailll")
        //listData.objectForKey("email")?.willAccessValueForKey("3")
        //listData.writeToFile(filePath!, atomically: true)
        var ssemail = listData.objectForKey("emailll")
        print("//////////////////")
        print(ssemail)
        print("//////////////////")
        */
        
        saveemailandpw()
        // copy email and pw to plist
        
        /*
        var playersDictionaryPath = NSBundle.mainBundle().pathForResource("userinf", ofType: "plist")
        
        var playersDictionary = NSMutableDictionary(contentsOfFile: playersDictionaryPath!)
        
        var playersNamesArray = playersDictionary?.objectForKey("email") as! NSDictionary
        
        //this is a label I have called player1Name
        */
        
        //playersDictionary?.writeToFile(playersDictionaryPath!, atomically: true)
        //println(myDictionary)
        /*
        var paths = NSSearchPathForDirectoriesInDomains(NSSearchPathDirectory.DocumentDirectory, NSSearchPathDomainMask.UserDomainMask, true) as NSArray
        var documentsDirectory:AnyObject = paths[0]
        var path = documentsDirectory.stringByAppendingPathComponent("userinf.plist")
        var fileManager = NSFileManager.defaultManager()
        var fileExists:Bool = fileManager.fileExistsAtPath(path)
        var data : NSMutableDictionary?
        
        data?.setValue(emailTextField.text, forKey: "email")
        data?.setValue(pwdTextField.text, forKey: "pw")
        data?.writeToFile(path, atomically: true)
        */
        /*
        var listData: NSDictionary = NSDictionary()
        
        var filePath = NSBundle.mainBundle().pathForResource("userinf.plist", ofType:nil )
        listData = NSDictionary(contentsOfFile: filePath!)!
        
        
        
        listData.setValue(5, forKey: "email")
        listData.setValue(pwdTextField.text, forKey: "pw")
        listData.writeToFile(<#T##path: String##String#>, atomically: <#T##Bool#>)
        //listData.objectForKey("email") = emailTextField.text
        //listData.objectForKey("pw") = pwdTextField.text
        
        */
        
        if(checkEmail(emailTextField.text!) == false){
            let alertController = UIAlertController(title: "UApp", message:
                "Invalid Email", preferredStyle: UIAlertControllerStyle.Alert)
            alertController.addAction(UIAlertAction(title: "Dismiss", style: UIAlertActionStyle.Default,handler: nil))
            
            self.presentViewController(alertController, animated: true, completion: nil)
            return
            
        }
        let Lambda = AWSLambda.defaultLambda()
        var pwd = ""
        //AWSLogger.defaultLogger().logLevel = .Verbose
        
        
        
        let request = AWSLambdaInvocationRequest()
        request.functionName = LambdaGetPassword
        let emailInput = emailTextField.text!
        request.payload = "{\"user_id\": \"\(emailInput)\"}"
        print(request)
        
        if (loginOrSignup == 0){ // login
            if pwdTextField.text == nil {
                let alertController = UIAlertController(title: "UApp", message:
                    "Please input password.", preferredStyle: UIAlertControllerStyle.Alert)
                alertController.addAction(UIAlertAction(title: "Ok", style: UIAlertActionStyle.Default,handler: nil))
                
                self.presentViewController(alertController, animated: true, completion: nil)
                return
            }
            Lambda.invoke(request).continueWithBlock({(task) -> AnyObject! in
                if let error = task.error {
                    print("lambda invoke failed: [\(error)]")
                }
                else if let exception = task.exception {
                    print("lambda invoke failed: [\(exception)]")
                }
                else{
                    print("DEBUG: call lambda sucessfully")
                    print(task.result)
                    pwd = String(task.result.payload)
                   // print("password= \"\(pwd)\"")
                    if (pwd == "NotFound"){ // user_id not found
                        let alertController = UIAlertController(title: "UApp", message:
                            "the user id \'\(emailInput)\' is not existed.", preferredStyle: UIAlertControllerStyle.Alert)
                        alertController.addAction(UIAlertAction(title: "Ok", style: UIAlertActionStyle.Default,handler: nil))
                        
                        self.presentViewController(alertController, animated: true, completion: nil)
                    }
                    else{ // return and compare password
                        if (pwd != self.pwdTextField.text){
                            let alertController = UIAlertController(title: "UApp", message:
                                "Wrong password.", preferredStyle: UIAlertControllerStyle.Alert)
                            alertController.addAction(UIAlertAction(title: "Ok", style: UIAlertActionStyle.Default,handler: nil))
                            
                            self.presentViewController(alertController, animated: true, completion: nil)
                        }
                        else
                        {
                            print("skip to home page.")
                            dispatch_async(dispatch_get_main_queue(),{
                                self.performSegueWithIdentifier("segueShowHome", sender: self)
                                });
                            
                        }
                        
                    }
                    
                }
                return nil
            })

            
        }
        else // signup
        {
            if(checkPassword(pwdTextField.text!, pwd2: pwdAgainTextField.text!) == false){
                let alertController = UIAlertController(title: "UApp", message:
                    "Password does not match the confirm password.", preferredStyle: UIAlertControllerStyle.Alert)
                alertController.addAction(UIAlertAction(title: "Ok", style: UIAlertActionStyle.Default,handler: nil))
                
                self.presentViewController(alertController, animated: true, completion: nil)
                return
            }
            
            Lambda.invoke(request).continueWithBlock({(task) -> AnyObject! in
                if let error = task.error {
                    print("lambda invoke failed: [\(error)]")
                }
                else if let exception = task.exception {
                    print("lambda invoke failed: [\(exception)]")
                }
                else{
                    print("DEBUG: call lambda sucessfully")
                    print(task.result)
                    pwd = String(task.result.payload)
                    print("password= \"\(pwd)\"")
                    if (pwd == "NotFound"){ // user_id not used. load home page.
                        request.functionName = LambdaSignUp
                        //request.payload = "{\"user_id\": \"\(emailInput)\",\"password\":\"\(self.pwdTextField.text!)\",\"school\": \"\("111")\" }"
                        //request.payload = "{\"user_id\": \"\(emailInput)\",\"password\":\"\(self.pwdTextField.text!)\" }"
                        var schoolinfor = self.findSchoolInfo()
                        request.payload = "{\"user_id\": \"\(emailInput)\",\"password\":\"\(self.pwdTextField.text!)\",\"school\":\"\(schoolinfor)\" }"
                        
                        
                        print(request)
                        Lambda.invoke(request).continueWithBlock({(task1) -> AnyObject! in
                            if let error1 = task1.error {
                                print("lambda invoke failed:[\(error1)]")
                                let alertController = UIAlertController(title: "UApp", message:
                                    "Server busy. Please try later.", preferredStyle: UIAlertControllerStyle.Alert)
                                alertController.addAction(UIAlertAction(title: "Ok", style: UIAlertActionStyle.Default,handler: nil))
                                
                                self.presentViewController(alertController, animated: true, completion: nil)
                            }
                            else if let exception1 = task1.exception{
                                print("lambda invoke failed: [\(exception1)]")
                                let alertController = UIAlertController(title: "UApp", message:
                                    "Server busy. Please try later.", preferredStyle: UIAlertControllerStyle.Alert)
                                alertController.addAction(UIAlertAction(title: "Ok", style: UIAlertActionStyle.Default,handler: nil))
                                
                                self.presentViewController(alertController, animated: true, completion: nil)
                            }
                            else{
                                dispatch_async(dispatch_get_main_queue(),{
                                    self.performSegueWithIdentifier("segueShowHome", sender: self)
                                });
                            }
                            return nil
                        })
                        print("skip to home page now..")
                    }
                    else{ // return password. it means that this user_id had been used.
                        let alertController = UIAlertController(title: "UApp", message:
                            "the user id \(emailInput) is taken. Please try another one!", preferredStyle: UIAlertControllerStyle.Alert)
                        alertController.addAction(UIAlertAction(title: "Ok", style: UIAlertActionStyle.Default,handler: nil))
                        
                        self.presentViewController(alertController, animated: true, completion: nil)
                        
                    }
                    
                }
                return nil
            })
            
        }
    }
    
    func saveemailandpw() {
        
        let paths = NSSearchPathForDirectoriesInDomains(.DocumentDirectory, .UserDomainMask, true) as NSArray
        let documentsDirectory = paths.objectAtIndex(0) as! NSString
        let path = documentsDirectory.stringByAppendingPathComponent("userinf.plist")
        
        var dict: NSMutableDictionary = ["XInitializerItem": "DoNotEverChangeMe"]
        //saving values
        dict.setObject(emailTextField.text!, forKey: "email")
        dict.setObject(pwdTextField.text!, forKey: "pw")
        //...
        
        //writing to GameData.plist
        //dict.writeToFile(path, atomically: false)
        dict.writeToFile(path, atomically: true)
        
        let resultDictionary = NSMutableDictionary(contentsOfFile: path)
        
        print("Saved GameData.plist file is --> \(resultDictionary?.description)")
        
        
    }

    func resetemailandpw(){
        let paths = NSSearchPathForDirectoriesInDomains(.DocumentDirectory, .UserDomainMask, true) as NSArray
        let documentsDirectory = paths.objectAtIndex(0) as! NSString
        let path = documentsDirectory.stringByAppendingPathComponent("userinf.plist")
        
        var dict: NSMutableDictionary = ["XInitializerItem": "DoNotEverChangeMe"]
        //saving values
        dict.setObject("", forKey: "email")
        dict.setObject("", forKey: "pw")
        //...
        
        //writing to GameData.plist
        //dict.writeToFile(path, atomically: false)
        dict.writeToFile(path, atomically: true)
        
        let resultDictionary = NSMutableDictionary(contentsOfFile: path)
        
        print("Saved GameData.plist file is --> \(resultDictionary?.description)")
    }
    
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

    
    
}

    
    

