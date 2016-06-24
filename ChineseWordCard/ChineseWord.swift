//
//  ChineseWord.swift
//  ChineseWordCard
//
//  Created by LeeSangchan on 2015. 11. 25..
//  Copyright © 2015년 VerandaStudio. All rights reserved.
//

import RealmSwift

class ChineseWord: Object {
    dynamic var id = -1
    dynamic var level = -1
    dynamic var chapter = -1
    dynamic var desc_kr : String?
    dynamic var desc_en : String?
    dynamic var desc_es : String?
    dynamic var hanyu : String?
    dynamic var pinyin :String?
    dynamic var likeIt = false
}
