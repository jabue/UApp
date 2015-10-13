//
//  ViewControllerSetting.swift
//  Uapp
//
//  Created by joey on 15/10/5.
//  Copyright © 2015年 Vea Software. All rights reserved.
//

import UIKit

class ViewControllerSetting: UIViewController, UINavigationControllerDelegate, UIImagePickerControllerDelegate {
    
    var accountObjects = ["Edit Profile", "Notification", "General Setting"]
    var supportObjects = ["Help Center", "Report a Problem", "Get Involve"]
    var aboutOjbects   = ["Terms", "Privacy Policy"]
    var sectionInTable = ["Account", "Supports", "About"]
    
    // setting options listted intable view
    @IBOutlet weak var tableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }
    
    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 3
    }
    
    // pre set the number of rows in each section
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if section == 0 {
            //print("accountobjects: ", accountObjects.count)
            return accountObjects.count
        }
        else if section == 1 {
            return supportObjects.count
        }
        else if section == 2 {
            return aboutOjbects.count
        }
        return 0
    }
    
    //================================================================================================
    
    // allocate cell and return cell content
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        // Allocates a Table View Cell
        let cell = self.tableView.dequeueReusableCellWithIdentifier("cell", forIndexPath: indexPath) as! TableViewCell
        // Sets the text of the Label in the Table View Cell
        //aCell.titleLabel.text = self.objects[indexPath.row]
        if indexPath.section == 0 {
            cell.titleLabel.text = accountObjects[indexPath.row]
        }
        else if indexPath.section == 1 {
            cell.titleLabel.text = supportObjects[indexPath.row]
        }
        else if indexPath.section == 2 {
            cell.titleLabel.text = aboutOjbects[indexPath.row]
        }
        
        return cell
    }
    
    func tableView(tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        if !self.sectionInTable[section].isEmpty {
            return self.sectionInTable[section] as String
        }
        return ""
    }
    
    //================================================================================================
    
    // cell click
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        if indexPath.section == 0 && indexPath.row == 0 {
            self.performSegueWithIdentifier("showEditProfile", sender: self)
        }
            
        else if indexPath.section == 0 && indexPath.row == 1 {
            self.performSegueWithIdentifier("showNotification", sender: self)
        }
            
        else if indexPath.section == 0 && indexPath.row == 2 {
            self.performSegueWithIdentifier("showGeneral", sender: self)
        }
        
        //self.performSegueWithIdentifier("showView", sender: self)
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    // SEGUE with cell click
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if (segue.identifier == "showEditProfile") {
            
            // self.tableView.deselectRowAtIndexPath(, animated: <#T##Bool#>)
            
            // upcoming is set to NewViewController (.swift)
            let upcoming: EditProfileViewController = segue.destinationViewController as! EditProfileViewController
            // indexPath is set to the path that was tapped
            let indexPath = self.tableView.indexPathForSelectedRow!
            // titleString is set to the title at the row in the objects array.
            //let titleString = "Edit Profile"
            // the titleStringViaSegue property of NewViewController is set.
            //upcoming.titleStringViaSegue = titleString
            self.tableView.deselectRowAtIndexPath(indexPath, animated: true)
            
        }
        
        if (segue.identifier == "showNotification") {
            
            let upcoming: NotificationViewController = segue.destinationViewController as! NotificationViewController
            let indexPath = self.tableView.indexPathForSelectedRow!
            let titleString = "Notification"
            
            upcoming.titleStringViaSegue = titleString
            self.tableView.deselectRowAtIndexPath(indexPath, animated: true)
        }
            
        else if (segue.identifier == "showGeneral") {
            
            let upcoming: GeneralViewController = segue.destinationViewController as! GeneralViewController
            let indexPath = self.tableView.indexPathForSelectedRow!
            let titleString = "General Information"
            
            upcoming.titleStringViaSegue = titleString
            self.tableView.deselectRowAtIndexPath(indexPath, animated: true)
        }
    }
    
    
}


