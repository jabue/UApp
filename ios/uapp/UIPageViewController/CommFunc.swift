//
//  CommFunc.swift
//  Uapp
//
//  Created by zhaofei on 2015-09-23.
//  Copyright © 2015 Vea Software. All rights reserved.
//

import Foundation

class CommonFunc {
    
    
    
    // get which school the user choose
    func getSchool() -> String {
        var result:String = ""
        
        let paths = NSSearchPathForDirectoriesInDomains(.DocumentDirectory, .UserDomainMask, true) as NSArray
        let documentsDirectory = paths.objectAtIndex(0) as! NSString
        let path = documentsDirectory.stringByAppendingPathComponent("school name.plist")
        let resultDictionary = NSMutableDictionary(contentsOfFile: path)
        let schoolName:String = "school"
        
        if resultDictionary?.objectForKey(schoolName) != nil{
            result = (resultDictionary?.objectForKey(schoolName)) as! String
        }
        
        return result
    }
    
    // get the email with whick the user login
    func getEmail() -> String {
        var result:String = ""
        
        let paths = NSSearchPathForDirectoriesInDomains(.DocumentDirectory, .UserDomainMask, true) as NSArray
        let documentsDirectory = paths.objectAtIndex(0) as! NSString
        let path = documentsDirectory.stringByAppendingPathComponent("userinf.plist")
        let resultDictionary = NSMutableDictionary(contentsOfFile: path)
        let schoolName:String = "email"
        
        if resultDictionary?.objectForKey(schoolName) != nil{
            result = (resultDictionary?.objectForKey(schoolName)) as! String
        }
        
        return result
    }
    
    
    
}
