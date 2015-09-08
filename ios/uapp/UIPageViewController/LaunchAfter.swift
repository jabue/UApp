//
//  LaunchAfter.swift
//  UIPageViewController
//
//  Created by EV Technologies Inc. on 2015-09-08.
//  Copyright © 2015 Vea Software. All rights reserved.
//
import UIKit

class LaunchAfter: UIViewController {
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // print("Runing here ....")
        //self.performSegueWithIdentifier("LaunchToFindSchool", sender: self)
        let schoolName:String = findSchoolInfo()
        if schoolName.isEmpty
        {
            // turn to select school view
            dispatch_async(dispatch_get_main_queue(), {self.performSegueWithIdentifier("LaunchToFindSchool", sender: self)
            });
            
        } else
        {
            // turn to login view
            dispatch_async(dispatch_get_main_queue(), {self.performSegueWithIdentifier("LaunchToLogin", sender: self)
            });
        }
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    // query if there is any selected school before
    func findSchoolInfo() -> String {
        var result:String = ""
        
        let paths = NSSearchPathForDirectoriesInDomains(.DocumentDirectory, .UserDomainMask, true) as NSArray
        let documentsDirectory = paths.objectAtIndex(0) as! NSString
        let path = documentsDirectory.stringByAppendingPathComponent("userinf.plist")
        
        let resultDictionary = NSMutableDictionary(contentsOfFile: path)
        
        let schoolName:String = "school"
        if resultDictionary?.objectForKey(schoolName) != nil{
            result = (resultDictionary?.objectForKey(schoolName)) as! String
        }
        
        print("School Info \(result)")
        
        return result
    }
}