//  SMClockWheel.swift
//
//
//
//  Created by zhaofei on 2015-09-21.
//
//

import UIKit
import QuartzCore
import CoreGraphics


class SMClockWheel: UIControl {
    
    var delegate: SMRotaryProtocol?
    var container: UIView?
    var numberOfSections: Int  = 0
    var startTransform: CGAffineTransform = CGAffineTransformMake(1.0, 0.0, 0.0, -1.0, 0.0, 200.0)
    var deltaAngle : Float
    var sectors = [SMSector]()
    var sectorLabel:UILabel = UILabel()
    let minAlphavalue: CGFloat = 0.6
    let maxAlphavalue: CGFloat = 1.0
    var rotateDirection = 0
    var rotateCounter = 0
    var scheduleItems = [JSON]?()
    var color = true

    var tapFlag = true // the flag to indicate that the touch is a 'tap' or a 'rotation'
    var originalTouchPoint: CGPoint = CGPoint(x: 0, y: 0)
    var courseNbr = [Int:String]()

    
    // when user rotates the date wheel, we need to draw the schedule chart of the day user choosed.
    var rotateDaysCounter: Int = 0 {
        didSet {

            for subview in (container?.subviews)! { // remove all the schedule images on other day first.

                if let imageView = subview as? UIImageView {
                    imageView.removeFromSuperview()
                }
            }

            drawSchedule(rotateDaysCounter) //rotateDaysCounter: how many days the user rotated

        }
    }
    
    var currentSector = 0 // the sector that is choosed by user to show the schedule

