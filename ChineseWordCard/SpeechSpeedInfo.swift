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
    
    func setDataToUserDefaults(value : Int, WithKey key:String) {
        let defaults: NSUserDefaults = NSUserDefaults.standardUserDefaults()
        defaults.setInteger(value, forKey: key)
        defaults.synchronize()
    }
    
    func setSpeechSpeed(index : SpeechSpeedIndex) {
        self.speechSpeed = index
        self.setDataToUserDefaults(self.speechSpeed.rawValue, WithKey: SPEECH_SPEED_INDEX)
        let realm = try! Realm()
        try! realm.write() {
            let settingData : SettingData = realm.objects(SettingData).first!
            settingData.setValue(self.speechSpeed.rawValue, forKey: "speechSpeedIndex")
        }
    }
    
    func getSpeechSpeed() -> SpeechSpeedIndex{
        //let realm = try! Realm()
        //let settingData : SettingData = realm.objects(SettingData).first!
        //print("speechSpeedIndex from realm : \(settingData.speechSpeedIndex)")
        if (NSUserDefaults.standardUserDefaults().objectForKey(SPEECH_SPEED_INDEX) == nil) {
            return .SpeechSpeedNormal
        }
        self.speechSpeed = speechSpeedIndexFromIndex(NSUserDefaults.standardUserDefaults().integerForKey(SPEECH_SPEED_INDEX))
        return self.speechSpeed
    }

}

