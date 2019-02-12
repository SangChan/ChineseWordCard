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
    static let sharedInstance = AppInfo()
    let sortInfo : SortInfo = SortInfo()
    let speechInfo : SpeechInfo = SpeechInfo()
    let languageInfo : LanguageInfo = LanguageInfo()
    
    lazy var lazyRealm : Realm? = {
        do {
            return try Realm()
        } catch let error {
            print("error : \(error)")
            return nil
        }
    }()
    
    func stringFrom(cellindex : Int) -> String {
        switch cellindex {
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
    
    func getWordIndex() -> Int {
        guard let realm = self.lazyRealm, let settingData : SettingData = realm.objects(SettingData.self).first else { return -1 }
        return settingData.wordIndex()
    }
    
    func setWordIndex(_ index : Int) {
        guard let realm = self.lazyRealm, let settingData : SettingData = realm.objects(SettingData.self).first else { return  }
        
        do {
            try realm.write {
                settingData.setWordIndex(fromValue: index)
            }
        } catch {
            print("error : \(error)")
        }
    }
}

extension AppInfo {
    func checkToExistForSetting() -> Bool {
        guard let realm = self.lazyRealm else { return false }
        if realm.objects(SettingData.self).count == 0 {
            return false
        }
        return true
    }
    
    func checkToExistForWords() -> Bool {
        guard let realm = self.lazyRealm else { return false }
        if realm.objects(ChineseWord.self).count == 0 {
            return false
        }
        return true
    }
    
    func makeSettingDataDB() {
        guard let realm = self.lazyRealm, realm.objects(SettingData.self).count == 0  else { return }
        
        do {
            let settingData = SettingData(value: ["speechSpeedIndex": SpeechSpeedIndex.speechSpeedNormal.rawValue,
                                                  "languageIndex": LanguageIndex.languageIndexKR.rawValue,
                                                  "sortIndex": SortIndex.sortIndexNone.rawValue,
                                                  "wordIndexForAll": 0,
                                                  "wordIndexForStar": 0,
                                                  "wordIndexForAlphabet": 0])

            try realm.write {
                realm.add(settingData)
            }
        } catch {
            print("error : \(error)")
        }

    }
    func makeDictionaryDB() {
        guard let realm = self.lazyRealm, let sourcePath = Bundle.main.path(forResource: "word", ofType: "txt") else { return }
        let fileContents : NSString
        do {
            fileContents = try NSString.init(contentsOfFile:sourcePath, encoding:String.Encoding.utf8.rawValue)
        } catch {
            print("error on opening file:\(error)")
            return
        }
        
        let lines = fileContents.components(separatedBy: CharacterSet.newlines)
        guard (lines.count - realm.objects(ChineseWord.self).count) > 100 else { return }
        
        var chapter : Int = 0
        var level : Int   = 0
        var idNum : Int  = 0
        
        for text in lines {
            if text.hasPrefix("//") {
                chapter += 1
                let index = text.index(text.startIndex, offsetBy: 2)
                let chapterInfo = text.suffix(from: index).components(separatedBy: ".")
                level = Int(chapterInfo[0]) ?? 1
                chapter = Int(chapterInfo[1]) ?? 1
            } else {
                let wordsInfo = text.components(separatedBy: "\t")
                let hanyu = wordsInfo[0]
                let descEn = (wordsInfo.count > 3) ? wordsInfo[3] : wordsInfo[2]
                let descEs = (wordsInfo.count > 4) ? wordsInfo[4] : wordsInfo[2]
                
                let predicate = NSPredicate(format: "hanyu = %@", hanyu)
                if realm.objects(ChineseWord.self).filter(predicate).count == 0 {
                    let chineseWord = ChineseWord(value: ["id" : idNum,
                                                          "level" : level,
                                                          "chapter" : chapter,
                                                          "hanyu" : hanyu,
                                                          "pinyin" : wordsInfo[1],
                                                          "desc_kr" : wordsInfo[2],
                                                          "desc_en" : descEn,
                                                          "desc_es" : descEs,
                                                          "likeIt" : false,
                                                          "play" : 0,
                                                          "isShown" : false])
                    self.write(chineseWord: chineseWord)
                    idNum += 1
                }
            }
        }
    }

    func write(chineseWord : ChineseWord) {
        guard let realm = self.lazyRealm else { return }
        do {
            try realm.write {
                realm.add(chineseWord)
            }
        } catch {
            print("error on writing:\(error)")
        }
    }
}
