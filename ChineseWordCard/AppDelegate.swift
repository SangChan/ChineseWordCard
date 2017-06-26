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
        AppInfo.sharedInstance.getAllDataFromRealm()
        
        print("0 = \(self.needToUpdate(bundleShortVersion: "1.297.2", minSupportVersion: "2.1.3"))")
        print("1 = \(self.needToUpdate(bundleShortVersion: "2.0.0", minSupportVersion: "2.1.3"))")
        print("2 = \(self.needToUpdate(bundleShortVersion: "2.0.1", minSupportVersion: "2.1.3"))")
        print("3 = \(self.needToUpdate(bundleShortVersion: "2.0.2", minSupportVersion: "2.1.3"))")
        print("4 = \(self.needToUpdate(bundleShortVersion: "2.0.3", minSupportVersion: "2.1.3"))")
        print("5 = \(self.needToUpdate(bundleShortVersion: "2.1.0", minSupportVersion: "2.1.3"))")
        print("6 = \(self.needToUpdate(bundleShortVersion: "2.1.2", minSupportVersion: "2.1.3"))")
        print("7 = \(self.needToUpdate(bundleShortVersion: "2.1.3", minSupportVersion: "2.1.3"))")
        print("8 = \(self.needToUpdate(bundleShortVersion: "2.1.4", minSupportVersion: "2.1.3"))")
        print("9 = \(self.needToUpdate(bundleShortVersion: "2.2.0", minSupportVersion: "2.1.3"))")
        print("10 = \(self.needToUpdate(bundleShortVersion: "2.2.1", minSupportVersion: "2.1.3"))")
        print("11 = \(self.needToUpdate(bundleShortVersion: "2.2.2", minSupportVersion: "2.1.3"))")
        print("12 = \(self.needToUpdate(bundleShortVersion: "2.3.0", minSupportVersion: "2.1.3"))")
        print("13 = \(self.needToUpdate(bundleShortVersion: "2.3.1", minSupportVersion: "2.1.3"))")
        return true
    }
}

extension AppDelegate {
    fileprivate func needToUpdate(bundleShortVersion: String,  minSupportVersion : String) -> Bool {
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
