//
//  AppInfo.swift
//  ChineseWordCard
//
//  Created by SangChan Lee on 1/22/16.
//  Copyright © 2016 VerandaStudio. All rights reserved.
//
import AVFoundation

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
    
    var speechRate:Float
    var languageInfo : LanguageIndex
    var queryWithStar : SortIndex
    init() {
        speechRate = AVSpeechUtteranceDefaultSpeechRate
        languageInfo = LanguageIndex.LanguageIndexKR
        queryWithStar = SortIndex.SortIndexNone
    }
}
