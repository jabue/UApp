//
//  FindSchoolViewController.swift
//  UIPageViewController
//
//  Created by zhaofei on 2015-08-13.
//  Copyright © 2015 Vea Software. All rights reserved.
//

import UIKit

class FindSchoolViewController: UIViewController, UITableViewDataSource, UITableViewDelegate, UISearchDisplayDelegate, UISearchBarDelegate
 {

   // @IBOutlet weak var searchBar: UISearchBar
    @IBOutlet weak var tableView: UITableView!
        
    
    var schoolsArray = [SchoolItem]()
    var filteredSchools = [SchoolItem]()
    let signupSegueIdentifier = "ShowSignUpSegue"
    
    override func viewDidLoad() {
        super.viewDidLoad()
        /*
        let filePath = NSBundle.mainBundle().pathForResource("schools", ofType: "txt")
        print(filePath!)
        let contents: NSString?
        do {
            contents = try NSString(contentsOfFile: filePath!, encoding: NSUTF8StringEncoding)
        } catch _ {
            print("read schools faild:\(filePath)")
            contents = nil
        }
        
        print(contents!)
        while  (contents?.rangeOfString("\n") != nil)
        {
            print(contents?.substringWithRange(NSMakeRange(0, contents!.rangeOfString("\n"))))
            contents =
            
        }*/
        // 读取plist
        let plistPath = NSBundle.mainBundle().pathForResource("school name", ofType:"plist")
        let plistDict = NSDictionary(contentsOfFile: plistPath!)
        var totalNum = plistDict?.objectForKey("totalNum") as! Int
        print("The Number is:\(totalNum)")
        for var i=1;i<=totalNum;i++ {
            var schoolName:String = ((plistDict?.objectForKey(String(i))!)! as? String)!
            self.schoolsArray += [SchoolItem(name: schoolName)]
        }
        
        self.tableView.reloadData()
        
        NSLog("debug begin...")
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    // MARK: - Table View
    
    func numberOfSectionsInTableView(tableView: UITableView) -> Int
    {
        return 1
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int
    {
        if (tableView == self.searchDisplayController?.searchResultsTableView)
        {
            return self.filteredSchools.count
        }
        else
        {
            return self.filteredSchools.count
        }
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell
    {
        
        let cell = self.tableView.dequeueReusableCellWithIdentifier("cell")! as UITableViewCell
        
        var school : SchoolItem
        NSLog("tableview1")
        
        if (tableView == self.searchDisplayController?.searchResultsTableView)
        {
            school = self.filteredSchools[indexPath.row]
        }
        else
        {
            school = self.schoolsArray[indexPath.row]
        }
        
        cell.textLabel?.text = school.name
        
        return cell
        
    }
    
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath)
    {
        tableView.deselectRowAtIndexPath(indexPath, animated: true)
        
        var school : SchoolItem
        
        if (tableView == self.searchDisplayController?.searchResultsTableView)
        {
            school = self.filteredSchools[indexPath.row]
        }
        else
        {
            school = self.schoolsArray[indexPath.row]
        }
        NSLog("tableview2")
        print(school.name)
        saveSchoolName(school.name)
        
    }
    
    // MARK: - Search Methods
    
    func filterContenctsForSearchText(searchText: String, scope: String = "Title")
    {
        print("search: \(searchText)")
        self.filteredSchools = self.schoolsArray.filter({( school : SchoolItem) -> Bool in
            if searchText.isEmpty {
                return false
            }
            
            let lowSchool = school.name.lowercaseString;
            let lowSearchText = searchText.lowercaseString;
            let startLetterSchool = (lowSchool as NSString).substringToIndex(1)
            let startLetterSearch = (lowSearchText as NSString).substringToIndex(1)
            
            let categoryMatch = (scope == "Title")
            let stringMatch = lowSchool.rangeOfString(lowSearchText)
            
            print("category=\(categoryMatch)")
            print ("stringMatch=\(stringMatch)")
            return categoryMatch && (startLetterSchool == startLetterSearch) && (stringMatch != nil)
            
        })
        NSLog("not found.")
        /*let alertController = UIAlertController(title: "UApp", message:
            "Not found. Please search another school.", preferredStyle: UIAlertControllerStyle.Alert)
        alertController.addAction(UIAlertAction(title: "Ok", style: UIAlertActionStyle.Default,handler: nil))
        
        self.presentViewController(alertController, animated: true, completion: nil)
        */
        
    }
    
    func searchDisplayController(controller: UISearchDisplayController, shouldReloadTableForSearchString searchString: String!) -> Bool
    {
        
        
        print("search \(searchString)")
        self.filterContenctsForSearchText(searchString, scope: "Title")
        
        return true
        
        
    }
    
    
    func searchDisplayController(controller: UISearchDisplayController, shouldReloadTableForSearchScope searchOption: Int) -> Bool
    {
        print("input search \(self.searchDisplayController!.searchBar.text!)")
        self.filterContenctsForSearchText(self.searchDisplayController!.searchBar.text!, scope: "Title")
        
        return true
    }
    
    // MARK: - Navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if segue.identifier == signupSegueIdentifier {
            print("show sign up ")
            segue.destinationViewController as! SignUpViewController
        }
    }
    
    // save school name to plist
    func saveSchoolName(name:String) {
        
        let paths = NSSearchPathForDirectoriesInDomains(.DocumentDirectory, .UserDomainMask, true) as NSArray
        let documentsDirectory = paths.objectAtIndex(0) as! NSString
        let path = documentsDirectory.stringByAppendingPathComponent("userinf.plist")
        
        //var dict: NSMutableDictionary = ["XInitializerItem": "DoNotEverChangeMe"]
        var dict: NSMutableDictionary = NSMutableDictionary()
        //saving values
        dict.setObject(name, forKey: "school")
        //...
        dict.writeToFile(path, atomically: true)
        
        let resultDictionary = NSMutableDictionary(contentsOfFile: path)
        
        let schoolName:String = "school"
        print("Saved \(resultDictionary?.objectForKey(schoolName))")
        
        
    }

    
}
