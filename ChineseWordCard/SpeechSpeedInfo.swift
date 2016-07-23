//
//  SpeechSpeedInfo.swift
//  ChineseWordCard
//
//  Created by LeeSangchan on 2016. 6. 4..
//  Copyright © 2016년 VerandaStudio. All rights reserved.
//

import Foundation
import RealmSwift

public let SPEECH_SPEED_INDEX : String = "SpeechSpeed"

public enum SpeechSpeedIndex : Int {
    case SpeechSpeedSlow = 0
    case SpeechSpeedNormal
    case SpeechSpeedFast
}

class SpeechSpeedInfo : EnumInfo {
    internal var speechSpeed : SpeechSpeedIndex = .SpeechSpeedNormal
    
    func enumFromIndex(index:Int) -> Any {
        return self.speechSpeedIndexFromIndex(index)
    }
    
    func indexFromEnum() -> Int {
        return self.speechSpeed.rawValue
    }
    
    func setIndex(index: Int) {
        self.setSpeechSpeed(self.speechSpeedIndexFromIndex(index))
    }

    func stringFromIndex(index:Int) -> String {
        return stringSpeechSpeed(speechSpeedIndexFromIndex(index))
    }
    
    func setSpeechSpeed(index : SpeechSpeedIndex) {
        self.speechSpeed = index
        let realm = try! Realm()
        try! realm.write() {
            let settingData : SettingData = realm.objects(SettingData).first!
            settingData.setValue(self.speechSpeed.rawValue, forKey: "speechSpeedIndex")
        }
    }
    
    func getSpeechSpeed() -> SpeechSpeedIndex{
        let realm = try! Realm()
        let settingData : SettingData = realm.objects(SettingData).first!
        self.speechSpeed = speechSpeedIndexFromIndex(settingData.speechSpeedIndex)
        return self.speechSpeed
    }

}

extension SpeechSpeedInfo {
    func speechSpeedIndexFromIndex(index : Int) -> SpeechSpeedIndex {
        switch index {
        case 0:
            return .SpeechSpeedSlow
        case 2:
            return .SpeechSpeedFast
        default :
            return .SpeechSpeedNormal
        }
    }
    
    func stringSpeechSpeed(speechSpeed : SpeechSpeedIndex) -> String {
        switch speechSpeed {
        case .SpeechSpeedSlow:
            return "Slow"
        case .SpeechSpeedFast:
            return "Fast"
        default :
            return "Normal"
        }
    }
}

