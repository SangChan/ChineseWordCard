//
//  AppInfo.swift
//  ChineseWordCard
//
//  Created by SangChan Lee on 1/22/16.
//  Copyright © 2016 VerandaStudio. All rights reserved.
//
import AVFoundation
import RealmSwift

public let WORD_INDEX : String = "WordIndex"

class AppInfo {
    static let sharedInstance = AppInfo()
    let sortInfo : SortInfo = SortInfo()
    let speechSpeedInfo : SpeechSpeedInfo = SpeechSpeedInfo()
    let languageInfo : LanguageInfo = LanguageInfo()
    
    func stringFromCellIndex(index : Int) -> String {
        switch index {
        case 1 :
            return speechSpeedInfo.stringSpeechSpeed(speechSpeedInfo.speechSpeed)
        case 2 :
            return languageInfo.stringLanguageInfo(languageInfo.languageInfo)
        default :
            return sortInfo.stringSortInfo(sortInfo.sortInfo)
        }
    }
    
    func getAllDataFromUserDefaults() {
        speechSpeedInfo.getSpeechSpeed()
        sortInfo.getSortInfo()
        languageInfo.getLanguageInfo()
    }
    
    func setDataToUserDefaults(value : Int, WithKey key:String) {
        let defaults: NSUserDefaults = NSUserDefaults.standardUserDefaults()
        defaults.setInteger(value, forKey: key)
        defaults.synchronize()
    }
    
    func getWordIndex() ->  Int {
        return NSUserDefaults.standardUserDefaults().integerForKey(self.getWordIndexKey())
    }
    
    func setWordIndex(index : Int) {
        self.setDataToUserDefaults(index, WithKey: self.getWordIndexKey())
        let realm = try! Realm()
        try! realm.write() {
            let settingData : SettingData = (realm.objects(SettingData).first)!
            settingData.setWordIndex(sortInfo.indexFromEnum(),value: index)
        }
    }
    
    func getWordIndexKey() -> String {
        return "\(WORD_INDEX):\(sortInfo.stringSortInfo(sortInfo.sortInfo))"
    }
}
