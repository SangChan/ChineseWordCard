//
//  SortInfo.swift
//  ChineseWordCard
//
//  Created by LeeSangchan on 2016. 6. 5..
//  Copyright © 2016년 VerandaStudio. All rights reserved.
//

import Foundation
import RealmSwift

public enum SortIndex : InfoProtocol {
    case SortIndexNone
    case SortIndexAlphabet
    case SortIndexStar
    
    var rawValue : Int {
        switch self {
        case .SortIndexNone:
            return 0
        case .SortIndexAlphabet:
            return 1
        case .SortIndexStar:
            return 2
        }
    }
}

class SortInfo :EnumInfo {
    internal var sortValue : InfoProtocol = SortIndex.SortIndexNone
    
    func enumFromIndex(index:Int) -> InfoProtocol {
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
    
}

extension SortInfo {
    func setSortValue(index : SortIndex) {
        self.sortValue = index
        let realm = try! Realm()
        try! realm.write {
            let settingData : SettingData = realm.objects(SettingData).first!
            settingData.sortIndex = self.sortValue.rawValue
        }
    }
    
    func getSortValue() -> InfoProtocol {
        let realm = try! Realm()
        let settingData : SettingData = realm.objects(SettingData).first!
        self.sortValue = sortIndexFromIndex(settingData.sortIndex);
        return self.sortValue
    }
    
    func sortIndexFromIndex(index : Int) -> SortIndex {
        switch index {
        case 1:
            return SortIndex.SortIndexAlphabet
        case 2:
            return SortIndex.SortIndexStar
        default :
            return SortIndex.SortIndexNone
        }
    }
    
    func stringSortInfo(sortInfo : InfoProtocol) -> String {
        switch sortInfo {
        case SortIndex.SortIndexStar :
            return "By Star"
        case SortIndex.SortIndexAlphabet :
            return "By Alphabet"
        default :
            return "All"
        }
    }
}