    init(frame: CGRect, del:ScheduleViewController, sectionsNum: Int) {
        
        self.numberOfSections = sectionsNum
        delegate = del
        self.container = del.view
        self.deltaAngle = 0
        super.init(frame: frame)
        self.drawWheel()
        self.opaque = false
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    

    
    override func beginTrackingWithTouch(touch: UITouch, withEvent event: UIEvent?) -> Bool {
        let touchPoint: CGPoint = touch.locationInView(self)
        
        originalTouchPoint = touchPoint
        

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
        

        // to determine whether it is a tap, or rotation.
        if calculateDistance(originalTouchPoint, point2: touchPoint) > 10 { //it is not a tap if the touch point offsets from the original one.
            tapFlag = false
        }
        

        // 1.1 - Get the distance from the center
        let dist = self.calculateDistanceFromCenter(touchPoint)
        
        // 1.2 - Filter out touches too close to the center

        if (dist < 40 || dist > 180){

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
        

        let radians = atan2f(Float((container?.transform.b)!), Float((container?.transform.a)!))
        
        for s in sectors {
            if radians > s.minValue && radians < s.maxValue {
                if currentSector < s.sector {
                    if s.sector == 20  && currentSector == 0 {
                        rotateDirection = -1 // clockwise
                        rotateCounter++
                    }else{
                        rotateDirection = 1 // counterclockwise
                        rotateCounter--
                    }
                }
                else if currentSector > s.sector{
                    if currentSector == 20 && s.sector == 0{
                        rotateDirection = 1 //counter-clockwise
                        rotateCounter--
                    }else
                    {
                        rotateDirection = -1 // clockwise
                        rotateCounter++
                    }
                }
                currentSector = s.sector
            }
        }
        
        // if the rotation angle is less than an sector, judge the rotation direction by its angle.
        if rotateDirection == 0 {
            if angleDifference < 0 {
                //print("rotate Direction is setted to clockwise")
                rotateDirection = -1 // clockwise
            }else{
                rotateDirection = 1 // counterclockwise
                //print("rotate Direction is setted to counter-clockwise")
            }            
        }
        return true
    }
    
    
    override func endTrackingWithTouch(touch: UITouch?, withEvent event: UIEvent?) {
       
        if tapFlag == true {
            longPressed(touch!.locationInView(self))
        }else {
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
        }
        tapFlag = true
        rotateDirection = 0 // set the rotating direction to initial value when rotation ends.
    }
    
    
    private func calculateDistanceFromCenter(point: CGPoint) -> Float{
        let center: CGPoint = CGPointMake(self.bounds.size.width/2, self.bounds.size.height/2)
        return calculateDistance(point, point2: center)
    }
    
    
    private func calculateDistance(point1: CGPoint, point2: CGPoint) -> Float {
        let dx = point1.x - point2.x
        let dy = point1.y - point2.y
        return Float(sqrt(dx * dx + dy * dy))
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

            print("create sector: \(i), \(ilabel.text)")

            ilabel.textAlignment = .Center
            ilabel.font = ilabel.font.fontWithSize(12)
            
            ilabel.layer.anchorPoint = CGPointMake(0.5, 0.5)
            ilabel.layer.position = CGPointMake((container?.bounds.size.width)!/2, (container?.bounds.size.height)!/2)
            
            var t = CGAffineTransformIdentity
            t = CGAffineTransformTranslate(t, -outerRidus *  cos(CGFloat(i) * angleSize), outerRidus * sin(CGFloat(i) * angleSize))
            t = CGAffineTransformRotate(t, CGFloat(M_PI / 2.0) - angleSize * CGFloat(i) + CGFloat(M_PI) )
            
            ilabel.transform = t
            ilabel.tag = i

            self.container?.addSubview(ilabel)

        }
        
        container?.userInteractionEnabled = false
        self.addSubview(container!)
        
        // 8 - Initialize sectors

        if numberOfSections % 2 == 0 {
            self.buildSectorsEven()
        }else {
            self.buildSectorsOdd()
        }
        drawSchedule(0)
    }
    

    // draw and display schedule on the selected day.
    // day: indicating how many days exist between today and the day need to display schedule.
    func drawSchedule(day: Int) -> Void {
        let cm = CommonFunc()
        let Lambda = AWSLambda.defaultLambda()
        let request = AWSLambdaInvocationRequest()
        
        let newDate = NSDate()
        
        // caculate the date according to the sections the user rotated.
        let dayToDraw = NSCalendar.currentCalendar().dateByAddingUnit(NSCalendarUnit.Day, value: day, toDate: newDate, options: [])
        let formatter  = NSDateFormatter()
        formatter.dateFormat = "yyyy-MM-dd"
        let weekdayToDraw = cm.getDayOfWeek(formatter.stringFromDate(dayToDraw!))
        
        request.functionName = LambdaGetUserSchedule
        request.payload = "{\"user_id\": \"\(cm.getEmail())\",\"school\":\"\(cm.getSchool())\"}"
        
        courseNbr.removeAll() // clear the course array first.
       
        // get the course list the user registered.
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
                    //print(json)

                    var imageIndicator = 0

                    for (_, item):(String, JSON) in json["Items"] {
                        //print("itme is \(item)")
                        if let course_nbr = item["course_nbr"].string {
                            if var days = item["days"].string {
                                print("days = \(days)")
                                if days != "TBD" {
                                    var dayNum = 0
                                    while days.characters.count > 1 {
                                        let locationIdx = advance(days.startIndex, 2)
                                        let theDay = days.substringToIndex(locationIdx) // the day when there is a class
                                        
                                        if let meeting_dates = item["meeting_dates"].string {
                                            if self.dayInScope(dayToDraw!, scope: meeting_dates) == false // if the day is not in the scope, then skip this course, check another one.
                                            {
                                                //print("day not in the scope. skip this course.")
                                                break
                                            }
                                        }else {
                                            //print("no meeting_dates exists. skip this course.")

                                            break
                                        }
                                        
                                        if self.weekdayToAbbreviation(weekdayToDraw) == theDay {
                                            //print("will draw on the day: \(theDay), course: \(course_nbr), red? \(self.color)")
                                            if var startTime = item["start_time"].string {
                                                if startTime.rangeOfString("|") == nil {
                                                    let startAngle = self.timeToAngle(startTime)
                                                    let endAngle = self.timeToAngle(item["end_time"].string!)
                                                    imageIndicator = self.getSectorByTime(self.stringTimeToFloat(startTime))
                                                    if startAngle > endAngle {
                                                        self.courseNbr[imageIndicator] = course_nbr
                                                        print("1will call draw funciton. indicatior = \(imageIndicator)")
                                                        dispatch_async(dispatch_get_main_queue(),{self.drawRect((self.container?.bounds)!, startAngle: endAngle, endAngle: startAngle, ind: imageIndicator, imageText: course_nbr)})
                                                        //dispatch_async(dispatch_get_main_queue(),{imageIndicator++})
                                                    }else {
                                                        self.courseNbr[imageIndicator] = course_nbr
                                                        print("2will call draw funciton. indicatior = \(imageIndicator)")
                                                        dispatch_async(dispatch_get_main_queue(),{self.drawRect((self.container?.bounds)!, startAngle: startAngle, endAngle: endAngle, ind: imageIndicator, imageText: course_nbr)})
                                                        //dispatch_async(dispatch_get_main_queue(),{imageIndicator++})
                                                    }
                                                }
                                                else{
                                                    var i = 0
                                                    var endTime = item["end_time"].string
                                                    //print("there is | in time. check the number is \(dayNum). startTime is \(startTime)")
                                                    while let range = startTime.rangeOfString("|") {
                                                        
                                                        let timeIdx = distance(startTime.startIndex, range.startIndex)
                                                        let locationIdx = advance(startTime.startIndex, timeIdx )
                                                        let moveIdx = advance(startTime.startIndex, timeIdx + 1)
                                                        let classStartTime = startTime.substringToIndex(locationIdx)
                                                        let classEndTime = endTime!.substringToIndex(locationIdx)
                                                        //print("classTime is \(classStartTime), \(classEndTime)")
                                                        
                                                        startTime = startTime.substringFromIndex(moveIdx)

                                                        imageIndicator = self.getSectorByTime(self.stringTimeToFloat(classStartTime))
                                                        endTime = endTime!.substringFromIndex(moveIdx)
                                                        let startAngle = self.timeToAngle(classStartTime)
                                                        let endAngle = self.timeToAngle(classEndTime)
                                                        
                                                        // for example: day = 'MoTuWe' startTime = '8:20|9:30|8:20', you have to get the valid time according to the date. if it is 'Tu', the time will be '9:30'
                                                        if i == dayNum { // i: the number of the time in the varible 'startTime'; dayNum: the number of the weekday in the varible 'days'
                                                            //print("will draw the \(i) time on \(dayNum) day")
                                                            if startAngle > endAngle {

                                                                self.courseNbr[imageIndicator] = course_nbr
                                                                print("3will call draw funciton. indicatior = \(imageIndicator)")
                                                                dispatch_async(dispatch_get_main_queue(),{self.drawRect((self.container?.bounds)!, startAngle: endAngle, endAngle: startAngle, ind: imageIndicator, imageText: course_nbr)})
                                                                //dispatch_async(dispatch_get_main_queue(),{imageIndicator++})
                                                            }else {
                                                                self.courseNbr[imageIndicator] = course_nbr
                                                                print("4will call draw funciton. indicatior = \(imageIndicator)")
                                                                dispatch_async(dispatch_get_main_queue(),{self.drawRect((self.container?.bounds)!, startAngle: startAngle, endAngle: endAngle, ind: imageIndicator, imageText: course_nbr)})
                                                                //dispatch_async(dispatch_get_main_queue(),{imageIndicator++})
                                                            }
                                                        }
                                                        i++
                                                    }
                                                    //print("after loop, classTime is \(startTime), \(endTime!)")
                                                    let startAngle = self.timeToAngle(startTime)
                                                    let endAngle = self.timeToAngle(endTime!)
                                                    if i == dayNum {
                                                        imageIndicator = self.getSectorByTime(self.stringTimeToFloat(startTime))
                                                        if startAngle > endAngle {
                                                            self.courseNbr[imageIndicator] = course_nbr
                                                            print("5will call draw funciton. indicatior = \(imageIndicator)")
                                                            dispatch_async(dispatch_get_main_queue(),{self.drawRect((self.container?.bounds)!, startAngle: endAngle, endAngle: startAngle, ind: imageIndicator, imageText: course_nbr)})
                                                            //dispatch_async(dispatch_get_main_queue(),{imageIndicator++})
                                                        }else {
                                                            self.courseNbr[imageIndicator] = course_nbr
                                                            print("6will call draw funciton. indicatior = \(imageIndicator)")
                                                            dispatch_async(dispatch_get_main_queue(),{self.drawRect((self.container?.bounds)!, startAngle: startAngle, endAngle: endAngle, ind: imageIndicator, imageText: course_nbr)})
                                                            //dispatch_async(dispatch_get_main_queue(),{imageIndicator++})
                                                        }
                                                    }
                                                }
                                            }
                                        }
                                        ++dayNum
                                        days = days.substringFromIndex(locationIdx)
                                    }
                                }
                            }
                        }
                    }
                }
                return nil
            })

    }
    
    

    // to convert
    func weekdayToAbbreviation(weekday: Int) -> String {
        switch weekday {
        case 1:
            return "Su"
        case 2:
            return "Mo"
        case 3:
            return "Tu"
        case 4:
            return "We"
        case 5:
            return "Th"
        case 6:
            return "Fr"
        case 7:
            return "Sa"
        default:
            return "NO"
        }
    }
    
    /* to check if the day in that scope
    *  scope: "2015/09/08 - 2015/12/07"
    *  date: 2015-9-24
    *  return: True
    */
    func dayInScope(day: NSDate, scope: String) -> Bool {
        if let range = scope.rangeOfString("-") { // find the seporating character first.
            
            let sepIdx = distance(scope.startIndex, range.startIndex)
            let locationIdx = advance(scope.startIndex, sepIdx )
            let moveIdx = advance(scope.startIndex, sepIdx + 1)
            let start = scope.substringToIndex(locationIdx)
            let end = scope.substringFromIndex(moveIdx)
            //print("to check if \(day) are in \(scope)")
            //print("classTime is \(start), \(end)")
            
            if dayLess(day, stringDate: start) == true && dayGreater(day, stringDate: end) == true {
                //print("the result is YES")
                return true
            }else {
                //print("the result is NO")
                return false
            }
        }
        else {
            //print("the result is NO")
            return false
        }
    }
    

    func dayLess(day: NSDate, stringDate: String) -> Bool {
        let dateFormatter = NSDateFormatter()
        dateFormatter.dateFormat = "yyyy/MM/ddH"
        if let date = dateFormatter.dateFromString(stringDate + "0") {
            if day.compare(date) == NSComparisonResult.OrderedAscending {
                return false
            }else {
                return true
            }
        }
        return false
    }
    

    //if the user use this function after 23:00, there will be a little bug here. but who cares?
    func dayGreater(day: NSDate, stringDate: String) -> Bool {
        let dateFormatter = NSDateFormatter()
        dateFormatter.dateFormat = "yyyy/MM/ddHH"
        if let date = dateFormatter.dateFromString(stringDate + "23") {
            if day.compare(date) == NSComparisonResult.OrderedDescending {
                return false
            }else {
                return true
            }
        }
        return false
    }
    

    func timeToAngle(time: String) -> CGFloat {
        //print("time = \(time)")
        var alpha : CGFloat = 0
        if time == "TBD" {
            return 0
        }
        //print("numberOfSections = \(numberOfSections)")
        
        let unitSection = 2 * π / CGFloat(numberOfSections)
        let timeFloat = stringTimeToFloat(time)
        print(timeFloat)
        
        if timeFloat >= 12 {
            alpha = π - unitSection * CGFloat(timeFloat - 12)
        }
        else {
            alpha = π + unitSection * CGFloat(12 - timeFloat)
        }
        return alpha
    }
    

    // convert string of time like '8:30' to float as '8.5'
    func stringTimeToFloat(time: String) -> Float {
        //print("time = \(time)")
        
        if let sep = time.rangeOfString(":")
        {
            let index: Int = distance(time.startIndex, sep.startIndex)
            var locationIdx = advance(time.startIndex, index)
            
            let hour = time.substringToIndex(locationIdx)
            //print("hour= \(hour)")
            
            locationIdx = advance(time.startIndex, index + 1)
            let minute = time.substringFromIndex(locationIdx)
            //print("minute = \(minute)")
            
            let hourFloat = Float(hour)
            let minuteFloat = Float(minute)
            
            return hourFloat! + minuteFloat! / 60
        }
        else {
            return 0
        }
    }
    
    /*
        Draw the course time section on the time wheel.
        endAngle must greater than startAngle.
        color: true- draw in red; false- draw in blue
    
    */

    func drawRect(rect: CGRect, startAngle:CGFloat, endAngle:CGFloat, ind: Int, imageText: String) {
    
        //print("startAngle = \(startAngle), endAngle = \(endAngle)")
        let center = CGPoint(x:rect.width/2, y: self.bounds.height/2)
        //print("center:\(center)")
        
        let radius: CGFloat = max(self.bounds.width, self.bounds.height) / 2
        //print("radius: \(radius)")
        //print("createing image")
        var imageView : UIImageView
        imageView = UIImageView(frame:CGRectMake(0, 0, rect.width, rect.height))
        imageView.contentMode = .ScaleAspectFit
        

        let textColor: UIColor = UIColor.whiteColor()
        let textFont: UIFont = UIFont(name: "Helvetica Bold", size: 12)!
        
        //Setups up the font attributes that will be later used to dictate how the text should be drawn
        let textFontAttributes = [
            NSFontAttributeName: textFont,
            NSForegroundColorAttributeName: textColor,
        ]
        
        let size = CGSizeMake(rect.width, rect.height)
        UIGraphicsBeginImageContext(size)
        
        let context = UIGraphicsGetCurrentContext()
        
        // draw the outer arc
        let outlinePath = UIBezierPath(arcCenter: center,
            radius: radius - 10,
            startAngle: startAngle,
            endAngle: endAngle,
            clockwise: true)
        
        //draw the inner arc
        outlinePath.addArcWithCenter(center,
            radius: 18.5,
            startAngle: endAngle,
            endAngle: startAngle,
            clockwise: false)
        

        //Now Draw the text into an image.
        //imageText.drawInRect(rect, withAttributes: textFontAttributes)

        outlinePath.closePath()
        
        if color == true {
            UIColor.redColor().setFill()
        }else {
            UIColor.blueColor().setFill()
        }
        outlinePath.fill()
        
        CGContextAddPath(context, outlinePath.CGPath)
        let result = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        
        imageView.image = result
        imageView.setNeedsDisplay()

        imageView.tag = ind
        self.container!.addSubview(imageView)
        color = !color //change color before draw another section
    }
    
    
    func longPressed(touchPoint: CGPoint) {
        
        let tapAtSector = whichSection(touchPoint)
        if tapAtSector > 0 {
            let courseSelected = getCourseBySector(tapAtSector)
            print("will show course: \(courseSelected)")
            if courseSelected != "" {
                print("found course, display ...")
                self.delegate?.courseSelected(courseSelected)
                
                let viewController = self.superview?.nextResponder() as! UIViewController
                viewController.performSegueWithIdentifier("displayClassmates_segue", sender: self)
            }
        }
    }
    
    
    
    // to get which section the point is in the circle
    func whichSection(touchPoint: CGPoint) -> Int {
        
        //container = UIView(frame: self.frame)
        //print("clock frame : \(container?.frame)")
        
        var sector: Int
        
        let angleSize:CGFloat = CGFloat(2 * M_PI) / CGFloat(numberOfSections)
        let outerRidus:CGFloat = (container?.frame.width)! / 2 // outer ring for weekday
        
        if calculateDistanceFromCenter(touchPoint) > Float(outerRidus) {
            return -1
        }
        else {
            let center: CGPoint = CGPointMake(self.bounds.size.width/2, self.bounds.size.height/2)
            let dx = touchPoint.x - center.x
            let dy = touchPoint.y - center.y
            
            let alpha = abs(atan(dy/dx))
            
            if dx <= 0 {
                if dy <= 0 {
                    sector = Int((2 * π - alpha) / angleSize)
                }
                else {
                    sector = Int(alpha / angleSize)
                }
            }else {
                if dy <= 0 {
                    sector = Int((π + alpha) / angleSize)
                }else{
                    sector = Int((π - alpha) / angleSize)
                }
            }
            print("tap on the \(sector) sector.")
            return sector
        }
    }
    
    
    // to get the course number by the section
    private func getCourseBySector(sector: Int) -> String {
        
        let sectorInClock = (rotateCounter % 21 + sector) % 21 //because the sequence
        var course = ""
        for subview in (container?.subviews)! {
            if let imagelView = subview as? UIImageView {
                if imagelView.tag == sectorInClock {
                    course = courseNbr[imagelView.tag]!
                    break
                }
            }
        }
        
        return course
    }
    
    
    // to get the start time of the sector
    private func getTimeBySector(sector: Int) -> Int {
        if sector < 10 {
            return sector + 12
        }else if sector < 12 {
            return 25
        }else {
            return sector - 8
        }
    }
    
    
    private func getSectorByTime(startTime: Float) -> Int {
        if startTime < 4 {
            return -1
        }else if startTime < 5 {
            return 13
        }else if startTime < 6 {
            return 14
        }else if startTime < 7 {
            return 15
        }else if startTime < 8 {
            return 16
        }else if startTime < 9 {
            return 17
        }else if startTime < 10 {
            return 18
        }else if startTime < 11 {
            return 19
        }else if startTime < 12 {
            return 20
        }else if startTime < 13 {
            return 0
        }else if startTime < 14 {
            return 1
        }else if startTime < 15 {
            return 2
        }else if startTime < 16 {
            return 3
        }else if startTime < 17 {
            return 4
        }else if startTime < 18 {
            return 5
        }else if startTime < 19 {
            return 6
        }else if startTime < 20 {
            return 7
        }else if startTime < 21 {
            return 8
        }else if startTime < 22 {
            return 9
        }else {
            return -1
        }
    }
    
    
    private func getSectorByValue(value: Int) -> UIImageView {
        var res = UIImageView()
        print("course has \(courseNbr.count) members: ")
        
        for course in courseNbr {
            print(course)
        }
        
        if let views = container?.subviews {
            for im in views {
                if let imageView = im as? UIImageView {
                    print(imageView.tag)
                    print(courseNbr[imageView.tag])
                    if imageView.tag == value {
                        res = imageView
                    }
                }
            }
        }
        return res
    }
    

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
            
            // 5 - Add sector to arry
            sectors.append(sector)

        }
    }
    
}


