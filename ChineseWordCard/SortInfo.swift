//
//  SortInfo.swift
//  ChineseWordCard
//
//  Created by LeeSangchan on 2016. 6. 5..
//  Copyright © 2016년 VerandaStudio. All rights reserved.
//

import Foundation
import RealmSwift

public enum SortIndex : Int {
    case SortIndexNone = 0
    case SortIndexAlphabet
    case SortIndexStar
}


class SortInfo :EnumInfo {
    internal var sortValue : SortIndex = .SortIndexNone
    
    func enumFromIndex(index:Int) -> Any {
        return self.sortIndexFromIndex(index)
    }
    
    func indexFromEnum() -> Int {
        return sortValue.rawValue
    }
    
    func setIndex(index: Int) {
        self.setSortValue(self.sortIndexFromIndex(index))
    }
    
    func stringFromIndex(index:Int) -> String {
        return stringSortInfo(sortIndexFromIndex(index))
    }
    
    func setSortValue(index : SortIndex) {
        self.sortValue = index
        let realm = try! Realm()
        try! realm.write({ 
            let settingData : SettingData = realm.objects(SettingData).first!
            settingData.setValue(self.sortValue.rawValue, forKey: "sortIndex")
        })
    }
    
    func getSortValue() -> SortIndex {
        let realm = try! Realm()
        let settingData : SettingData = realm.objects(SettingData).first!
        self.sortValue = sortIndexFromIndex(settingData.sortIndex);
        return self.sortValue
    }
}

extension SortInfo {
    func sortIndexFromIndex(index : Int) -> SortIndex {
        switch index {
        case 1:
            return .SortIndexAlphabet
        case 2:
            return .SortIndexStar
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