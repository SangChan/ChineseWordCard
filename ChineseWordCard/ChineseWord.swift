//
//  ChineseWord.swift
//  ChineseWordCard
//
//  Created by LeeSangchan on 2015. 11. 25..
//  Copyright © 2015년 VerandaStudio. All rights reserved.
//

import RealmSwift

class ChineseWord: Object {
    dynamic var id      : Int = 0 //unique ID
    dynamic var level   : Int = 0 //level of books
    dynamic var chapter : Int = 0 //chapter from specific book
    dynamic var desc_kr : String! //description from word for Korean
    dynamic var desc_en : String? //description from word for English
    dynamic var desc_es : String? //description from word for Espanol
    dynamic var hanyu   : String! //hanyu from word
    dynamic var pinyin  : String! //pinyin from word
    dynamic var likeIt  : Bool = false   //value for star button
}
