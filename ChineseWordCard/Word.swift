//
//  Word.swift
//  ChineseWordCard
//
//  Created by SangChan Lee on 11/3/15.
//  Copyright © 2015 VerandaStudio. All rights reserved.
//

import Foundation
import CoreData

class Word: NSManagedObject {

// Insert code here to add functionality to your managed object subclass
    
    convenience init(hanyuInput : String, pinyinInput : String, descriptionInput : String, nowInput : Int) {
        self.hanyu = hanyuInput
        self.pinyin = pinyinInput
        self.desc = descriptionInput
        self.id = nowInput
    }

}
