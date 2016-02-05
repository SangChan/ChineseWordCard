//
//  ChineseWord.swift
//  ChineseWordCard
//
//  Created by LeeSangchan on 2015. 11. 25..
//  Copyright © 2015년 VerandaStudio. All rights reserved.
//

import RealmSwift

class ChineseWord: Object {
    dynamic var id = 0
    dynamic var level = 0
    dynamic var chapter = 0
    dynamic var desc : String?
    dynamic var hanyu : String?
    dynamic var pinyin :String?
    dynamic var likeIt = false
}
