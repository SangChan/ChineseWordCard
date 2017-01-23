//
//  AppInfo.swift
//  ChineseWordCard
//
//  Created by SangChan Lee on 1/22/16.
//  Copyright © 2016 VerandaStudio. All rights reserved.
//
import AVFoundation
import RealmSwift

class AppInfo {
    static let sharedInstance       = AppInfo()
    let sortInfo     : SortInfo     = SortInfo()
    let speechInfo   : SpeechInfo   = SpeechInfo()
    let languageInfo : LanguageInfo = LanguageInfo()
    
    func stringFrom(Cellindex : Int) -> String {
        switch Cellindex {
        case 1 :
            return speechInfo.string(speechSpeed:speechInfo.speechSpeedValue)
        case 2 :
            return sortInfo.string(sortInfo:sortInfo.sortValue)
        default :
            return languageInfo.string(languageInfo:languageInfo.languageValue)
        }
    }
    
    func getAllDataFromRealm() {
        makeSettingDataDB()
        makeDictionaryDB()
    }
    
    func getWordIndex() ->  Int {
        let realm = try! Realm()
        let settingData : SettingData = realm.objects(SettingData.self).first!
        return settingData.wordIndex()
    }
    
    func setWordIndex(_ index : Int) {
        let realm = try! Realm()
        
        do {
            try realm.write {
                let settingData : SettingData = realm.objects(SettingData.self).first!
                settingData.setWordIndex(fromValue: index)
            }
        } catch {
            log("error : \(error)")
        }
    }
}

extension AppInfo {
    func makeSettingDataDB() {
        let realm = try! Realm()
        guard realm.objects(SettingData.self).count == 0 else { return }
        
        try! realm.write {
            realm.create(SettingData.self, value: [
                "speechSpeedIndex"     : SpeechSpeedIndex.speechSpeedNormal.rawValue,
                "languageIndex"        : LanguageIndex.languageIndexKR.rawValue,
                "sortIndex"            : SortIndex.sortIndexNone.rawValue,
                "wordIndexForAll"      : 0,
                "wordIndexForStar"     : 0,
                "wordIndexForAlphabet" : 0
            ])
        }

    }
    func makeDictionaryDB() {
        let realm = try! Realm()
        let sourcePath = Bundle.main.path(forResource: "word", ofType: "txt")
        let fileContents : NSString
        do {
            fileContents = try NSString.init(contentsOfFile:sourcePath!, encoding:String.Encoding.utf8.rawValue)
        } catch {
            return
        }
        
        let lines = fileContents.components(separatedBy: CharacterSet.newlines)
        guard (lines.count - realm.objects(ChineseWord.self).count) > 100 else { return }
        
        var chapter : Int = 0
        var level : Int   = 0
        var id_num : Int  = 0
        
        for text in lines {
            if text.hasPrefix("//") {
                chapter += 1
                let chapterInfo = text.substring(from: text.characters.index(text.startIndex, offsetBy: 2)).components(separatedBy: ".")
                level = Int(chapterInfo[0])!
                chapter = Int(chapterInfo[1])!
            } else {
                let wordsInfo = text.components(separatedBy: "\t")
                let hanyu = wordsInfo[0]
                let desc_en = (wordsInfo.count > 3) ? wordsInfo[3] : wordsInfo[2]
                let desc_es = (wordsInfo.count > 4) ? wordsInfo[4] : wordsInfo[2]
                
                let predicate = NSPredicate(format: "hanyu = %@", hanyu)
                if realm.objects(ChineseWord.self).filter(predicate).count == 0 {
                    try! realm.write {
                        realm.create(ChineseWord.self,value:[
                            "id"      : id_num,
                            "level"   : level,
                            "chapter" : chapter,
                            "hanyu"   : hanyu,
                            "pinyin"  : wordsInfo[1],
                            "desc_kr" : wordsInfo[2],
                            "desc_en" : desc_en,
                            "desc_es" : desc_es,
                            "likeIt"  : false]
                        )
                    }
                    id_num += 1
                }
            }
        }
    }

}
