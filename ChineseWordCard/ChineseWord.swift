//
//  ChineseWord.swift
//  ChineseWordCard
//
//  Created by LeeSangchan on 2015. 11. 25..
//  Copyright © 2015년 VerandaStudio. All rights reserved.
//

import RealmSwift

class ChineseWord: Object {
    dynamic var id : UInt = 0
    dynamic var level : UInt = 0
    dynamic var chapter : UInt = 0
    dynamic var desc_kr : String?
    dynamic var desc_en : String?
    dynamic var desc_es : String?
    dynamic var hanyu : String?
    dynamic var pinyin :String?
    dynamic var likeIt = false
}
