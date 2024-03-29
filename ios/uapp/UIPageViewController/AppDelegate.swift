//
//  AppDelegate.swift
//  UIPageViewController
//
//  Created by PJ Vea on 3/27/15.
//  Copyright (c) 2015 Vea Software. All rights reserved.
//

import UIKit
//let themeColor = UIColor(red: 0.01, green: 0.41, blue: 0.22, alpha: 1.0)

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?
    
    let cognitoAccountId = "8128-3377-8746"
    let cognitoIdentityPoolId = "us-east-1:781d7f31-f491-4775-9fc5-22cea0b6dca3"
    let cognitoUnauthRoleArn = "arn:aws:iam::812833778746:role/Cognito_loui_server_testingUnauth_Role"
    let cognitoAuthRoleArn = "arn:aws:iam::812833778746:role/Cognito_loui_server_testingAuth_Role"

    func application(application: UIApplication, didFinishLaunchingWithOptions launchOptions: [NSObject: AnyObject]?) -> Bool {
        // Override point for customization after application launch.
        
        let pageControl = UIPageControl.appearance()
        pageControl.pageIndicatorTintColor = UIColor.lightGrayColor()
        pageControl.currentPageIndicatorTintColor = UIColor.blackColor()
        pageControl.backgroundColor = UIColor.whiteColor()
        
        // Sets up the AWS Mobile SDK for IOS
        let credentialProvider = AWSCognitoCredentialsProvider(regionType: .USEast1, identityPoolId: CognitoIdentityPoolId)
        let configuration = AWSServiceConfiguration(region: .USEast1, credentialsProvider: credentialProvider)
        AWSServiceManager.defaultServiceManager().defaultServiceConfiguration = configuration
        
        // Parse Chat settings
        Parse.setApplicationId("PvsktIlVMIcanN4rU9KnidYN18weR2VkYx13pjDl", clientKey: "UwxtJNj2J6r0lJ5NSFY2NsRHQk1qv0EhuJW1NeHB")
        PFAnalytics.trackAppOpenedWithLaunchOptions(launchOptions)
        // user login , please change to your personal login info
        // UserAction.userLogin("joey", password: "joey")
        
        // window?.tintColor = themeColor
        return true
    }
    
    

    func applicationWillResignActive(application: UIApplication) {
        // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
        // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
    }

    func applicationDidEnterBackground(application: UIApplication) {
        // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
        // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
    }

    func applicationWillEnterForeground(application: UIApplication) {
        // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
    }

    func applicationDidBecomeActive(application: UIApplication) {
        // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
    }

    func applicationWillTerminate(application: UIApplication) {
        // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
    }
    
    


}

