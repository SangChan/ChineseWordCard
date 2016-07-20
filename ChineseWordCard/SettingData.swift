//
//  SettingData.swift
//  ChineseWordCard
//
//  Created by LeeSangchan on 2016. 5. 28..
//  Copyright © 2016년 VerandaStudio. All rights reserved.
//

import RealmSwift

class SettingData : Object {
    var speechSpeedIndex = 1
    var languageIndex = 2
    var sortIndex = 0
    var wordIndexForAll = 0
    var wordIndexForStar = 0
    var wordIndexForAlphabet = 0
    
    func setWordIndex(index:Int, value:Int) {
        switch index {
        case 0:
            wordIndexForAll = value
        case 1 :
            wordIndexForAlphabet = value
        case 2 :
            wordIndexForStar = value
        default :
            return
        }
    }
}
