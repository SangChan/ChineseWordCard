//
//  ChineseWord.swift
//  ChineseWordCard
//
//  Created by LeeSangchan on 2015. 11. 25..
//  Copyright © 2015년 VerandaStudio. All rights reserved.
//

import UIKit

class ChineseWord: NSObject {
    var prevWord : ChineseWord!
    var id: Int16
    var level: Int16
    var chapter: Int16
    var desc: String?
    var hanyu: String?
    var pinyin: String?
    var nextWord : ChineseWord!

    init(id:Int16,level:Int16,chapter:Int16,hanyu:String,pinyin:String,desc:String) {
        self.id = id
        self.level = level
        self.chapter = chapter
        self.hanyu = hanyu
        self.pinyin = pinyin
        self.desc = desc
    }
}
