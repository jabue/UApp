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
            if let switchViewController = switchViewController {
                switchViewController.menuItem = menuItem
                hideOrShowMenu(false, animated: true)
            }
            if let activitiesController = activitiesController {
                activitiesController.menuItem = menuItem
                hideOrShowMenu(false, animated: true)
            }
        }
    }
    
       
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        hideOrShowMenu(showingMenu, animated: false)
        menuContainerView.layer.anchorPoint = CGPoint(x: 1.0, y: 0.5)
        print("the \(buttonClickedinHome!) is clicked")
    }
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        print("in ContainerView: segue = \(segue.identifier)")
        let navigationController = segue.destinationViewController as! UINavigationController
        
        switchViewController = navigationController.topViewController as? SwitchViewController
        switchViewController?.buttonClickedinHome = buttonClickedinHome!
        
        
        /*
        switch buttonClickedinHome!{
            case "Profile":
                if segue.identifier == "DetailViewSegue" {
                    let navigationController = segue.destinationViewController as! UINavigationController
                    
                    detailViewController = navigationController.topViewController as? DetailViewController
                    
            }
            case "Activities":
                if segue.identifier == "DetailViewSegue" {
                    let navigationController = segue.destinationViewController as! UINavigationController
                    activitiesController = navigationController.topViewController as? ActivitiesViewController
            }
            default:
                return
        }
        
        */
        
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
