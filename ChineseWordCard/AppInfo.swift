//
//  AppInfo.swift
//  ChineseWordCard
//
//  Created by SangChan Lee on 1/22/16.
//  Copyright © 2016 VerandaStudio. All rights reserved.
//
import AVFoundation

public let WORD_INDEX : String = "wordIndex"
public let SPEECH_SPEED_INDEX : String = "speechSpeed"
public let LANGUAGE_INDEX : String = "languageIndex"
public let SORT_INDEX : String = "sortIndex"

public enum SpeechSpeedIndex : Int {
    case SpeechSpeedSlow = 0
    case SpeechSpeedNormal
    case SpeechSpeedFast
}

public enum LanguageIndex : Int {
    case LanguageIndexEN = 0
    case LangyageIndexES
    case LanguageIndexKR
}

public enum SortIndex : Int {
    case SortIndexNone = 0
    case SortIndexAlphabet
    case SortIndexStar
}

class AppInfo {
    static let sharedInstance = AppInfo()
    var speechSpeed : SpeechSpeedIndex = .SpeechSpeedNormal
    var languageInfo : LanguageIndex = .LanguageIndexKR
    var sortInfo : SortIndex = .SortIndexNone
    
    func stringFromCellIndex(index : Int) -> String {
        switch index {
        case 1 : return stringSpeechSpeed()
        case 2 : return stringLanguageInfo()
        default : return stringSortInfo()
        }
    }
    
    func speechSpeedIndexFromIndex(index : Int) -> SpeechSpeedIndex {
        switch index {
        case 0: return .SpeechSpeedSlow
        case 2: return .SpeechSpeedFast
        default : return .SpeechSpeedNormal
        }
    }
    
    func stringSpeechSpeed() -> String {
        switch speechSpeed {
        case .SpeechSpeedSlow: return "Slow"
        case .SpeechSpeedFast: return "Fast"
        default : return "Normal"
        }
    }
    
    func languageIndexFromIndex(index : Int) -> LanguageIndex {
        switch index {
        case 0: return .LanguageIndexEN
        case 1: return .LangyageIndexES
        default : return .LanguageIndexKR
        }
    }
    
    func stringLanguageInfo() -> String {
        switch languageInfo {
        case .LanguageIndexEN : return "English"
        case .LangyageIndexES : return "Espanõl"
        default : return "한국어"
        }
    }
    
    func sortIndexFromIndex(index : Int) -> SortIndex {
        switch index {
        case 1: return .SortIndexStar
        case 2: return .SortIndexAlphabet
        default : return .SortIndexNone
        }
    }
    
    func stringSortInfo() -> String {
        switch sortInfo {
        case .SortIndexStar : return "By Star"
        case .SortIndexAlphabet : return "By Alphabet"
        default : return "All"
        }
    }
    
    // TODO : setter and getter need to save and load from UserDefaults
    
    func setSpeechSpeed(index : SpeechSpeedIndex) {
        self.speechSpeed = index
        let defaults: NSUserDefaults = NSUserDefaults.standardUserDefaults()
        defaults.setInteger(self.speechSpeed.rawValue, forKey: SPEECH_SPEED_INDEX)
        defaults.synchronize()
    }
    
    func getSpeechSpeed() -> SpeechSpeedIndex{
        return speechSpeedIndexFromIndex(NSUserDefaults.standardUserDefaults().integerForKey(SPEECH_SPEED_INDEX));
    }
    
    func setLanguageInfo(index : LanguageIndex) {
        self.languageInfo = index
        let defaults: NSUserDefaults = NSUserDefaults.standardUserDefaults()
        defaults.setInteger(self.languageInfo.rawValue, forKey: LANGUAGE_INDEX)
        defaults.synchronize()
    }
    
    func getLanguageInfo() -> LanguageIndex{
        return languageIndexFromIndex(NSUserDefaults.standardUserDefaults().integerForKey(LANGUAGE_INDEX));
    }
    
    func setSortInfo(index : SortIndex) {
        self.sortInfo = index
        let defaults: NSUserDefaults = NSUserDefaults.standardUserDefaults()
        defaults.setInteger(self.sortInfo.rawValue, forKey: SORT_INDEX)
        defaults.synchronize()
    }
    
    func getSortInfo() -> SortIndex{
        return sortIndexFromIndex(NSUserDefaults.standardUserDefaults().integerForKey(SORT_INDEX));
    }
}
