//
//  AppDelegate.swift
//  FSquare
//
//  Created by abdullah barjoud on 6/25/16.
//  Copyright © 2016 abdullah barjoud. All rights reserved.
//

import UIKit
import XCGLogger
let log = XCGLogger.defaultInstance()

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?


    func application(application: UIApplication, didFinishLaunchingWithOptions launchOptions: [NSObject: AnyObject]?) -> Bool {
        // Override point for customization after application launch.
        self.configureLogger()
        UIApplication.sharedApplication().statusBarStyle = .LightContent

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
    
    func configureLogger() {
        
        log.xcodeColorsEnabled = true
        log.setup(.Verbose, showThreadName: false, showLogLevel: false, showFileNames: false, showLineNumbers: false, writeToFile:nil, fileLogLevel: .Verbose)
        log.xcodeColors = [
            .Verbose: XCGLogger.XcodeColor(fg: (10,239,138), bg: (0,0,0)), // Optionally use a UIColor,
            .Debug: XCGLogger.XcodeColor(fg: (0,168,255), bg: (0,0,0)), // Optionally use a UIColor,
            .Info: XCGLogger.XcodeColor(fg: (205,36,138),bg: (0,0,0)), // Optionally use a UIColor,
            .Warning: XCGLogger.XcodeColor(fg: (238,129,6),bg: (0,0,0)), // Optionally use a UIColor,
            .Error: XCGLogger.XcodeColor(fg: (210,57,63), bg: (0,0,0)), // Optionally use a UIColor,
            .Severe: XCGLogger.XcodeColor(fg: (210,57,63),bg: (0,0,0)), // Optionally use a UIColor,
        ]
        let systemLogDestination = XCGNSLogDestination(owner: log, identifier: XCGLogger.Constants.defaultInstanceIdentifier)
        systemLogDestination.showDate = false
    }
}

