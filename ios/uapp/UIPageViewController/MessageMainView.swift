//
//  MessageMainView.swift
//  UIPageViewController
//
//  Created by EV Technologies Inc. on 2015-09-18.
//  Copyright © 2015 Vea Software. All rights reserved.
//

//
//  ViewController.swift
//  EVChat
//
//  Created by EV Technologies Inc. on 2015-09-10.
//  Copyright © 2015 EV Technologies Inc. All rights reserved.
//

import UIKit
// import JSQMessagesViewController

class MessageMainView: UIViewController, UITableViewDataSource, UITableViewDelegate, AddFriendsDelegate {
    @IBOutlet weak var subview: UIView!
    
    @IBOutlet weak var BtnEdit: UIButton!
    @IBOutlet weak var ChatTable: UITableView!
    @IBOutlet weak var InsideTable: UITableView!
    @IBOutlet weak var SegmentControl: UISegmentedControl!
    @IBOutlet var SwipeRight: UISwipeGestureRecognizer!
    @IBOutlet var SwipeLeft: UISwipeGestureRecognizer!
    @IBOutlet weak var AddButton: UIButton!
    
    var sideBarToken = false
    // chat queue
    // var ChatArray = ["Jabue"]
    var messages = [PFObject]()
    // side bar setups
    var setpage:SetBarViewController!
    var showsetbar:Bool!
    var setbarinfro:CGFloat = SetBarSetting.sizeofsetbar
    var speedofsetbar = SetBarSetting.speedofsetbar
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // side bar setups
        setpage = UIStoryboard(name: "Main", bundle: nil).instantiateViewControllerWithIdentifier("SetBarViewController") as! SetBarViewController
        self.view.addSubview(setpage.view!)
        setpage.view.frame.size.width = setbarinfro
        setpage.view.frame.origin.x = -setbarinfro
        showsetbar = false
        // Do any additional setup after loading the view, typically from a nib.
        // ChatTable setup
        ChatTable.delegate = self
        ChatTable.dataSource = self
        // set up table display
        ChatTable.hidden = false
        InsideTable.hidden = true
        
        if PFUser.currentUser() != nil {
            self.loadMessages()

        }
        
        /*
        //hand swipe
        let leftSwipe = UISwipeGestureRecognizer(target: self, action: Selector("handleSwipes:"))
        
        var rightSwipe = UISwipeGestureRecognizer(target: self, action: Selector("handleSwipes:"))
        
        leftSwipe.direction = .Left
        rightSwipe.direction = .Right
        
        view.addGestureRecognizer(leftSwipe)
        view.addGestureRecognizer(rightSwipe)
        */
        
        
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    // MARK: - Backend methods
    func loadMessages() {
        let query = PFQuery(className: "Messages")
        query.whereKey("user", equalTo: PFUser.currentUser()!)
        // print(PFUser.currentUser())
        query.includeKey("lastUser")
        query.orderByDescending("updatedAction")
        query.findObjectsInBackgroundWithBlock { (objects: [PFObject]?, error: NSError?) -> Void in
            if error == nil {
                self.messages.removeAll(keepCapacity: false)
                self.messages += objects as! [PFObject]!
                self.ChatTable.reloadData()
            } else {
                print("fail to load all the messages !")
            }
        }
    }
    
    // Mark: Segmented Controller
    @IBAction func SegmentSwitch(sender: UISegmentedControl) {
        switch SegmentControl.selectedSegmentIndex
        {
        case 0:
            // self.ChatContainer.hidden = true
            // self.InsideContainer.hidden = false
            self.ChatTable.hidden = false
            self.InsideTable.hidden = true
        case 1:
            // self.ChatContainer.hidden = false
            // self.InsideContainer.hidden = true
            self.ChatTable.hidden = true
            self.InsideTable.hidden = false
        default:
            break;
        }
    }
    
