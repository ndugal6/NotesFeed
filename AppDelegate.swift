//
//  AppDelegate.swift
//  NoteSwap
//
//  Created by Nick Dugal on 2/22/16.
//  Copyright © 2016 Nick Dugal. All rights reserved.
//

import UIKit
import Parse
import Bolts
//theme color for whole app
let themeColor = UIColor(red: 0.01, green: 0.41, blue: 0.22, alpha: 1.0)

var student: Student = Student()

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?


    
    func application(application: UIApplication, didFinishLaunchingWithOptions launchOptions: [NSObject: AnyObject]?) -> Bool {

        Parse.enableLocalDatastore()
        
        // Initialize Parse.
        Parse.setApplicationId("JlY96gWSWkXwcz7C16Ly48mDejRfM73TUH81jIrl",
            clientKey: "Zle8CKAPN1ohx2RbRvP0Ba8lF34eZzTxd0IzsmNo")
        
        self.determineView()
        //window?.tintColor = themeColor
        return true
    }

    func determineView() {
        var firstView: String!
        var loggedIn: Bool!
        if let currentUser = PFUser.currentUser() {
            firstView = "Main"
            loggedIn = true
            print("\(currentUser.username!) logged in successfully")
        } else {
            loggedIn = false
            firstView = "Login"
            print("No logged in user :(")
        }
        
        self.window = UIWindow(frame: UIScreen.mainScreen().bounds)
        let mainStoryboard: UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
        if(loggedIn == true) {
            let exampleViewController: MainTabViewController = mainStoryboard.instantiateViewControllerWithIdentifier(firstView) as! MainTabViewController
            self.window?.rootViewController = exampleViewController
            self.window?.makeKeyAndVisible()
        } else {
            let exampleViewController: LoginViewController = mainStoryboard.instantiateViewControllerWithIdentifier(firstView) as! LoginViewController
            self.window?.rootViewController = exampleViewController
            self.window?.makeKeyAndVisible()
        }

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

