//
//  AppInfo.swift
//  ChineseWordCard
//
//  Created by SangChan Lee on 1/22/16.
//  Copyright © 2016 VerandaStudio. All rights reserved.
//
import AVFoundation

public enum LanguageIndex : Int {
    case LanguageIndexKR = 0
    case LanguageIndexEN
    case LangyageIndexES
}

class AppInfo {
    static let sharedInstance = AppInfo()
    
    var speechRate:Float
    var languageInfo : LanguageIndex
    var queryWithStar : Bool
    init() {
        speechRate = AVSpeechUtteranceDefaultSpeechRate
        languageInfo = LanguageIndex.LanguageIndexKR
        queryWithStar = false
    }
}
