//
//  ChineseWord.swift
//  ChineseWordCard
//
//  Created by LeeSangchan on 2015. 9. 19..
//  Copyright © 2015년 VerandaStudio. All rights reserved.
//

import Foundation

class ChineseWord: NSObject {
    var hanyuText : NSString
    var pinyinText : NSString
    var descriptionText :NSString
    init(hanyuInput : NSString, pinyinInput : NSString, descriptionInput : NSString) {
        self.hanyuText = hanyuInput;
        self.pinyinText = pinyinInput;
        self.descriptionText = descriptionInput;
    }
}
