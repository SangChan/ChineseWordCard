//
//  AppInfo.swift
//  ChineseWordCard
//
//  Created by SangChan Lee on 1/22/16.
//  Copyright © 2016 VerandaStudio. All rights reserved.
//
import AVFoundation

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
    var speechSpeed : SpeechSpeedIndex
    var languageInfo : LanguageIndex
    var sortInfo : SortIndex
    init() {
        speechSpeed = .SpeechSpeedNormal
        languageInfo = .LanguageIndexKR
        sortInfo = .SortIndexNone
    }
    
    func stringSpeechSpeed() -> String {
        if speechSpeed == .SpeechSpeedSlow {
            return "Slow"
        } else if speechSpeed == .SpeechSpeedFast {
            return "Fast"
        }
        return "Normal"
    }
    
    func stringLanguageInfo() -> String {
        if languageInfo == .LanguageIndexEN {
            return "English"
        } else if languageInfo == .LangyageIndexES {
            return "Espanõl"
        }
        return "한국어"
    }
    
    func stringSortInfo() -> String {
        if sortInfo == .SortIndexStar {
            return "By Star"
        } else if sortInfo == .SortIndexAlphabet {
            return "By Alphabet"
        }
        return "All"
    }

}
