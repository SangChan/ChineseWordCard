//
//  AppInfo.swift
//  ChineseWordCard
//
//  Created by SangChan Lee on 1/22/16.
//  Copyright © 2016 VerandaStudio. All rights reserved.
//
import AVFoundation
import RealmSwift

public let WORD_INDEX : String = "WordIndex"

class AppInfo {
    static let sharedInstance = AppInfo()
    let sortInfo : SortInfo = SortInfo()
    let speechSpeedInfo : SpeechSpeedInfo = SpeechSpeedInfo()
    let languageInfo : LanguageInfo = LanguageInfo()
    
    func stringFromCellIndex(index : Int) -> String {
        switch index {
        case 1 :
            return speechSpeedInfo.stringSpeechSpeed(speechSpeedInfo.speechSpeed)
        case 2 :
            return languageInfo.stringLanguageInfo(languageInfo.languageInfo)
        default :
            return sortInfo.stringSortInfo(sortInfo.sortInfo)
        }
    }
    
    func getAllDataFromRealm() {
        makeSettingDataDB()
        makeDictionaryDB()
        speechSpeedInfo.getSpeechSpeed()
        sortInfo.getSortInfo()
        languageInfo.getLanguageInfo()
    }
    
    func getWordIndex() ->  Int {
        let realm = try! Realm()
        let settingData : SettingData = realm.objects(SettingData).first!
        return settingData.wordIndex()
    }
    
    func setWordIndex(index : Int) {
        let realm = try! Realm()
        try! realm.write() {
            let settingData : SettingData = realm.objects(SettingData).first!
            settingData.setWordIndex(index)
        }
    }
}

extension AppInfo {
    func makeSettingDataDB() {
        let realm = try! Realm()
        if realm.objects(SettingData).count == 0 {
            try! realm.write() {
                realm.create(SettingData.self, value: [
                    "speechSpeedIndex":1,
                    "languageIndex":2,
                    "sortIndex":0,
                    "wordIndexForAll":0,
                    "wordIndexForStar":0,
                    "wordIndexForAlphabet":0])
            }
        }

    }
    func makeDictionaryDB() {
        let realm = try! Realm()
        let sourcePath = NSBundle.mainBundle().pathForResource("word", ofType: "txt")
        let fileContents = try! NSString.init(contentsOfFile:sourcePath!, encoding:NSUTF8StringEncoding)
        let lines = fileContents.componentsSeparatedByCharactersInSet(NSCharacterSet.newlineCharacterSet())
        if(lines.count - realm.objects(ChineseWord).count < 100) {
            return;
        }
        
        var chapter : Int = 0
        var level : Int  = 0
        var id_num : Int = 0
        
        for text in lines {
            if text.hasPrefix("//") {
                chapter += 1
                let chapterInfo = text.substringFromIndex(text.startIndex.advancedBy(2)).componentsSeparatedByString(".")
                level = Int(chapterInfo[0])!
                chapter = Int(chapterInfo[1])!
            } else {
                let wordsInfo = text.componentsSeparatedByString("\t")
                let hanyu = wordsInfo[0]
                let desc_en = (wordsInfo.count > 3) ? wordsInfo[3] : wordsInfo[2]
                let desc_es = (wordsInfo.count > 4) ? wordsInfo[4] : wordsInfo[2]
                if realm.objects(ChineseWord).indexOf("hanyu == %@", hanyu) == nil {
                    try! realm.write() {
                        realm.create(ChineseWord.self,value:[
                            "id":id_num,
                            "level":level,
                            "chapter":chapter,
                            "hanyu": hanyu,
                            "pinyin":wordsInfo[1],
                            "desc_kr":wordsInfo[2],
                            "desc_en":desc_en,
                            "desc_es":desc_es,
                            "likeIt":false]
                        )
                    }
                    id_num += 1
                }
            }
        }
    }

}
