//
//  ContainerViewController.swift
//  
//
//  Created by lafeike on 2015-08-23.
//
//

import UIKit

class ContainerViewController: UIViewController, UIScrollViewDelegate {
    
    @IBOutlet weak var scrollView: UIScrollView!
    @IBOutlet weak var menuContainerView: UIView!
    
    var buttonClickedinHome : String? // to indicate which button at the home page user clicked.
    
    private var switchViewController: SwitchViewController?
    private var activitiesController: ActivitiesViewController?
    
    var showingMenu = false
    
    var menuItem: NSDictionary? {
        didSet {
            let storyBoard = UIStoryboard(name: "Main", bundle: NSBundle.mainBundle())
            if switchViewController == nil {
                print("no switcheViewController exists")
                
                //var topViewController :UIViewController = (UIApplication.sharedApplication().keyWindow?.rootViewController)!
                //while ((topViewController.presentedViewController) != nil) {
                   // topViewController = topViewController.presentedViewController!;
                //}
                
                if let newMenuItem = menuItem {
                    print(newMenuItem["image"]!)
                    
                    
                    switch newMenuItem["image"] as! String{
                    case "Storage":
                        print("this is Storage")
                        
                    case "logousmall":
                        print("this is logo, will go home page")
                        
                        // home button on sidebar is clicked
                        
                        let home = storyBoard.instantiateViewControllerWithIdentifier("Home") as! HomeViewController
                        self.presentViewController(home, animated: true, completion: nil)
                        
                    case "favourite":
                        print("this is favourite")
                        
                    case "MessageW":
                        print("this is message")
                        // Prepare the two view controllers for the change.
                        
                        print("child include: \(self.childViewControllers)")
                        switchViewController = self.childViewControllers[1] as! SwitchViewController
                        self.childViewControllers[1].willMoveToParentViewController(nil)
                        let messageView = storyBoard.instantiateViewControllerWithIdentifier("Message") as! MessageViewController
                        // Get the start frame of the new view controller and the end frame
                        // for the old view controller. Both rectangles are offscreen.
                        let destView : UIView = messageView.view
                        destView.autoresizingMask = [.FlexibleWidth , .FlexibleHeight]
                        destView.frame = CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height)
                        self.addChildViewController(messageView)
                        self.view.addSubview(destView)
                        print("child include: \(self.childViewControllers)")
                       
                        self.transitionFromViewController(
                            switchViewController!,
                            toViewController: messageView,
                            duration: 0.2,
                            options: UIViewAnimationOptions.TransitionCrossDissolve,
                            animations: nil,
                            completion: { finished in
                                self.switchViewController?.removeFromParentViewController()
                                messageView.didMoveToParentViewController(self)
                                messageView.view.frame = self.view.bounds
                        })
                        print("child include2: \(self.childViewControllers)")
                        messageView.didMoveToParentViewController(self)
                        self.switchViewController?.removeFromParentViewController()
                        print("child include3: \(self.childViewControllers)")
                        hideOrShowMenu(false, animated: true)
                       
                    case "ActivitiesW":
                        print("this is Activites")
                        print("child include: \(self.childViewControllers)")
                        switchViewController = self.childViewControllers[1] as! SwitchViewController
                        self.childViewControllers[1].willMoveToParentViewController(nil)
                        let activeView = storyBoard.instantiateViewControllerWithIdentifier("Activities") as! ActivitiesViewController
                        // Get the start frame of the new view controller and the end frame
                        // for the old view controller. Both rectangles are offscreen.
                        let destView : UIView = activeView.view
                        destView.autoresizingMask = [.FlexibleWidth , .FlexibleHeight]
                        destView.frame = CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height)
                        self.addChildViewController(activeView)
                        self.view.addSubview(destView)
                        print("child include: \(self.childViewControllers)")
                        
                        self.transitionFromViewController(
                            switchViewController!,
                            toViewController: activeView,
                            duration: 0.2,
                            options: UIViewAnimationOptions.TransitionCrossDissolve,
                            animations: nil,
                            completion: { finished in
                                self.switchViewController?.removeFromParentViewController()
                                activeView.didMoveToParentViewController(self)
                                activeView.view.frame = self.view.bounds
                        })
                        print("child include2: \(self.childViewControllers)")
                        activeView.didMoveToParentViewController(self)
                        self.switchViewController?.removeFromParentViewController()
                        print("child include3: \(self.childViewControllers)")
                        hideOrShowMenu(false, animated: true)

                       
                    default:
                        print("SwitchViewController: something wrong")
                    }
                    
                }

                
            }else{
                print("switchVeiwController exists.")
                print("child include: \(self.childViewControllers)")
                
                
                if let newMenuItem = menuItem {
                    print(newMenuItem["image"]!)
                    
                    
                    switch newMenuItem["image"] as! String{
                    case "Storage":
                        print("this is Storage")
                        
                    case "logousmall":
                        print("this is logo, will go home page")
                        
                        // home button on sidebar is clicked
                        
                        let home = storyBoard.instantiateViewControllerWithIdentifier("Home") as! HomeViewController
                        self.presentViewController(home, animated: true, completion: nil)
                        
                    case "favourite":
                        print("this is favourite")
                        
                    case "MessageW":
                        print("this is message")
                        // Prepare the two view controllers for the change.
                        
                        print("child include: \(self.childViewControllers)")
                        let fromController = self.childViewControllers[1]
                        fromController.willMoveToParentViewController(nil)
                        let messageView = storyBoard.instantiateViewControllerWithIdentifier("Message") as! MessageViewController
                        // Get the start frame of the new view controller and the end frame
                        // for the old view controller. Both rectangles are offscreen.
                        let destView : UIView = messageView.view
                        destView.autoresizingMask = [.FlexibleWidth , .FlexibleHeight]
                        destView.frame = CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height)
                        self.addChildViewController(messageView)
                        self.view.addSubview(destView)
                        print("child include: \(self.childViewControllers)")
                        
                        self.transitionFromViewController(
                            fromController,
                            toViewController: messageView,
                            duration: 0.2,
                            options: UIViewAnimationOptions.TransitionCrossDissolve,
                            animations: nil,
                            completion: { finished in
                                fromController.removeFromParentViewController()
                                messageView.didMoveToParentViewController(self)
                                messageView.view.frame = self.view.bounds
                        })
                        print("child include2: \(self.childViewControllers)")
                        messageView.didMoveToParentViewController(self)
                        fromController.removeFromParentViewController()
                        print("child include3: \(self.childViewControllers)")
                        hideOrShowMenu(false, animated: true)
                        
                    case "ActivitiesW":
                        print("this is Activites")
                        print("child include: \(self.childViewControllers)")
                        let fromController = self.childViewControllers[1]
                        fromController.willMoveToParentViewController(nil)
                        let activeView = storyBoard.instantiateViewControllerWithIdentifier("Activities") as! ActivitiesViewController
                        // Get the start frame of the new view controller and the end frame
                        // for the old view controller. Both rectangles are offscreen.
                        let destView : UIView = activeView.view
                        destView.autoresizingMask = [.FlexibleWidth , .FlexibleHeight]
                        destView.frame = CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height)
                        self.addChildViewController(activeView)
                        self.view.addSubview(destView)
                        print("child include: \(self.childViewControllers)")
                        
                        self.transitionFromViewController(
                            fromController,
                            toViewController: activeView,
                            duration: 0.2,
                            options: UIViewAnimationOptions.TransitionCrossDissolve,
                            animations: nil,
                            completion: { finished in
                                fromController.removeFromParentViewController()
                                activeView.didMoveToParentViewController(self)
                                activeView.view.frame = self.view.bounds
                        })
                        print("child include2: \(self.childViewControllers)")
                        activeView.didMoveToParentViewController(self)
                        fromController.removeFromParentViewController()
                        print("child include3: \(self.childViewControllers)")
                        hideOrShowMenu(false, animated: true)

                        
                    default:
                        print("SwitchViewController: something wrong")
                    }
                }


            }
            
            
            
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        print("ContainerViewController loaded ...")
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        hideOrShowMenu(showingMenu, animated: false)
        menuContainerView.layer.anchorPoint = CGPoint(x: 1.0, y: 0.5)
        print("the \(buttonClickedinHome!) is clicked")
    }
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        print("in ContainerView: segue = \(segue.identifier)")
        if segue.identifier != nil{
            

            let switchViewController = segue.destinationViewController as! SwitchViewController
            switchViewController.buttonClickedinHome = buttonClickedinHome!
            print("switchViewcontroller = \(switchViewController.description)")
        }
        
        
    }
    
    // MARK: ContainerViewController
    func hideOrShowMenu(show: Bool, animated: Bool) {
        let menuOffset = CGRectGetWidth(menuContainerView.bounds)
        scrollView.setContentOffset(show ? CGPointZero : CGPoint(x: menuOffset, y: 0), animated: animated)
        showingMenu = show
    }
    
    // MARK: - UIScrollViewDelegate
    func scrollViewDidScroll(scrollView: UIScrollView) {
        /*
        Fix for the UIScrollView paging-related issue mentioned here:
        http://stackoverflow.com/questions/4480512/uiscrollview-single-tap-scrolls-it-to-top
        */
        scrollView.pagingEnabled = scrollView.contentOffset.x < (scrollView.contentSize.width - CGRectGetWidth(scrollView.frame))
    
        let menuOffset = CGRectGetWidth(menuContainerView.bounds)
        showingMenu = !CGPointEqualToPoint(CGPoint(x: menuOffset, y: 0), scrollView.contentOffset)
       // print("didEndDecelerating showingMenu \(showingMenu)")
        
        let multiplier = 1.0 / CGRectGetWidth(menuContainerView.bounds)
        let offset = scrollView.contentOffset.x * multiplier
        let fraction = 1.0 - offset
        menuContainerView.layer.transform = transformForFraction(fraction)
        menuContainerView.alpha = fraction
        
        if let switchViewController = switchViewController {
            if let rotatingView = switchViewController.hamburgerView {
                rotatingView.rotate(fraction)
            }
        }
    }
    
    func transformForFraction(fraction:CGFloat) -> CATransform3D {
        var identity = CATransform3DIdentity
        identity.m34 = -1.0 / 1000.0;
        let angle = Double(1.0 - fraction) * -M_PI_2
        let xOffset = CGRectGetWidth(menuContainerView.bounds) * 0.5
        let rotateTransform = CATransform3DRotate(identity, CGFloat(angle), 0.0, 1.0, 0.0)
        let translateTransform = CATransform3DMakeTranslation(xOffset, 0.0, 0.0)
        return CATransform3DConcat(rotateTransform, translateTransform)
    }
    
    
    

}
