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
        makeDictionaryDB();
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
        //TODO : If there is existing data from text, quit from here
        
        let sourcePath = NSBundle.mainBundle().resourcePath;
        let fileContents = try! NSString.init(contentsOfFile:(sourcePath?.stringByAppendingString("/word.txt"))!, encoding:NSUTF8StringEncoding)
        let lines = fileContents.componentsSeparatedByCharactersInSet(NSCharacterSet.newlineCharacterSet());
        let realm = try! Realm()
        for(index,text) in lines.enumerate() {
            print("\(index):\(text)");
            var chapter = 0;
            var id_num = 0;
            if(text.hasPrefix("//")) {
                chapter++;
            }
            else {
                let wordsInfo = text.componentsSeparatedByString("\t");
                wordsInfo.first
                try! realm.write() {
                    realm.create(ChineseWord.self,value: ["id":id_num,"level":0,"chapter":chapter,"hanyu":wordsInfo[0],"pinyin":wordsInfo[1],"desc":wordsInfo[2]]);
                }
                id_num++
            }
        }
    }
}

