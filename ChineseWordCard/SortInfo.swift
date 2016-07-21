//
//  SortInfo.swift
//  ChineseWordCard
//
//  Created by LeeSangchan on 2016. 6. 5..
//  Copyright © 2016년 VerandaStudio. All rights reserved.
//

import Foundation
import RealmSwift

public let SORT_INDEX : String = "SortIndex"

public enum SortIndex : Int {
    case SortIndexNone = 0
    case SortIndexAlphabet
    case SortIndexStar
}


class SortInfo :EnumInfo {
    internal var sortInfo : SortIndex = .SortIndexNone
    
    func enumFromIndex(index:Int) -> Any {
        return self.sortIndexFromIndex(index)
    }
    
    func indexFromEnum() -> Int {
        return sortInfo.rawValue
    }
    
    func setIndex(index: Int) {
        self.setSortInfo(self.sortIndexFromIndex(index))
    }
    
    func stringFromIndex(index:Int) -> String {
        return stringSortInfo(sortIndexFromIndex(index))
    }
    
    func setDataToUserDefaults(value : Int, WithKey key:String) {
        let defaults: NSUserDefaults = NSUserDefaults.standardUserDefaults()
        defaults.setInteger(value, forKey: key)
        defaults.synchronize()
    }
    
    func setSortInfo(index : SortIndex) {
        self.sortInfo = index
        self.setDataToUserDefaults(self.sortInfo.rawValue, WithKey: SORT_INDEX)
        let realm = try! Realm()
        try! realm.write() {
            let settingData : SettingData = realm.objects(SettingData).first!
            settingData.setValue(self.sortInfo.rawValue, forKey: "sortIndex")
        }
    }
    
    func getSortInfo() -> SortIndex {
        let realm = try! Realm()
        let settingData : SettingData = realm.objects(SettingData).first!
        print("sortInfo from realm : \(settingData.sortIndex)")
        if (NSUserDefaults.standardUserDefaults().objectForKey(SORT_INDEX) == nil) {
            return .SortIndexNone
        }
        self.sortInfo = sortIndexFromIndex(NSUserDefaults.standardUserDefaults().integerForKey(SORT_INDEX));
        return self.sortInfo
    }
}

extension SortInfo {
    func sortIndexFromIndex(index : Int) -> SortIndex {
        switch index {
        case 1:
            return .SortIndexStar
        case 2:
            return .SortIndexAlphabet
        default :
            return .SortIndexNone
        }
    }
    
    func stringSortInfo(sortInfo : SortIndex) -> String {
        switch sortInfo {
        case .SortIndexStar :
            return "By Star"
        case .SortIndexAlphabet :
            return "By Alphabet"
        default :
            return "All"
        }
    }
}