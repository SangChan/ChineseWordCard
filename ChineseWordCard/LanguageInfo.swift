//
//  LanguageInfo.swift
//  ChineseWordCard
//
//  Created by LeeSangchan on 2016. 6. 4..
//  Copyright © 2016년 VerandaStudio. All rights reserved.
//

import Foundation

public let LANGUAGE_INDEX : String = "languageIndex"

public enum LanguageIndex : Int {
    case LanguageIndexEN = 0
    case LangyageIndexES
    case LanguageIndexKR
}

class LanguageInfo {
    internal var languageInfo : LanguageIndex = .LanguageIndexKR
    
    func languageIndexFromIndex(index : Int) -> LanguageIndex {
        switch index {
        case 0: return .LanguageIndexEN
        case 1: return .LangyageIndexES
        default : return .LanguageIndexKR
        }
    }
    
    func stringLanguageInfo(languageInfo : LanguageIndex) -> String {
        switch languageInfo {
        case .LanguageIndexEN : return "English"
        case .LangyageIndexES : return "Espanõl"
        default : return "한국어"
        }
    }
    
    func setLanguageInfo(index : LanguageIndex) {
        self.languageInfo = index
        //self.setDataToUserDefaults(self.languageInfo.rawValue, WithKey: LANGUAGE_INDEX)
    }
    
    func getLanguageInfo() -> LanguageIndex {
        if (NSUserDefaults.standardUserDefaults().objectForKey(LANGUAGE_INDEX) == nil) {
            return .LanguageIndexKR
        }
        return languageIndexFromIndex(NSUserDefaults.standardUserDefaults().integerForKey(LANGUAGE_INDEX));
    }
}
