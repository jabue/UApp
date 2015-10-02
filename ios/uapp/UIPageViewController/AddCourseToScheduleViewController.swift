//
//  AddCourseToScheduleViewController.swift
//  Uapp
//
//  Created by zhaofei on 2015-09-28.
//  Copyright © 2015 Vea Software. All rights reserved.
//
//  Add a course to schedule

import UIKit

class AddCourseToScheduleViewController: UIViewController {
    
    @IBOutlet weak var _tableView: UITableView!
    
    @IBOutlet weak var labelTitle: UILabel!
    
    @IBOutlet weak var labelSection: UILabel!
    
    
    
    @IBOutlet weak var textDescription: UITextField!
    
    @IBOutlet weak var labelInstructor: UILabel!
    
    @IBOutlet weak var labelDayTime: UILabel!
    
    @IBOutlet weak var labelLocation: UILabel!
    
    
    var _grids = ["day1", "day2"]
    
    var course:JSON = []
    
    override func viewDidLoad() {
        self.title = course["course_nbr"].string
        //self.navigationItem.backBarButtonItem?.title = "BACd" // gosh, it won't work.
        self.navigationItem.hidesBackButton = true
        let backButton = UIBarButtonItem(title: "< Back", style: UIBarButtonItemStyle.Plain, target: self, action: Selector("myCustomBack"))
        self.navigationItem.leftBarButtonItem = backButton
        
        
        //print("will add \(course)")
        // show course details to the view
        labelTitle.text = course["title"].string
        labelSection.text = course["course_section"].string
        textDescription.text = course["description"].string
        labelInstructor.text = course["instructor"].string
        
        labelDayTime.layer.borderColor = UIColor.blackColor().CGColor;
        labelDayTime.layer.borderWidth = 0.5;
        labelDayTime.font = UIFont(name: "TrebuchetMS-Bold", size: 18)
        labelLocation.layer.borderColor = UIColor.blackColor().CGColor;
        labelLocation.layer.borderWidth = 0.5;
        labelLocation.font = UIFont(name: "TrebuchetMS-Bold", size: 18)
        
        var day = []
        let days = course["days"].string
        
        var index: Int
        for index = 0; ; ++index {
            day += [days?.substringToIndex(<#T##index: Index##Index#>)]
            
            

        }
        
        

        
    }
    
    
    func myCustomBack() -> Void {
        self.navigationController?.popViewControllerAnimated(true)
    }
    
    // Cancel clicked, go back to last view
    @IBAction func cancelBtnPressed(sender: AnyObject) {
        self.dismissViewControllerAnimated(true, completion: nil)
    }
    
    // Add clicked
    @IBAction func addBtnPressed(sender: AnyObject) {
        let cm = CommonFunc()
        let Lambda = AWSLambda.defaultLambda()
        let request = AWSLambdaInvocationRequest()
        
        request.functionName = LamdaAddCourseToSchedule
        
        let days = course["days"].string
        let end_time = course["end_time"].string
        let room = course["room"].string
        let start_time = course["start_time"].string
        let meeting_dates = course["meeting_dates"].string
        
        request.payload = "{\"user_id\": \"\(cm.getEmail())\",\"school\":\"\(cm.getSchool())\", \"course_nbr\":\"\(cm.unwrapString(self.title))\",\"course_section\": \"\(cm.unwrapString(labelSection.text))\", \"title\": \"\(cm.unwrapString(labelTitle.text))\",\"days\":\"\(cm.unwrapString(days))\",\"description\":\"\(cm.unwrapString(textDescription.text))\",\"end_time\":\"\(cm.unwrapString(end_time))\", \"instructor\":\"\(cm.unwrapString(labelInstructor.text))\",\"room\":\"\(cm.unwrapString(room))\",\"start_time\":\"\(cm.unwrapString(start_time))\",\"meeting_dates\":\"\(cm.unwrapString(meeting_dates))\"}"
        
        //print("request: \(request.payload)")
        Lambda.invoke(request)
            .continueWithBlock({(task) -> AnyObject! in
                if let error = task.error {
                    print("lambda invoke failed: [\(error)]")
                }
                else if let exception = task.exception {
                    print("lambda invoke failed: [\(exception)]")
                }
                else {
                    print("lambda excutes succeed.")
                    
                    //Create the AlertController
                    let actionSheetController: UIAlertController = UIAlertController(title: "UApp", message:
                        "\(cm.unwrapString(self.title)) \(cm.unwrapString(self.labelSection.text)) has been successfully added to your schedule, would you like to ...", preferredStyle: .ActionSheet)
                    
                    // Create and add 'go to see your schedule' option
                    let seeScheduleAction: UIAlertAction = UIAlertAction(title: "Go to see your schedule", style: .Default) { action -> Void in
                        //Code for displaying schedule goes here
                    }
                    actionSheetController.addAction(seeScheduleAction)
                    
                    // Create and add 'add another course' option action
                    let addAnotherAction: UIAlertAction = UIAlertAction(title: "Add another course", style: .Default) { action -> Void in
                        //Code for adding another course roll goes here
                        
                    }
                    actionSheetController.addAction(addAnotherAction)                    
                    self.presentViewController(actionSheetController, animated: true, completion: nil)

                }
                return nil
            })

        
    }
    
    func initAndFillGridArray() -> Void {
        for var i = 0; i < 4; ++i {
            _grids.append(String(format: "day%d",  i))
        }
        print(_grids)
    }
    
    override func loadView() -> Void {
        super.loadView()
        initAndFillGridArray()
    }
    
    
    
     func numberOfSectionsInTableView(tableView: UITableView) -> Int{
        return _grids.count
    }
    
    func tableView() -> Int {
        return 1
    }
    
}

