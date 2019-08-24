//
//  ChineseWord.swift
//  ChineseWordCard
//
//  Created by LeeSangchan on 2015. 11. 25..
//  Copyright © 2015년 VerandaStudio. All rights reserved.
//

import RealmSwift
import AVFoundation

class ChineseWord: Object {
    @objc dynamic var id : Int = 0 //unique ID
    @objc dynamic var level : Int = 0 //level of books
    @objc dynamic var chapter : Int = 0 //chapter from specific book
    @objc dynamic var desc_kr : String = "" //description from word for Korean
    @objc dynamic var desc_en : String = "" //description from word for English
    @objc dynamic var desc_es : String = "" //description from word for Espanol
    @objc dynamic var hanyu : String = "" //hanyu from word
    @objc dynamic var pinyin : String = "" //pinyin from word
    @objc dynamic var likeIt : Bool = false //value for star button
    @objc dynamic var play : Int = 0 //how many play this word
    @objc dynamic var isShown : Bool = false //shown to user
}

extension ChineseWord {
    func speakWord() {
        guard self.pinyin.count > 0 else { return }
        let textForSpeech = self.pinyin
        let synthesize : AVSpeechSynthesizer = AVSpeechSynthesizer()
        let utterance : AVSpeechUtterance = AVSpeechUtterance(string: textForSpeech)
        utterance.rate = getSpeechSpeed(fromIndex:AppInfo.sharedInstance.speechInfo.speechSpeedValue)
        utterance.voice = AVSpeechSynthesisVoice(language: "zh-CN")
        synthesize.speak(utterance)
    }
    
    func getSpeechSpeed(fromIndex : InfoProtocol) -> Float {
        switch fromIndex.rawValue {
        case SpeechSpeedIndex.speechSpeedSlow.rawValue :
            return AVSpeechUtteranceDefaultSpeechRate * 0.35
        case SpeechSpeedIndex.speechSpeedFast.rawValue :
            return AVSpeechUtteranceDefaultSpeechRate
        default:
            return AVSpeechUtteranceDefaultSpeechRate * 0.65
        }
    }
}
