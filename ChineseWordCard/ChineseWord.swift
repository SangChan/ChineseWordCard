//
//  ChineseWord.swift
//  ChineseWordCard
//
//  Created by LeeSangchan on 2015. 11. 25..
//  Copyright © 2015년 VerandaStudio. All rights reserved.
//

import RealmSwift

class ChineseWord: Object {
    var id: Int16!
    var level: Int16!
    var chapter: Int16!
    dynamic var desc: String?
    dynamic var hanyu: String?
    dynamic var pinyin: String?
    var likeIt : Bool!
}
