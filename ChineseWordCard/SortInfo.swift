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
    case sortIndexNone
    case sortIndexAlphabet
    case sortIndexStar
    
    var rawValue : Int {
        switch self {
        case .sortIndexNone:
            return 0
        case .sortIndexAlphabet:
            return 1
        case .sortIndexStar:
            return 2
        }
    }
}

class SortInfo :EnumInfo {
    internal var sortValue : InfoProtocol = SortIndex.sortIndexNone
    
    func enumFromIndex(_ index:Int) -> InfoProtocol {
        return self.sortIndexFromIndex(index)
    }
    
    func indexFromEnum() -> Int {
        return sortValue.rawValue
    }
    
    func setIndex(_ index: Int) {
        self.setSortValue(self.sortIndexFromIndex(index))
    }
    
    func stringFromIndex(_ index:Int) -> String {
        return stringSortInfo(sortIndexFromIndex(index))
    }
    
}

extension SortInfo {
    func setSortValue(_ index : SortIndex) {
        self.sortValue = index
        let realm = try! Realm()
        try! realm.write {
            let settingData : SettingData = realm.objects(SettingData.self).first!
            settingData.sortIndex = self.sortValue.rawValue
        }
    }
    
    func getSortValue() -> InfoProtocol {
        let realm = try! Realm()
        let settingData : SettingData = realm.objects(SettingData.self).first!
        self.sortValue = sortIndexFromIndex(settingData.sortIndex);
        return self.sortValue
    }
    
    func sortIndexFromIndex(_ index : Int) -> SortIndex {
        switch index {
        case 1:
            return SortIndex.sortIndexAlphabet
        case 2:
            return SortIndex.sortIndexStar
        default :
            return SortIndex.sortIndexNone
        }
    }
    
    func stringSortInfo(_ sortInfo : InfoProtocol) -> String {
        switch sortInfo {
        case SortIndex.sortIndexStar :
            return "By Star"
        case SortIndex.sortIndexAlphabet :
            return "By Alphabet"
        default :
            return "All"
        }
    }
}
