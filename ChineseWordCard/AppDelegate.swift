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

    func application(application: UIApplication, didFinishLaunchingWithOptions launchOptions: [NSObject: AnyObject]?) -> Bool {
        // Override point for customization after application launch.
        makeDictionaryDB()
        AppInfo.sharedInstance.getAllDataFromRealm()
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
    
    func makeDictionaryDB() {        
        let sourcePath = NSBundle.mainBundle().pathForResource("word", ofType: "txt")
        let fileContents = try! NSString.init(contentsOfFile:sourcePath!, encoding:NSUTF8StringEncoding)
        let lines = fileContents.componentsSeparatedByCharactersInSet(NSCharacterSet.newlineCharacterSet())
        var chapter : Int = 0
        var level : Int  = 0
        var id_num : Int = 0
        let realm = try! Realm()
        
        if realm.objects(SettingData).count == 0 {
            try! realm.write() {
                realm.create(SettingData.self, value: [
                    "speechSpeedIndex":1,
                    "languageIndex":2,
                    "sortIndex":0,
                    "wordIndexForAll":0,
                    "wordIndexForStar":0,
                    "wordIndexForAlphabet":0])
            }
        }
        
        if(lines.count - realm.objects(ChineseWord).count < 100) {
            return;
        }
        
        for text in lines {
            if text.hasPrefix("//") {
                chapter += 1
                let chapterInfo = text.substringFromIndex(text.startIndex.advancedBy(2)).componentsSeparatedByString(".")
                level = Int(chapterInfo[0])!
                chapter = Int(chapterInfo[1])!
            } else {
                let wordsInfo = text.componentsSeparatedByString("\t")
                let hanyu = wordsInfo[0]
                let desc_en = (wordsInfo.count > 3) ? wordsInfo[3] : wordsInfo[2]
                let desc_es = (wordsInfo.count > 4) ? wordsInfo[4] : wordsInfo[2]
                if realm.objects(ChineseWord).indexOf("hanyu == %@", hanyu) == nil {
                    try! realm.write() {
                        realm.create(ChineseWord.self,value:[
                            "id":id_num,
                            "level":level,
                            "chapter":chapter,
                            "hanyu": hanyu,
                            "pinyin":wordsInfo[1],
                            "desc_kr":wordsInfo[2],
                            "desc_en":desc_en,
                            "desc_es":desc_es,
                            "likeIt":false]
                        )
                    }
                    id_num += 1
                }
            }
        }
    }
}

