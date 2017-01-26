//
//  SpeechSpeedInfo.swift
//  ChineseWordCard
//
//  Created by LeeSangchan on 2016. 6. 4..
//  Copyright © 2016년 VerandaStudio. All rights reserved.
//

import Foundation
import RealmSwift

public enum SpeechSpeedIndex : InfoProtocol {
    case speechSpeedSlow
    case speechSpeedNormal
    case speechSpeedFast
    
    var rawValue : Int {
        switch self {
        case .speechSpeedSlow :
            return 0
        case .speechSpeedNormal :
            return 1
        case .speechSpeedFast :
            return 2
        }
    }
}

class SpeechInfo : EnumInfo {
    internal var speechSpeedValue : InfoProtocol = SpeechSpeedIndex.speechSpeedNormal
    lazy var speechSpeed = {
        let realm = try! Realm()
        let settingData : SettingData = realm.objects(SettingData.self).first!
        return settingData.speechSpeedIndex
    }
    
    func enumInfo(fromIndex: Int) -> InfoProtocol {
        return self.speechSpeedIndex(fromIndex:fromIndex)
    }
    
    func indexFromEnum() -> Int {
        return self.speechSpeedValue.rawValue
    }
    
    func enumInfo(setIndex: Int) {
        self.setSpeechSpeedValue(self.speechSpeedIndex(fromIndex:setIndex))
    }

    func string(fromIndex:Int) -> String {
        return string(speechSpeed:speechSpeedIndex(fromIndex:fromIndex))
    }

}

extension SpeechInfo {
    
    func setSpeechSpeedValue(_ index : SpeechSpeedIndex) {
        self.speechSpeedValue = index
        let realm = try! Realm()
        try! realm.write {
            let settingData : SettingData = realm.objects(SettingData.self).first!
            settingData.speechSpeedIndex = self.speechSpeedValue.rawValue
        }
    }
    
    func getSpeechSpeedValue() -> InfoProtocol{
        let realm = try! Realm()
        let settingData : SettingData = realm.objects(SettingData.self).first!
        self.speechSpeedValue = speechSpeedIndex(fromIndex:settingData.speechSpeedIndex)
        return self.speechSpeedValue
    }
    
    func speechSpeedIndex(fromIndex : Int) -> SpeechSpeedIndex {
        switch fromIndex {
        case 0 :
            return SpeechSpeedIndex.speechSpeedSlow
        case 2 :
            return SpeechSpeedIndex.speechSpeedFast
        default :
            return SpeechSpeedIndex.speechSpeedNormal
        }
    }
    
    func string(speechSpeed : InfoProtocol) -> String {
        switch speechSpeed {
        case SpeechSpeedIndex.speechSpeedSlow :
            return "Slow"
        case SpeechSpeedIndex.speechSpeedFast :
            return "Fast"
        default :
            return "Normal"
        }
    }
}

