//
//  LanguageInfo.swift
//  ChineseWordCard
//
//  Created by LeeSangchan on 2016. 6. 4..
//  Copyright © 2016년 VerandaStudio. All rights reserved.
//

import Foundation
import RealmSwift

public let LANGUAGE_INDEX : String = "LanguageIndex"

public enum LanguageIndex : Int {
    case LanguageIndexEN = 0
    case LangyageIndexES
    case LanguageIndexKR
}

class LanguageInfo : EnumInfo {
    internal var languageInfo : LanguageIndex = .LanguageIndexKR
    
    func enumFromIndex(index:Int) -> Any {
        return self.languageIndexFromIndex(index)
    }
    
    func indexFromEnum() -> Int {
        return self.languageInfo.rawValue
    }
    
    func setIndex(index: Int) {
        self.setLanguageInfo(self.languageIndexFromIndex(index))
    }
    
    func stringFromIndex(index:Int) -> String {
        return stringLanguageInfo(languageIndexFromIndex(index))
    }
    
    func setLanguageInfo(index : LanguageIndex) {
        self.languageInfo = index
        let realm = try! Realm()
        try! realm.write() {
            let settingData : SettingData = realm.objects(SettingData).first!
            settingData.setValue(self.languageInfo.rawValue, forKey: "languageIndex")
        }
    }
    
    func getLanguageInfo() -> LanguageIndex {
        let realm = try! Realm()
        let settingData : SettingData = realm.objects(SettingData).first!
        self.languageInfo = languageIndexFromIndex(settingData.languageIndex)
        return self.languageInfo
    }
}

extension LanguageInfo {
    func languageIndexFromIndex(index : Int) -> LanguageIndex {
        switch index {
        case 0:
            return .LanguageIndexEN
        case 1:
            return .LangyageIndexES
        default :
            return .LanguageIndexKR
        }
    }
    
    func stringLanguageInfo(languageInfo : LanguageIndex) -> String {
        switch languageInfo {
        case .LanguageIndexEN :
            return "English"
        case .LangyageIndexES :
            return "Espanõl"
        default :
            return "한국어"
        }
    }
}
