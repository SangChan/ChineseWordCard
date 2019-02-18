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
    
    lazy var lazyRealm : Realm? = {
        do {
            return try Realm()
        } catch let error {
            print("error : \(error)")
            return nil
        }
    }()
    
    lazy var index : InfoProtocol = {
        guard let realm = self.lazyRealm, let settingData : SettingData = realm.objects(SettingData.self).first else { return SpeechSpeedIndex.speechSpeedNormal }
        
        switch settingData.speechSpeedIndex {
        case 0 :
            return SpeechSpeedIndex.speechSpeedSlow
        case 2 :
            return SpeechSpeedIndex.speechSpeedFast
        default :
            return SpeechSpeedIndex.speechSpeedNormal
        }
    }()
    
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
        guard let realm = self.lazyRealm, let settingData : SettingData = realm.objects(SettingData.self).first else { return }
        try? realm.write {
            
            settingData.speechSpeedIndex = self.speechSpeedValue.rawValue
        }
    }
    
    func getSpeechSpeedValue() -> InfoProtocol {
        guard let realm = self.lazyRealm, let settingData : SettingData = realm.objects(SettingData.self).first else { return self.speechSpeedValue }
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
            return NSLocalizedString("speed.slow", comment: "Slow")
        case SpeechSpeedIndex.speechSpeedFast :
            return NSLocalizedString("speed.fast", comment: "Fast")
        default :
            return NSLocalizedString("speed.normal", comment: "Normal")
        }
    }
}
