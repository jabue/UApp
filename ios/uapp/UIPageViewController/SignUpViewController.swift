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
    
   
    @IBAction func buttonSubmit(sender: UIButton) {
        print("button submit clicked.")
        
        let Lambda = AWSLambda(forKey: "USEast1Lambda")
       
        let request = AWSLambdaInvocationRequest()
        
        request.functionName = "queryDB"
        //request.clientContext = ""
        request.payload = [
            "user_id": "a@s.on"
        ]
        print(NSJSONSerialization.isValidJSONObject(request.payload))
        
               
        //request.invokeArgs = ("":"", "",:"")
        
        var awsReturn: AWSTask = Lambda.invoke(request)
        print(awsReturn.description)
        if (awsReturn.error != nil){
            print("error: \(awsReturn.error)")
        }
        if(awsReturn.result != nil)
        {
            print(awsReturn.result)
        }
        
        
        
       

        
       
        }
    }
    
    

