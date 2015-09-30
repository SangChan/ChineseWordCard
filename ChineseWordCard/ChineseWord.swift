//
//  ChineseWord.swift
//  ChineseWordCard
//
//  Created by LeeSangchan on 2015. 9. 19..
//  Copyright © 2015년 VerandaStudio. All rights reserved.
//

import Foundation

class ChineseWord: NSObject {
    var previosNumber : Int
    var nowNumber : Int
    var nextNumber : Int
    var hanyuText : String
    var pinyinText : String
    var descriptionText :String
    init(hanyuInput : String, pinyinInput : String, descriptionInput : String, nowInput : Int) {
        self.nowNumber = nowInput;
        self.previosNumber = nowInput - 1;
        self.nextNumber = nowInput + 1;
        self.hanyuText = hanyuInput;
        self.pinyinText = pinyinInput;
        self.descriptionText = descriptionInput;
    }
}
