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
    case SpeechSpeedSlow
    case SpeechSpeedNormal
    case SpeechSpeedFast
    
    var rawValue : Int {
        switch self {
        case SpeechSpeedSlow:
            return 0
        case SpeechSpeedNormal:
            return 1
        case SpeechSpeedFast:
            return 2
        }
    }
}

class SpeechSpeedInfo : EnumInfo {
    internal var speechSpeedValue : InfoProtocol = SpeechSpeedIndex.SpeechSpeedNormal
    
    func enumFromIndex(index:Int) -> InfoProtocol {
        return self.speechSpeedIndexFromIndex(index)
    }
    
    func indexFromEnum() -> Int {
        return self.speechSpeedValue.rawValue
    }
    
    func setIndex(index: Int) {
        self.setSpeechSpeedValue(self.speechSpeedIndexFromIndex(index))
    }

    func stringFromIndex(index:Int) -> String {
        return stringSpeechSpeed(speechSpeedIndexFromIndex(index))
    }

}

extension SpeechSpeedInfo {
    
    func setSpeechSpeedValue(index : SpeechSpeedIndex) {
        self.speechSpeedValue = index
        let realm = try! Realm()
        try! realm.write {
            let settingData : SettingData = realm.objects(SettingData).first!
            settingData.speechSpeedIndex = self.speechSpeedValue.rawValue
        }
    }
    
    func getSpeechSpeedValue() -> InfoProtocol{
        let realm = try! Realm()
        let settingData : SettingData = realm.objects(SettingData).first!
        self.speechSpeedValue = speechSpeedIndexFromIndex(settingData.speechSpeedIndex)
        return self.speechSpeedValue
    }
    
    func speechSpeedIndexFromIndex(index : Int) -> SpeechSpeedIndex {
        switch index {
        case 0:
            return SpeechSpeedIndex.SpeechSpeedSlow
        case 2:
            return SpeechSpeedIndex.SpeechSpeedFast
        default :
            return SpeechSpeedIndex.SpeechSpeedNormal
        }
    }
    
    func stringSpeechSpeed(speechSpeed : InfoProtocol) -> String {
        switch speechSpeed {
        case SpeechSpeedIndex.SpeechSpeedSlow:
            return "Slow"
        case SpeechSpeedIndex.SpeechSpeedFast:
            return "Fast"
        default :
            return "Normal"
        }
    }
}

