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
    
    func enumFromIndex(_ index:Int) -> InfoProtocol {
        return self.languageIndexFromIndex(index)
    }
    
    func indexFromEnum() -> Int {
        return self.languageValue.rawValue
    }
    
    func setIndex(_ index: Int) {
        self.setLanguageValue(self.languageIndexFromIndex(index))
    }
    
    func stringFromIndex(_ index:Int) -> String {
        return stringLanguageInfo(languageIndexFromIndex(index))
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
        self.languageValue = languageIndexFromIndex(settingData.languageIndex)
        return self.languageValue
    }
    
    func languageIndexFromIndex(_ index : Int) -> LanguageIndex {
        switch index {
        case 0:
            return LanguageIndex.languageIndexEN
        case 1:
            return LanguageIndex.langyageIndexES
        default :
            return LanguageIndex.languageIndexKR
        }
    }
    
    func stringLanguageInfo(_ languageInfo : InfoProtocol) -> String {
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
