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
    
    func getAllDataFromRealm() {
        speechSpeedInfo.getSpeechSpeed()
        sortInfo.getSortInfo()
        languageInfo.getLanguageInfo()
    }
    
    func getWordIndex() ->  Int {
        let realm = try! Realm()
        let settingData : SettingData = realm.objects(SettingData).first!
        return settingData.wordIndex()
    }
    
    func setWordIndex(index : Int) {
        let realm = try! Realm()
        try! realm.write() {
            let settingData : SettingData = realm.objects(SettingData).first!
            settingData.setWordIndex(index)
        }
    }
}
