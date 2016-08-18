//
//  LanguageInfo.swift
//  ChineseWordCard
//
//  Created by LeeSangchan on 2016. 6. 4..
//  Copyright © 2016년 VerandaStudio. All rights reserved.
//

import Foundation
import RealmSwift

public enum LanguageIndex : Int {
    case LanguageIndexEN = 0
    case LangyageIndexES
    case LanguageIndexKR
}

class LanguageInfo : EnumInfo {
    internal var languageValue : LanguageIndex = .LanguageIndexKR
    
    func enumFromIndex(index:Int) -> Any {
        return self.languageIndexFromIndex(index)
    }
    
    func indexFromEnum() -> Int {
        return self.languageValue.rawValue
    }
    
    func setIndex(index: Int) {
        self.setLanguageValue(self.languageIndexFromIndex(index))
    }
    
    func stringFromIndex(index:Int) -> String {
        return stringLanguageInfo(languageIndexFromIndex(index))
    }
    
    func setLanguageValue(index : LanguageIndex) {
        self.languageValue = index
        let realm = try! Realm()
        try! realm.write {
            let settingData : SettingData = realm.objects(SettingData).first!
            settingData.setValue(self.languageValue.rawValue, forKey: "languageIndex")
        }
    }
    
    func getLanguageValue() -> LanguageIndex {
        let realm = try! Realm()
        let settingData : SettingData = realm.objects(SettingData).first!
        self.languageValue = languageIndexFromIndex(settingData.languageIndex)
        return self.languageValue
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