    // Mark: Swipe gesture
    @IBAction func swipeRight(sender: AnyObject) {
        if SegmentControl.selectedSegmentIndex == 1
        {
            // self.ChatContainer.hidden = true
            // self.InsideContainer.hidden = false
            self.ChatTable.hidden = false
            self.InsideTable.hidden = true
            SegmentControl.selectedSegmentIndex = 0
        }
        else
        {
            if !sideBarToken {
                UIView.animateWithDuration(speedofsetbar , animations: {
                    
                    self.setpage.view.frame.origin.x = self.setpage.view.frame.origin.x + self.setbarinfro
                    self.subview.frame.origin.x = self.subview.frame.origin.x + self.setbarinfro
                    
                })
                sideBarToken = true
            }
            
        }
        
    }
    
    @IBAction func swipeLeft(sender: AnyObject) {
        if sideBarToken
        {
            UIView.animateWithDuration(speedofsetbar , animations: {
                
                self.setpage.view.frame.origin.x = self.setpage.view.frame.origin.x - self.setbarinfro
                self.subview.frame.origin.x = self.subview.frame.origin.x - self.setbarinfro
                
            })
            sideBarToken = false
        }
        else{
            if SegmentControl.selectedSegmentIndex == 0
            {
                self.ChatTable.hidden = true
                self.InsideTable.hidden = false
                // self.ChatContainer.hidden = false
                // self.InsideContainer.hidden = true
                SegmentControl.selectedSegmentIndex = 1
                
            }
        }
        
    }
    
    // Mark: add button action
    @IBAction func addButtonAction(sender: AnyObject) {
        // go to different views depends on the segmented choice
        if SegmentControl.selectedSegmentIndex == 0
        {
            self.performSegueWithIdentifier("SelectFriends", sender: self)
        }
        else
        {
            self.performSegueWithIdentifier("PushInsides", sender: self)
        }
    }
    
    //MARK: - Tableview Delegate & Datasource
    func tableView(tableView:UITableView, numberOfRowsInSection section:Int) -> Int
    {
        // return friendsArray.count
        // print("Chat Array Length:" +  "\(self.ChatArray.count)")
        return self.messages.count
    }
    
    func numberOfSectionsInTableView(tableView: UITableView) -> Int
    {
        // make sections of the table
        return 1
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell
    {
        
        let cell = tableView.dequeueReusableCellWithIdentifier("ChatCell", forIndexPath: indexPath) as! UITableViewCell
        let message = messages[indexPath.row]
        // deal with the description String
        // var description = message["description"] as! String
        // let userName = PFUser.currentUser()?.username
        // description.rangeOfString(username)
        cell.textLabel?.text = message["description"] as! String
        return cell
    }
    
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath)
    {
        tableView.deselectRowAtIndexPath(indexPath, animated: true)
        // open chat selected
        let message = self.messages[indexPath.row] as PFObject
        let groupId = message["groupId"] as! String
        self.performSegueWithIdentifier("OpenChat", sender: groupId)
    }
    
    // MARK: - SelectMultipleDelegate
    // select friends gonna chat with
    func didSelectMultipleUsers(selectedUsers: [PFUser]!) {
        let groupId = MessageAction.startMultipleChat(selectedUsers)
        self.loadMessages()
        self.ChatTable.reloadData()
        self.performSegueWithIdentifier("OpenChat", sender: groupId)
    }
    
    // MARK: - Prepare for segue to chatVC
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if segue.identifier == "SelectFriends" {
            let addFriends = segue.destinationViewController as! AddFriends
            // set up the delegate
            addFriends.delegate =  self
        }
        else if segue.identifier == "OpenChat" {
            // do some setuo for the Chat view
            let nav = segue.destinationViewController as! UINavigationController
            let ChatView = nav.topViewController as! ChatViewController
            
            let groupId = sender as! String
            ChatView.groupId = groupId
        }
        
    }
    
    @IBAction func btnEditPressed(sender: AnyObject) {
        
    }
    
}


