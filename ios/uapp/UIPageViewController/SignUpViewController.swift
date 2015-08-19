//
//  SignUpViewController.swift
//  UIPageViewController
//
//  Created by zhaofei on 2015-08-13.
//  Copyright © 2015 Vea Software. All rights reserved.
//

import UIKit


class SignUpViewController: UIViewController,UITextFieldDelegate {
    
    @IBOutlet weak var emailTextField: UITextField!
    @IBOutlet weak var segmentControl: UISegmentedControl!
    @IBOutlet weak var pwdAgainTextField: UITextField!
    @IBOutlet weak var pwdTextField: UITextField!
    @IBOutlet weak var btnSubmit: UIButton!
    
    var loginOrSignup = 1 // default signup
    
    override func viewDidLoad()
    {
        super.viewDidLoad()
        
        emailTextField.delegate = self //set delegate to textfile
        pwdAgainTextField.delegate = self //set delegate to textfile
        pwdTextField.delegate = self //set delegate to textfile
        print("SignuUpViewController begin...")
    
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
    
    @IBAction func indexChanged(sender: UISegmentedControl) {
        switch segmentControl.selectedSegmentIndex
        {
            case 0:
                print("signup")
                loginOrSignup = 1 // sign up flag
                pwdAgainTextField.hidden = false
                emailTextField.text = ""
                pwdTextField.text = ""
                pwdAgainTextField.text = ""
            case 1:
                print("login")
                loginOrSignup = 0 // login flag
                pwdAgainTextField.hidden = true
                emailTextField.text = ""
                pwdTextField.text = ""
                pwdAgainTextField.text = ""
            default:
                break;
        }
        
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
        print(emailAddress)
        if(emailAddress.isEmpty){
            return false
        }
        else{
            return true
        }
        
        
    }
    @IBAction func buttonSubmit(sender: UIButton) {
        let emailInput = String(emailTextField.text!)
        
        if(checkEmail(emailInput) == false){
            let alertController = UIAlertController(title: "UApp", message:
                "Invalid Email", preferredStyle: UIAlertControllerStyle.Alert)
            alertController.addAction(UIAlertAction(title: "Ok", style: UIAlertActionStyle.Default,handler: nil))
            
            self.presentViewController(alertController, animated: true, completion: nil)
            return
        }
        
        let Lambda = AWSLambda.defaultLambda()
        var pwd = ""
        AWSLogger.defaultLogger().logLevel = .Verbose
        
        let request = AWSLambdaInvocationRequest()
        request.functionName = "queryDB"
        
        
        request.payload = "{\"user_id\": \"\(emailInput)\"}"
        print(request)
        
        
        
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
                print("password= \(pwd)")
                if (pwd == "NotFund"){ // user_id not used. load home page.
                    
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




    

