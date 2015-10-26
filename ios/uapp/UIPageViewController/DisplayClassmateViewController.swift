//
//  DisplayClassmateViewController.swift
//  Uapp
//
//  Created by zhaofei on 2015-10-22.
//  Copyright © 2015 Vea Software. All rights reserved.
//

import UIKit

class DisplayClassmateViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {
    
    var course: String = "" // course_nbr will be passed by segue.
    @IBOutlet var tableView: UITableView!
    var data: [String] = []
    
    override func viewDidLoad() {
        print("DisplayClassmateViewController loading...")
        print("will display classmates in course \(course)")
        self.title = "Classmates in " + course
        
        tableView.delegate = self
        tableView.dataSource = self
        
        // call server to get classmates list by course number
        let cm = CommonFunc()
        let Lambda = AWSLambda.defaultLambda()
        let request = AWSLambdaInvocationRequest()
        
        request.functionName = LambdaGetClassmates
        request.payload = "{\"user_id\": \"\(cm.getEmail())\",\"school\": \"\(cm.getSchool())\",\"course\":\"\(course)\"}"
        
        print("request: \(request.payload)")
        Lambda.invoke(request)
            .continueWithBlock({(task) -> AnyObject! in
                if let error = task.error {
                    print("lambda invoke failed: [\(error)]")
                }
                else if let exception = task.exception {
                    print("lambda invoke failed: [\(exception)]")
                }
                else {
                    print("lamda invoke success.")
                    print(task.result.payload)
                    let json = JSON(task.result.payload)
                    print(json)
                    
                    for (_, item):(String, JSON) in json["Items"] {
                        print("itme is \(item)")
                        self.data +=  [item["user_id"].string!]
                    }
                    dispatch_async(dispatch_get_main_queue(),{self.tableView.reloadData()}) // load course data to the table on the main thread
                }
                return nil
            })
    }
    
    
    @IBAction func backBarPressed(sender: AnyObject) {
        self.dismissViewControllerAnimated(true, completion: nil)
    }
    
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return data.count;
    }
    
    
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        //print("user has selected a cell \(data[indexPath.row])")
        performSegueWithIdentifier("addCourse_segue", sender: self)
    }
    
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("Cell")
        
        cell!.textLabel?.text = data[indexPath.row]
        
        return cell!
    }

}
