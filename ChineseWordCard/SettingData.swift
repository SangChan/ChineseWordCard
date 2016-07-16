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
    var wordIndex = [0,0,0]
    
    func setWordIndex(index:Int, value:Int) {
        wordIndex[index] = value
    }
}
