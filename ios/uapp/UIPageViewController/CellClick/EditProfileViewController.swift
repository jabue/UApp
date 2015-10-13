//
//  EditProfileViewController.swift
//  CellClick
//
//  Created by Smallulu on 15/9/16.
//  Copyright © 2015年 Smallulu. All rights reserved.
//

import UIKit

class EditProfileViewController: UIViewController, UITableViewDelegate, UITableViewDataSource, UINavigationControllerDelegate, UIImagePickerControllerDelegate {
    
    // section objects
    var section1 = ["Profile Photo", "QR Code"]
    var section2 = ["Name", "Change Password", "School", "Gender", "About", "Private Account"]

    var sectionInTable = ["s1", "s2"]
    
    @IBOutlet weak var tableView: UITableView!
    
    // upload data
    //var uploadRequests = Array<AWSS3TransferManagerUploadRequest?>()
    //var uploadFileURLs = Array<NSURL?>()
    
    // keep photos
    var selfPhoto: UIImage!
    var qr_sample = UIImage(named: "qq.png")
    
    // photo taking
    var photoTaker: UIImagePickerController!
    
    var titleStringViaSegue: String!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.tableView.delegate = self
        self.tableView.dataSource = self
        
    }
    
    func numberOfSectionsInTableView(editTableView: UITableView) -> Int {
        return 2
    }
    
    // pre set the number of rows in each section
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        if section == 0 {
            return section1.count
        }
        else if section == 1 {
            return section2.count
        }
        
        return 0
        
    }
    
    // allocate cell and return cell content
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        
        // Allocates a Table View Cell
        let cell = self.tableView.dequeueReusableCellWithIdentifier("edit_profile_cell", forIndexPath: indexPath) as! TableViewCell
        // Sets the text of the Label in the Table View Cell
        //aCell.titleLabel.text = self.objects[indexPath.row]
        if indexPath.section == 0{
            if indexPath.row == 0 {
                //cell.textLabel.textAlignment = NSTextAlignmentRight; // optional
                //cell.imageView?.image = selfPhoto
                let imageSubview = UIImageView(image: selfPhoto)
                print("cell width: ", cell.frame.width)
                print("cell width mid: ", cell.frame.midX)
                print("cell height: ", cell.frame.midY)
                imageSubview.frame = CGRectMake(cell.frame.midX+65, cell.frame.midY/2-20, 60, 60)
                cell.addSubview(imageSubview)
            }
            else if indexPath.row == 1 {
                let qrimageSubview = UIImageView(image: qr_sample)
                qrimageSubview.frame = CGRectMake(cell.frame.midX+65, cell.frame.midY/2-70, 60, 60)
                cell.addSubview(qrimageSubview)
            }
            
            cell.edit_second_titleLabel.text = section1[indexPath.row]
        }
        else if indexPath.section == 1 {
            cell.edit_second_titleLabel.text = section2[indexPath.row]
            //print("the section: ", indexPath.section, "the row: ", indexPath.row, "content: ", cell.edit_second_titleLabel.text)
        }
        
        return cell
    }
    
    // height for photo and qrcode cells
    func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        if indexPath.section == 0 {
            return 100
        }
        else {
            return UITableViewAutomaticDimension
        }
    }
    
    func tableView(tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return " "
    }
    
    // upload func
    func upload(uploadRequest: AWSS3TransferManagerUploadRequest) {
        let transferManager = AWSS3TransferManager.defaultS3TransferManager()
        
        transferManager.upload(uploadRequest).continueWithBlock { (task) -> AnyObject! in
            
            if (task.error != nil) {
                print("%@", task.error)
            } else {
                // if there aren't any then the image is uploaded!
                // this is the url of the image we just uploaded
                // I created a completion block in here in order
                // for it to be called like a callback function
                print("yoyocheck out")
            }
            return nil
        }
    }
    
    // func for redirecting a camera
    func imagePickerController(picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : AnyObject]) {
        photoTaker.dismissViewControllerAnimated(true, completion: nil)
        //print("Camera off...")
        self.selfPhoto = info[UIImagePickerControllerOriginalImage] as! UIImage
        
        // set photo to upload url
        let testFileURL1 = NSURL(fileURLWithPath: NSTemporaryDirectory().stringByAppendingString("temp"))
        let uploadRequest1: AWSS3TransferManagerUploadRequest = AWSS3TransferManagerUploadRequest()
        
        let data = UIImageJPEGRepresentation(self.selfPhoto, 0.2)
        data?.writeToURL(testFileURL1, atomically: true)
        uploadRequest1.bucket = "sefietest"
        uploadRequest1.key = "test1"
        uploadRequest1.body = testFileURL1
        
        self.upload(uploadRequest1)
        
        
        //selfImage.image = info[UIImagePickerControllerOriginalImage] as! UIImage
        tableView.reloadData()
    }
    
    // prepare to segue
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        print("the section: ", indexPath.section, "the row: ", indexPath.row)
        
        // photo
        if indexPath.section == 0 && indexPath.row == 0 {

            //print("the section: ", indexPath.section, "the row: ", indexPath.row)
            print("camera is loading...")
            let actionSheetController: UIAlertController = UIAlertController(title: "Change Photo", message: "Please choose from one of the following options", preferredStyle: .ActionSheet)
            
            // add the Cancel action
            let cancelAction: UIAlertAction = UIAlertAction(title: "Cancel", style: .Cancel) { action -> Void in
                //Just dismiss the action sheet
            }
            actionSheetController.addAction(cancelAction)
            
            // add first option action
            let takePictureAction: UIAlertAction = UIAlertAction(title: "Take A Picture", style: .Default) { action -> Void in
                //Code for launching the camera goes here
                
                self.photoTaker = UIImagePickerController()
                self.photoTaker.delegate = self
                self.photoTaker.sourceType = .Camera
                
                self.presentViewController(self.photoTaker, animated: true, completion: nil)
                
            }
            actionSheetController.addAction(takePictureAction)
            // add a second option action
            let choosePictureAction: UIAlertAction = UIAlertAction(title: "From the Gallery", style: .Default) { action -> Void in
                //Code for picking from camera roll goes here
            }
            actionSheetController.addAction(choosePictureAction)
            
            //Present the AlertController
            self.presentViewController(actionSheetController, animated: true, completion: nil)
            
        }
        
        // qrcode
        else if indexPath.section == 0 && indexPath.row == 1 {
            self.performSegueWithIdentifier("showQRCode", sender: self)
        }
    }
    
}
