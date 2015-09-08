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
            
            if switchViewController == nil {
                print("no switcheViewController exists")
                //let storyBoard = UIStoryboard(name: "Main",bundle: NSBundle.mainBundle())
                //switchViewController = storyBoard.instantiateViewControllerWithIdentifier("SwitchViewController") as? SwitchViewController
                var topViewController :UIViewController = (UIApplication.sharedApplication().keyWindow?.rootViewController)!
                print("current is \(topViewController)")
                while ((topViewController.presentedViewController) != nil) {
                    topViewController = topViewController.presentedViewController!;
                }
                print("current is \(topViewController)")
                if let newMenuItem = menuItem{
                    print(newMenuItem["image"]!)
                    
                    switch newMenuItem["image"] as! String{
                    case "Storage":
                        print("this is Storage")
                        
                    case "logousmall":
                        print("this is logo, will go home page")
                        // home button on sidebar is clicked
                        let storyBoard = UIStoryboard(name: "Main",
                            bundle: NSBundle.mainBundle())
                        //self.performSegueWithIdentifier("backHomeSegue", sender: nil)
                        let home = storyBoard.instantiateViewControllerWithIdentifier("Home") as! HomeViewController
                        
                        //print("current = \(self.view.window!.rootViewController)")
                        self.presentViewController(home, animated: true, completion: nil)
                        
                        //topViewController.presentationController(home, animated: true, completion: nil)
                        
                    case "favourite":
                        print("this is favourite")
                        
                    case "MessageW":
                        print("this is message")
                        
                        self.performSegueWithIdentifier("switchMessageSegue", sender: nil)
                    case "ActivitiesW":
                        print("this is Activites")
                        self.performSegueWithIdentifier("switchActivitiesSegue", sender: nil)
                    default:
                        print("SwitchViewController: something wrong")
                    }
                    
                }

                
            }else{
                if let switchView = switchViewController {
                    switchView.menuItem = menuItem
                    hideOrShowMenu(false, animated: true)
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
