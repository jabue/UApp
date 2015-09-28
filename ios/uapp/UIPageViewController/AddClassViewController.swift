//
//  AddClassViewController.swift
//  Uapp
//
//  Created by zhaofei on 2015-09-25.
//  Copyright © 2015 Vea Software. All rights reserved.
//

import UIKit

class AddClassViewController: UITableViewController, UISearchBarDelegate {
    
    @IBOutlet weak var searchClass: UISearchBar!
    @IBOutlet var classTable: UITableView!
    
    var searchActive : Bool = false
    
    var data: [String] = []
    var filtered:[String] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        print("AddClassViewController loading...")
        
        /* Setup delegates */
        classTable.delegate = self
        classTable.dataSource = self
        searchClass.delegate = self
    }
    
    override func viewDidAppear(animated: Bool) {
        let cm = CommonFunc()
        let Lambda = AWSLambda.defaultLambda()
        let request = AWSLambdaInvocationRequest()
        
        request.functionName = LambdaGetCourseList
        request.payload = "{\"school\": \"\(cm.getSchool())\"}"
        
        Lambda.invoke(request)
            .continueWithBlock({(task) -> AnyObject! in
                if let error = task.error {
                    print("lambda invoke failed: [\(error)]")
                }
                else if let exception = task.exception {
                    print("lambda invoke failed: [\(exception)]")
                }
                else {
                    let json = JSON(task.result.payload)
                
                    for (_, item):(String, JSON) in json["Items"] {
                        if let course_nbr = item["course_nbr"].string {
                            self.data += [course_nbr + " " + item["title"].string!]
                        }
                    }
                    dispatch_async(dispatch_get_main_queue(),{self.tableView.reloadData()}) // load course data to the table on the main thread
                }
                return nil
            })
    }
    
    // go back to Schedule page when 'back' bar is clicked
    @IBAction func backBarPressed(sender: AnyObject) {
        self.dismissViewControllerAnimated(true, completion: nil)
    }
    
    func searchBarTextDidBeginEditing(searchBar: UISearchBar) {
        searchActive = true;
    }
    
    func searchBarTextDidEndEditing(searchBar: UISearchBar) {
        searchActive = false;
    }
    
    func searchBarCancelButtonClicked(searchBar: UISearchBar) {
        searchActive = false;
    }
    
    func searchBarSearchButtonClicked(searchBar: UISearchBar) {
        searchActive = false;
    }
    
    func searchBar(searchBar: UISearchBar, textDidChange searchText: String) {
        filtered = data.filter({ (text) -> Bool in
            let tmp: NSString = text
            let range = tmp.rangeOfString(searchText, options: NSStringCompareOptions.CaseInsensitiveSearch)
            return range.location != NSNotFound
        })
        if(filtered.count == 0){
            searchActive = false;
        } else {
            searchActive = true;
        }
        self.tableView.reloadData()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func numberOfSectionsInTableView(classTable: UITableView) -> Int {
        return 1
    }
    
    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if(searchActive) {
            return filtered.count
        }
        return data.count;
    }
    
    override func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        print("user has selected a cell \(data[indexPath.row])")
    }

    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = classTable.dequeueReusableCellWithIdentifier("Cell")
        if(searchActive){
            cell!.textLabel?.text = filtered[indexPath.row]
        } else {
            cell!.textLabel?.text = data[indexPath.row]
        }
        return cell!
    }
}




