//
//  qrcodeViewController.swift
//  CellClick
//
//  Created by Smallulu on 15/9/18.
//  Copyright © 2015年 Smallulu. All rights reserved.
//

import UIKit

class qrcodelViewController: UIViewController {
    
    @IBOutlet weak var textField: UITextField!
    @IBOutlet weak var imgQRCode: UIImageView!
    @IBOutlet weak var generateButton: UIButton!

    
    // declare qr object
    var qrcodeImage: CIImage!
    
    //
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    // blink click return keyboard
    override func touchesBegan(touches: Set<UITouch>, withEvent event: UIEvent?) {
        self.view.endEditing(true)
    }
    
    // button action
    @IBAction func performButtonAction(sender: AnyObject){
        //
        if qrcodeImage == nil {
            if textField.text == "" {
                return
            }
            
            // get string from textfield
            let data = textField.text!.dataUsingEncoding(NSISOLatin1StringEncoding, allowLossyConversion: false)
            //print("here success")
            
            let filter = CIFilter(name: "CIQRCodeGenerator")
            //print("here success")
            filter!.setValue(data, forKey: "inputMessage")
            filter!.setValue("Q", forKey: "inputCorrectionLevel")
            //print("here success")
            qrcodeImage = filter!.outputImage
            
            // generate qr code
            imgQRCode.image = UIImage(CIImage: qrcodeImage)
            textField.resignFirstResponder()
            
            // change the button
            generateButton.setTitle("Clear", forState: UIControlState.Normal)
        
        }
        else {
            imgQRCode.image = nil
            qrcodeImage = nil
            generateButton.setTitle("Generate", forState: UIControlState.Normal)
        }
    }
}
