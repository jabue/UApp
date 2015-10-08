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
    
    
    var _grids = [String]()
    
    var course:JSON = []
    
    override func viewDidLoad() {
        
        print("AddCourseToScheduleViewController loading...")
        self.title = course["course_nbr"].string
        //self.navigationItem.backBarButtonItem?.title = "BACd" // gosh, it won't work.
        self.navigationItem.hidesBackButton = true
        let backButton = UIBarButtonItem(title: "Back", style: UIBarButtonItemStyle.Plain, target: self, action: Selector("myCustomBack"))
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
        
        
        var days = course["days"].string
        var room = course["room"].string
        print("days: \(days) \(days?.characters.count) location: \(room)")
        
        for var idx = 0; ; ++idx {
            if days?.characters.count != 0 && days != nil && days != "TBD" {
                let startIndex = advance(days!.startIndex, 2)
                let day = days!.substringToIndex(startIndex)
                days = days!.substringFromIndex(startIndex)
                
                print("day = \(day)")
                
                let wid = labelDayTime.frame.width
                let het = labelDayTime.frame.height
                let x = labelDayTime.frame.origin.x
                let y = labelDayTime.frame.origin.y + CGFloat(idx + 1) * het
                
                
                let ilabel = UILabel(frame: CGRectMake(x, y, wid, het))
                ilabel.text = day
                ilabel.layer.borderColor = UIColor.blackColor().CGColor
                ilabel.layer.borderWidth = 0.5;
                ilabel.textAlignment = .Center

                self.view.addSubview(ilabel)
                
                if let range = room!.rangeOfString("|") {
                    var index: Int = distance(room!.startIndex, range.startIndex)
                    let roomLabel = UILabel(frame: CGRectMake(x + wid, y, wid, het))
                    
                    var locationIdx = advance(room!.startIndex, index)
                    roomLabel.text = room?.substringToIndex(locationIdx)
                    roomLabel.layer.borderColor = UIColor.blackColor().CGColor
                    roomLabel.layer.borderWidth = 0.5
                    roomLabel.textAlignment = .Center
                    self.view.addSubview(roomLabel)
                    locationIdx = advance((room?.startIndex)!, index + 1)
                    room = room?.substringFromIndex(locationIdx)
                    print("room = \(room)")
                }else {
                    let roomLabel = UILabel(frame: CGRectMake(x + wid, y, wid, het))
                    roomLabel.text = room
                    roomLabel.layer.borderColor = UIColor.blackColor().CGColor
                    roomLabel.layer.borderWidth = 0.5
                    roomLabel.textAlignment = .Center
                    self.view.addSubview(roomLabel)
                }                
            }
            else{
                if days == "TBD" {
                    let wid = labelDayTime.frame.width
                    let het = labelDayTime.frame.height
                    let x = labelDayTime.frame.origin.x
                    let y = labelDayTime.frame.origin.y + het
                    
                    let ilabel = UILabel(frame: CGRectMake(x, y, wid, het))
                    ilabel.text = days
                    ilabel.layer.borderColor = UIColor.blackColor().CGColor
                    ilabel.layer.borderWidth = 0.5;
                    ilabel.textAlignment = .Center
                    self.view.addSubview(ilabel)
                    
                    let roomLabel = UILabel(frame: CGRectMake(x + wid, y, wid, het))
                    
                    roomLabel.text = room
                    roomLabel.layer.borderColor = UIColor.blackColor().CGColor
                    roomLabel.layer.borderWidth = 0.5
                    roomLabel.textAlignment = .Center
                    self.view.addSubview(roomLabel)
                    
                }
                break
            }
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
        
        request.functionName = LambdaAddCourseToSchedule
        
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

