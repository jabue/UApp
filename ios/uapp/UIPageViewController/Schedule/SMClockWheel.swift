//
//  SMRotaryWheel.swift
//
//
//  Created by zhaofei on 2015-09-21.
//
//

import UIKit
import QuartzCore


class SMClockWheel: UIControl {
    
    var delegate: SMRotaryProtocol?
    var container: UIView?
    var numberOfSections: Int  = 7
    var startTransform: CGAffineTransform = CGAffineTransformMake(1.0, 0.0, 0.0, -1.0, 0.0, 200.0)
    var deltaAngle : Float
    var sectors = [SMSector]()
    var sectorLabel:UILabel = UILabel()
    let minAlphavalue: CGFloat = 0.6
    let maxAlphavalue: CGFloat = 1.0
    var rotateDirection = 0
    var rotateCounter = 0
    
    var currentSector = 0 // the sector that is choosed by user to show the schedule
    init(frame: CGRect, del:ScheduleViewController, sectionsNum: Int) {
        
        self.numberOfSections = sectionsNum
        delegate = del
        self.container = del.view
        self.deltaAngle = 0
        super.init(frame: frame)
        self.drawWheel()
        
        // 4 - Timer for rotating wheel
        // NSTimer.scheduledTimerWithTimeInterval(2.0, target: self, selector: "rotate", userInfo: nil, repeats: true)
        
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func beginTrackingWithTouch(touch: UITouch, withEvent event: UIEvent?) -> Bool {
        let touchPoint: CGPoint = touch.locationInView(self)
        
        // 1.1 - Get the distance from the center
        let dist = self.calculateDistanceFromCenter(touchPoint)
        //print("when rotate begin, currentSector = \(currentSector)")
        // 1.2 - Filter out touches too close to the center
        if (dist < 40 || dist > 180)
        {
            // forcing a tap to be on the ferrule
            print("ignoring tap (%f,%f)", touchPoint.x, touchPoint.y);
            return false
        }
        
        let dx = touchPoint.x - (container?.center.x)!
        let dy = touchPoint.y - (container?.center.y)!
        
        deltaAngle = Float(atan2(dy, dx))
        startTransform = (container?.transform)!
        
        return true
    }
    
    
    
    override func continueTrackingWithTouch(touch: UITouch, withEvent event: UIEvent?) -> Bool {
        
        let touchPoint: CGPoint = touch.locationInView(self)
        
        // 1.1 - Get the distance from the center
        let dist = self.calculateDistanceFromCenter(touchPoint)
        
        // 1.2 - Filter out touches too close to the center
        if (dist < 40 || dist > 180)
        {
            // forcing a tap to be on the ferrule
            print("ignoring tap (%f,%f)", touchPoint.x, touchPoint.y);
            return false
        }
        
        let dx = touchPoint.x - (container?.center.x)!
        let dy = touchPoint.y - (container?.center.y)!
        
        let ang = atan2(dy, dx)
        let angleDifference = CGFloat(deltaAngle) - CGFloat(ang)
        //print("angleDifference=\(angleDifference), \(angleDifference * 9.0 / CGFloat(2 * M_PI))")
        container?.transform = CGAffineTransformRotate(startTransform, -angleDifference)
        
        
        return true
    }
    
    override func endTrackingWithTouch(touch: UITouch?, withEvent event: UIEvent?) {
        // 1- Get current container rotation in radians
        let radians = atan2f(Float((container?.transform.b)!), Float((container?.transform.a)!))
        
        // 2- Initialize new value
        var newVal = 0.0
        
        // 3- Iterate through all the sectors
        for s in sectors{
            // 4 - Check for anomaly (occurs with even number of sectors)
            if (s.minValue > 0 && s.maxValue < 0) {
                if (s.maxValue > radians || s.minValue < radians) {
                    // 5 - Find the quadrant (positive or negative)
                    if (radians > 0) {
                        newVal = Double(radians) - M_PI
                    } else {
                        newVal = M_PI + Double(radians)
                    }
                    currentSector = s.sector
                }
            }
                // 6 - All non-anomalous cases
            else if (radians > s.minValue && radians < s.maxValue) {
                newVal = Double(radians) - Double(s.midValue)
                currentSector = s.sector
            }
        }
        // 7- set up animation for final rotation
        UIView.animateWithDuration(0.2) {
            let t: CGAffineTransform = CGAffineTransformRotate(self.container!.transform, CGFloat(-newVal))
            self.container!.transform = t
        }
        
        // to check which label is on the current sector
        let labels = getLabelsInView()
        
        if currentSector == 0 {
            //self.delegate?.wheelDidChangeValue(String("\(labels[0].text!) is selected"))
        }else {
                    }
        
        
    }
    
    func getLabelsInView() -> [UILabel] {
        var results = [UILabel]()
        for subview in (container?.subviews)! {
            if let labelView = subview as? UILabel {
                results += [labelView]
            } else {
                results += getLabelsInView()
            }
        }
        return results
    }
    
    
    private func calculateDistanceFromCenter(point: CGPoint) -> Float{
        let center: CGPoint = CGPointMake(self.bounds.size.width/2, self.bounds.size.height/2)
        
        let dx = point.x - center.x
        let dy = point.y - center.y
        return Float(sqrt(dx*dx + dy*dy))
    }
    
    
    func btnTouched(){
        return
    }
    
    
    private func drawWheel() -> Void {
        container = UIView(frame: self.frame)
        print("clock frame : \(container?.frame)")
        
        let angleSize:CGFloat = CGFloat(2 * M_PI) / CGFloat(numberOfSections)
        let outerRidus:CGFloat = (container?.frame.width)! / 2 // outer ring for weekday
        
       
        
        // Create the sectors
        for var i = 0; i < numberOfSections; ++i {
            
            let ilabel = UILabel(frame: CGRectMake(0, 0, 60, 40))
            ilabel.backgroundColor = UIColor.clearColor()
            if i < 11 {
                if i == 0 {
                    ilabel.text  = "12"
                }else {
                    ilabel.text = String(format: "%d", i + 12)
                }
                ilabel.textColor = UIColor.redColor()
            }else if i < 13 {
                ilabel.text = ""
                ilabel.textColor = UIColor.blackColor()
            }else {
                ilabel.text = String(format: "%d", i - 9)
                ilabel.textColor = UIColor.yellowColor()
            }
            
            ilabel.textAlignment = .Center
            
            ilabel.font = ilabel.font.fontWithSize(12)
            
            ilabel.layer.anchorPoint = CGPointMake(0.5, 0.5)
            ilabel.layer.position = CGPointMake((container?.bounds.size.width)!/2, (container?.bounds.size.height)!/2)
            
            var t = CGAffineTransformIdentity
            t = CGAffineTransformTranslate(t, -outerRidus *  cos(CGFloat(i) * angleSize), outerRidus * sin(CGFloat(i) * angleSize))
            t = CGAffineTransformRotate(t, CGFloat(M_PI / 2.0) - angleSize * CGFloat(i) + CGFloat(M_PI) )
            
            ilabel.transform = t
            
            ilabel.tag = i
            container?.addSubview(ilabel)
            
            // 5- Set sector image
            /*let sectorImage = UIImageView(frame: CGRectMake(12, 15, 40, 40))
            sectorImage.image = UIImage(named: String(format: "icon%i.png", i))
            im.addSubview(sectorImage)
            container?.addSubview(im)*/
        }
        
        container?.userInteractionEnabled = false
        self.addSubview(container!)
        
        //let mask = UIImageView(frame: CGRectMake(72, 175, 58, 58))
        // mask.image = UIImage(named: "centerButton.png")
        // self.addSubview(mask)
        
        // 8 - Initialize sectors
        
        if numberOfSections % 2 == 0{
            self.buildSectorsEven()
        }else
        {
            self.buildSectorsOdd()
        }
        
    }
    
    // draw and display schedule on the selected day.
    func drawSchedule(day: String) -> Void {
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
                        //print("itme is \(item)")
                        if let course_nbr = item["course_nbr"].string {
                            self.data += [course_nbr + " " + item["title"].string!]
                            self.course += [item]
                            
                            
                        }
                    }
                    dispatch_async(dispatch_get_main_queue(),{self.tableView.reloadData()}) // load course data to the table on the main thread
                }
                return nil
            })

    }
    
    private func getSectorByValue(value: Int) -> UIImageView{
        var res = UIImageView()
        let views = [container?.subviews]
        for im in views {
            if let imageView = im as? UIImageView {
                if imageView.tag == value {
                    res = imageView
                }
            }
            
        }
        return res
    }
    
    
    
    /*func rotate() -> Void {
    let t: CGAffineTransform = CGAffineTransformRotate(container!.transform, -0.78)
    container!.transform = t
    }*/
    
    func buildSectorsOdd() -> Void {
        // 1 - Define sector length
        let fanWidth = M_PI * 2 / Double(numberOfSections)
        // 2 - Set initial midpoint
        var mid: Float = 0
        
        // 3 - Iterate through all sectors
        for var i = 0; i < numberOfSections; ++i {
            let sector = SMSector.init()
            
            // 4 - Set sector values
            sector.midValue = mid
            sector.minValue = mid - (Float(fanWidth)/2)
            sector.maxValue = mid + (Float(fanWidth)/2)
            sector.sector = i
            
            mid -= Float(fanWidth)
            
            if abs(sector.minValue - Float(-M_PI)) < 0.01 {
                mid = -mid
                mid -= Float(fanWidth)
            }
            
            // 5 - Add sector to arry
            sectors.append(sector)
            //print("sector minvalue=\(sector.minValue)")
            //print("sector: \(sector.sector), mid:\(sector.midValue * 180 / Float(M_PI)))")
            
        }
    }
    
    func buildSectorsEven() -> Void {
        // 1 - Define sector length
        let fanWidth = M_PI * 2 / Double(numberOfSections)
        // 2 - Set initial midpoint
        var mid: Float = 0
        
        // 3 - Iterate through all sectors
        for var i = 0; i < numberOfSections; ++i {
            let sector = SMSector.init()
            
            // 4 - Set sector values
            sector.midValue = mid
            sector.minValue = mid - (Float(fanWidth)/2)
            sector.maxValue = mid + (Float(fanWidth)/2)
            sector.sector = i
            
            if (sector.maxValue - Float(fanWidth)) < Float(-M_PI){
                mid = Float(M_PI)
                sector.midValue = mid
                sector.minValue = fabsf(sector.maxValue)
            }
            mid -= Float(fanWidth)
            //print("cl is \(sector.midValue)")
            
            // 5 - Add sector to arry
            sectors.append(sector)
            
            
        }
    }
    
       
    
    
    
    
    
}


