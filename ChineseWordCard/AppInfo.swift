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
    var speechSpeed : SpeechSpeedIndex = .SpeechSpeedNormal
    var languageInfo : LanguageIndex = .LanguageIndexKR
    var sortInfo : SortIndex = .SortIndexNone
    
    func stringSpeechSpeed() -> String {
        switch speechSpeed {
        case .SpeechSpeedSlow: return "Slow"
        case .SpeechSpeedFast: return "Fast"
        default : return "Normal"
        }
    }
    
    func stringLanguageInfo() -> String {
        switch languageInfo {
        case .LanguageIndexEN : return "English"
        case .LangyageIndexES : return "Espanõl"
        default : return "한국어"
        }
    }
    
    func stringSortInfo() -> String {
        switch sortInfo {
        case .SortIndexStar : return "By Star"
        case .SortIndexAlphabet : return "By Alphabet"
        default : return "All"
        }
    }

}
