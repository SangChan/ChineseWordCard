//
//  ChineseWord.swift
//  ChineseWordCard
//
//  Created by LeeSangchan on 2015. 11. 25..
//  Copyright © 2015년 VerandaStudio. All rights reserved.
//

import RealmSwift

class ChineseWord: Object {
    var id : Int = 0        //unique ID
    var level : Int = 0        //level of books
    var chapter : Int = 0        //chapter from specific book
    var desc_kr : String!        //description from word for Korean
    var desc_en : String!        //description from word for English
    var desc_es : String!        //description from word for Espanol
    var hanyu : String!        //hanyu from word
    var pinyin : String!        //pinyin from word
    var likeIt : Bool = false   //value for star button
    var play : Int = 0        //how many play this word
    var isShown : Bool = false   //shown to user
}
