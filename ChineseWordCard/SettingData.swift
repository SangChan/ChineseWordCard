//
//  SettingData.swift
//  ChineseWordCard
//
//  Created by LeeSangchan on 2016. 5. 28..
//  Copyright © 2016년 VerandaStudio. All rights reserved.
//

import RealmSwift

class SettingData : Object {
    dynamic var speechSpeedIndex = 1
    dynamic var languageIndex = 2
    dynamic var sortIndex = 0
    dynamic var wordIndexForAll = 0
    dynamic var wordIndexForStar = 0
    dynamic var wordIndexForAlphabet = 0
    
    func setWordIndex(value: Int) {
        setWordIndex(self.sortIndex, value: value)
    }
    
    func setWordIndex(index:Int, value:Int) {
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
    
    func wordIndex(index:Int) -> Int{
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
