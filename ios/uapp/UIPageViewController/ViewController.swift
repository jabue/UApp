//
//  ViewController.swift
//  UIPageViewController
//
//  Created by PJ Vea on 3/27/15.
//  Copyright (c) 2015 Vea Software. All rights reserved.
//

import UIKit

class ViewController: UIViewController, UIPageViewControllerDataSource {

    var pageViewController: UIPageViewController!
    var pageTitles: NSArray!
    var pageImages: NSArray!
    
    override func viewDidLoad()
    {
        super.viewDidLoad()
       
        self.pageTitles = NSArray(objects: "App", "Campus","Welcome")
        self.pageImages = NSArray(objects: "page1", "page2","page3")

        self.pageViewController = self.storyboard?.instantiateViewControllerWithIdentifier("PageViewController") as! UIPageViewController
        self.pageViewController.dataSource = self

        let startVC = self.viewControllerAtIndex(0) as ContentViewController
        let viewControllers = NSArray(object: startVC)
        
        self.pageViewController.setViewControllers(viewControllers as? [UIViewController], direction: UIPageViewControllerNavigationDirection.Forward, animated: true, completion: nil)
        
        self.pageViewController.view.frame = CGRectMake(0, 30, self.view.frame.width, self.view.frame.size.height - 60)
        
        self.addChildViewController(self.pageViewController)
        self.view.addSubview(self.pageViewController.view)
        self.pageViewController.didMoveToParentViewController(self)
        
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func restartAction(sender: AnyObject)
    {
        //var startVC = self.viewControllerAtIndex(0) as ContentViewController
        //var viewControllers = NSArray(object: startVC)
        
        //self.pageViewController.setViewControllers(viewControllers as [AnyObject], direction: .Forward, animated: true, completion: nil)
        //print("Running here!")
        // search local school info first
        // saveSchoolName("")
        let schoolName:String = findSchoolInfo()
        if schoolName.isEmpty
        {
            // turn to select school view
            self.performSegueWithIdentifier("FindSchool", sender: self)
            
        } else
        {
            // turn to login view
            self.performSegueWithIdentifier("passFindSchool", sender: self)
        }
        //
        

       
    }
    
    func viewControllerAtIndex(index: Int) -> ContentViewController
    {
        if ((self.pageTitles.count == 0) || (index >= self.pageTitles.count)) {
            return ContentViewController()
        }
        
        let vc: ContentViewController = self.storyboard?.instantiateViewControllerWithIdentifier("ContentViewController") as! ContentViewController
        
        vc.imageFile = self.pageImages[index] as! String
        vc.titleText = self.pageTitles[index]as! String
        vc.pageIndex = index
        
        return vc
        
        
    }
    
    
    // MARK: - Page View Controller Data Source
    
    func pageViewController(pageViewController: UIPageViewController, viewControllerBeforeViewController viewController: UIViewController) -> UIViewController?
    {
        
        let vc = viewController as! ContentViewController
        var index = vc.pageIndex as Int
        
        NSLog("flip left: index= %d", index)

        if (index == 0 || index == NSNotFound)
        {
            return nil
            
        }
        
        index--
        return self.viewControllerAtIndex(index)
        
    }
    
    func pageViewController(pageViewController: UIPageViewController, viewControllerAfterViewController viewController: UIViewController) -> UIViewController? {
        
        let vc = viewController as! ContentViewController
        var index = vc.pageIndex as Int
        
        NSLog("flip right: index= %d", index)
        
        if (index == NSNotFound)
        {
            return nil
        }
        
        index++
        
        if (index == self.pageTitles.count)
        {   
            NSLog("flip right,come to the end: index= %d", index)
           // self.performSegueWithIdentifier("showSchoolChoice", sender: self)
            return nil
            
            
            
        }
        
        
        if (index  > self.pageTitles.count){
            NSLog("flip right, show home page now: index= %d", index)
        
          self.performSegueWithIdentifier("showSchoolChoice", sender: self)
            
          
        }
        
        
        return self.viewControllerAtIndex(index)
  
    }
    
    func presentationCountForPageViewController(pageViewController: UIPageViewController) -> Int
    {
        return self.pageTitles.count
    }

    func presentationIndexForPageViewController(pageViewController: UIPageViewController) -> Int
    {
        return 0
    }
    
    // query if there is any selected school before
    func findSchoolInfo() -> String {
        var result:String = ""
        
        let paths = NSSearchPathForDirectoriesInDomains(.DocumentDirectory, .UserDomainMask, true) as NSArray
        let documentsDirectory = paths.objectAtIndex(0) as! NSString
        let path = documentsDirectory.stringByAppendingPathComponent("userinf.plist")
        
        let resultDictionary = NSMutableDictionary(contentsOfFile: path)
        
        let schoolName:String = "school"
        if resultDictionary?.objectForKey(schoolName) != nil{
            result = (resultDictionary?.objectForKey(schoolName)) as! String
        }
        
        print("School Info \(result)")
        
        return result
    }

}

