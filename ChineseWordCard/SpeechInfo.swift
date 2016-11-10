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
        case .speechSpeedSlow:
            return 0
        case .speechSpeedNormal:
            return 1
        case .speechSpeedFast:
            return 2
        }
    }
}

class SpeechInfo : EnumInfo {
    internal var speechSpeedValue : InfoProtocol = SpeechSpeedIndex.speechSpeedNormal
    
    func enumFromIndex(_ index:Int) -> InfoProtocol {
        return self.speechSpeedIndexFromIndex(index)
    }
    
    func indexFromEnum() -> Int {
        return self.speechSpeedValue.rawValue
    }
    
    func setIndex(_ index: Int) {
        self.setSpeechSpeedValue(self.speechSpeedIndexFromIndex(index))
    }

    func stringFromIndex(_ index:Int) -> String {
        return stringSpeechSpeed(speechSpeedIndexFromIndex(index))
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
        self.speechSpeedValue = speechSpeedIndexFromIndex(settingData.speechSpeedIndex)
        return self.speechSpeedValue
    }
    
    func speechSpeedIndexFromIndex(_ index : Int) -> SpeechSpeedIndex {
        switch index {
        case 0:
            return SpeechSpeedIndex.speechSpeedSlow
        case 2:
            return SpeechSpeedIndex.speechSpeedFast
        default :
            return SpeechSpeedIndex.speechSpeedNormal
        }
    }
    
    func stringSpeechSpeed(_ speechSpeed : InfoProtocol) -> String {
        switch speechSpeed {
        case SpeechSpeedIndex.speechSpeedSlow:
            return "Slow"
        case SpeechSpeedIndex.speechSpeedFast:
            return "Fast"
        default :
            return "Normal"
        }
    }
}

