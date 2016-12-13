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
    case languageIndexEN
    case langyageIndexES
    case languageIndexKR
    
    var rawValue : Int {
        switch self {
        case .languageIndexEN:
            return 0
        case .langyageIndexES:
            return 1
        case .languageIndexKR:
            return 2
        }
    }

}

class LanguageInfo : EnumInfo {
    internal var languageValue : InfoProtocol = LanguageIndex.languageIndexKR
    
    func enumInfo(fromIndex: Int) -> InfoProtocol {
        return self.languageIndex(fromIndex:fromIndex)
    }
    
    func indexFromEnum() -> Int {
        return self.languageValue.rawValue
    }
    
    func enumInfo(setIndex: Int) {
        self.setLanguageValue(self.languageIndex(fromIndex:setIndex))
    }
    
    func string(fromIndex:Int) -> String {
        return string(languageInfo:languageIndex(fromIndex:fromIndex))
    }
    
    
}

extension LanguageInfo {
    
    func setLanguageValue(_ index : LanguageIndex) {
        self.languageValue = index
        let realm = try! Realm()
        try! realm.write {
            let settingData : SettingData = realm.objects(SettingData.self).first!
            settingData.languageIndex = self.languageValue.rawValue
        }
    }
    
    func getLanguageValue() -> InfoProtocol {
        let realm = try! Realm()
        let settingData : SettingData = realm.objects(SettingData.self).first!
        self.languageValue = languageIndex(fromIndex:settingData.languageIndex)
        return self.languageValue
    }
    
    func languageIndex(fromIndex : Int) -> LanguageIndex {
        switch fromIndex {
        case 0:
            return LanguageIndex.languageIndexEN
        case 1:
            return LanguageIndex.langyageIndexES
        default :
            return LanguageIndex.languageIndexKR
        }
    }
    
    func string(languageInfo : InfoProtocol) -> String {
        switch languageInfo {
        case LanguageIndex.languageIndexEN :
            return "English"
        case LanguageIndex.langyageIndexES :
            return "Espanõl"
        default :
            return "한국어"
        }
    }
}
