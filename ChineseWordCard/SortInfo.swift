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
        case .sortIndexNone :
            return 0
        case .sortIndexAlphabet :
            return 1
        case .sortIndexStar :
            return 2
        }
    }
}

class SortInfo :EnumInfo {
    internal var sortValue : InfoProtocol = SortIndex.sortIndexNone
    
    lazy var index : InfoProtocol = {
        let realm = try! Realm()
        let settingData : SettingData = realm.objects(SettingData.self).first!
        switch settingData.sortIndex {
        case 1 :
            return SortIndex.sortIndexAlphabet
        case 2 :
            return SortIndex.sortIndexStar
        default :
            return SortIndex.sortIndexNone
        }
    }()
    
    func enumInfo(fromIndex: Int) -> InfoProtocol {
        return self.sortIndex(fromIndex:fromIndex)
    }
    
    func indexFromEnum() -> Int {
        return sortValue.rawValue
    }
    
    func enumInfo(setIndex: Int) {
        self.setSortValue(self.sortIndex(fromIndex:setIndex))
    }
    
    func string(fromIndex:Int) -> String {
        return string(sortInfo: sortIndex(fromIndex:fromIndex))
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
        self.sortValue = sortIndex(fromIndex:settingData.sortIndex);
        return self.sortValue
    }
    
    func sortIndex(fromIndex : Int) -> SortIndex {
        switch fromIndex {
        case 1 :
            return SortIndex.sortIndexAlphabet
        case 2 :
            return SortIndex.sortIndexStar
        default :
            return SortIndex.sortIndexNone
        }
    }
    
    func string(sortInfo : InfoProtocol) -> String {
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
