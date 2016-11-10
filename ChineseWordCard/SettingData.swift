//
//  SettingData.swift
//  ChineseWordCard
//
//  Created by LeeSangchan on 2016. 5. 28..
//  Copyright © 2016년 VerandaStudio. All rights reserved.
//

import RealmSwift

class SettingData : Object {
    dynamic var speechSpeedIndex = SpeechSpeedIndex.speechSpeedNormal.rawValue
    dynamic var languageIndex = LanguageIndex.languageIndexKR.rawValue
    dynamic var sortIndex = SortIndex.sortIndexNone.rawValue
    dynamic var wordIndexForAll = 0
    dynamic var wordIndexForStar = 0
    dynamic var wordIndexForAlphabet = 0
    
    func setWordIndex(_ value: Int) {
        setWordIndex(self.sortIndex, value: value)
    }
    
    func setWordIndex(_ index:Int, value:Int) {
        switch index {
        case 0:
            self.wordIndexForAll = value
        case 1 :
            self.wordIndexForAlphabet = value
        case 2 :
            self.wordIndexForStar = value
        default :
            return
        }
    }
    
    func wordIndex() -> Int {
        return wordIndex(self.sortIndex);
    }
    
    func wordIndex(_ index:Int) -> Int{
        switch index {
        case 1 :
            return self.wordIndexForAlphabet
        case 2 :
            return self.wordIndexForStar
        default :
            return self.wordIndexForAll
        }
    }
}
