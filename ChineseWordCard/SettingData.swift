//
//  SettingData.swift
//  ChineseWordCard
//
//  Created by LeeSangchan on 2016. 5. 28..
//  Copyright © 2016년 VerandaStudio. All rights reserved.
//
import Foundation
import RealmSwift

class SettingData : Object {
    @objc dynamic var speechSpeedIndex : Int = SpeechSpeedIndex.speechSpeedNormal.rawValue
    @objc dynamic var languageIndex : Int = LanguageIndex.languageIndexKR.rawValue
    @objc dynamic var sortIndex : Int = SortIndex.sortIndexNone.rawValue
    @objc dynamic var wordIndexForAll : Int = 0
    @objc dynamic var wordIndexForStar : Int = 0
    @objc dynamic var wordIndexForAlphabet : Int = 0
    
    func setWordIndex(fromValue: Int) {
        setWordIndex(fromIndex: self.sortIndex, withValue: fromValue)
    }
    
    func setWordIndex(fromIndex:Int, withValue:Int) {
        switch fromIndex {
        case 0 :
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
        return wordIndex(fromIndex:self.sortIndex);
    }
    
    func wordIndex(fromIndex:Int) -> Int{
        switch fromIndex {
        case 0 :
            return self.wordIndexForAll
        case 1 :
            return self.wordIndexForAlphabet
        case 2 :
            return self.wordIndexForStar
        default :
            return self.wordIndexForAll
        }
    }
}
