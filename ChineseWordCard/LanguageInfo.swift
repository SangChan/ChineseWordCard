//
//  LanguageInfo.swift
//  ChineseWordCard
//
//  Created by LeeSangchan on 2016. 6. 4..
//  Copyright © 2016년 VerandaStudio. All rights reserved.
//

import Foundation
import RealmSwift

public enum LanguageIndex : InfoProtocol {
    case LanguageIndexEN
    case LangyageIndexES
    case LanguageIndexKR
    
    var rawValue : Int {
        switch self {
        case LanguageIndexEN:
            return 0
        case LangyageIndexES:
            return 1
        case LanguageIndexKR:
            return 2
        }
    }

}

class LanguageInfo : EnumInfo {
    internal var languageValue : InfoProtocol = LanguageIndex.LanguageIndexKR
    
    func enumFromIndex(index:Int) -> InfoProtocol {
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
    
    
}

extension LanguageInfo {
    
    func setLanguageValue(index : LanguageIndex) {
        self.languageValue = index
        let realm = try! Realm()
        try! realm.write {
            let settingData : SettingData = realm.objects(SettingData).first!
            settingData.languageIndex = self.languageValue.rawValue
        }
    }
    
    func getLanguageValue() -> InfoProtocol {
        let realm = try! Realm()
        let settingData : SettingData = realm.objects(SettingData).first!
        self.languageValue = languageIndexFromIndex(settingData.languageIndex)
        return self.languageValue
    }
    
    func languageIndexFromIndex(index : Int) -> LanguageIndex {
        switch index {
        case 0:
            return LanguageIndex.LanguageIndexEN
        case 1:
            return LanguageIndex.LangyageIndexES
        default :
            return LanguageIndex.LanguageIndexKR
        }
    }
    
    func stringLanguageInfo(languageInfo : InfoProtocol) -> String {
        switch languageInfo {
        case LanguageIndex.LanguageIndexEN :
            return "English"
        case LanguageIndex.LangyageIndexES :
            return "Espanõl"
        default :
            return "한국어"
        }
    }
}
