//
//  AppDelegate.swift
//  ChineseWordCard
//
//  Created by SangChan on 2015. 9. 15..
//  Copyright (c) 2015년 VerandaStudio. All rights reserved.
//

import UIKit
import RealmSwift
import GoogleMobileAds

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        // Override point for customization after application launch.
        let config = Realm.Configuration(
            schemaVersion: 1, // from 1.2 version update
            migrationBlock: { migration, oldSchemaVersion in
                if oldSchemaVersion < 1 {
                    migration.enumerateObjects(ofType: ChineseWord.className()) { oldObject, newObject in
                        if let old = oldObject, let new = newObject {
                            new["desc_kr"] = old["desc_kr"]
                            new["desc_en"] = old["desc_en"]
                            new["desc_es"] = old["desc_es"]
                            new["hanyu"] = old["hanyu"]
                            new["pinyin"] = old["pinyin"]
                        }
                    }
                }
        })
        
        // Tell Realm to use this new configuration object for the default Realm
        Realm.Configuration.defaultConfiguration = config
        GADMobileAds.sharedInstance().start(completionHandler: nil)
        AppInfo.sharedInstance.getAllDataFromRealm()
        return true
    }
}
