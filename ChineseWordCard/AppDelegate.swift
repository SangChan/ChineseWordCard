//
//  AppDelegate.swift
//  ChineseWordCard
//
//  Created by SangChan on 2015. 9. 15..
//  Copyright (c) 2015년 VerandaStudio. All rights reserved.
//

import UIKit
import RealmSwift

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplicationLaunchOptionsKey: Any]?) -> Bool {
        // Override point for customization after application launch.
        // TODO : check app's version here
        // TODO : check app's local db migration check
        AppInfo.sharedInstance.getAllDataFromRealm()
        return true
    }
}

extension AppDelegate {
    fileprivate func checkToNeedToUpdate(bundleShortVersion: String,  minSupportVersion : String) -> Bool {
        let appBuildNumberArray = bundleShortVersion.components(separatedBy: ".")
        let minBuildNumberArray = minSupportVersion.components(separatedBy: ".")
        
        var i = 0
        for minBuildStr in minBuildNumberArray {
            if i > appBuildNumberArray.count-1 {
                return false
            }
            let minBuildNumber : Int = Int(minBuildStr) ?? 0
            let appBuildNumber : Int = Int(appBuildNumberArray[i]) ?? 0
            if (appBuildNumber < minBuildNumber) {
                return true
            } else if (appBuildNumber > minBuildNumber) {
                return false
            }
            i += 1
        }
        return false
    }
    
}
