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
    
    func setWordIndex(fromValue: Int) {
        setWordIndex(fromIndex: self.sortIndex, withValue: fromValue)
    }
    
    func setWordIndex(fromIndex:Int, withValue:Int) {
        switch fromIndex {
        case 0:
            self.wordIndexForAll = withValue
        case 1 :
            self.wordIndexForAlphabet = withValue
        case 2 :
            self.wordIndexForStar = withValue
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
