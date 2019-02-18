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
    
    lazy var lazyRealm : Realm? = {
        do {
            return try Realm()
        } catch let error {
            print("error : \(error)")
            return nil
        }
    }()
    
    lazy var index : InfoProtocol = {
        guard let realm = self.lazyRealm, let settingData : SettingData = realm.objects(SettingData.self).first else { return SortIndex.sortIndexNone }
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
        guard let realm = self.lazyRealm, let settingData : SettingData = realm.objects(SettingData.self).first else { return }
        try? realm.write {
            settingData.sortIndex = self.sortValue.rawValue
        }
    }
    
    func getSortValue() -> InfoProtocol {
        guard let realm = self.lazyRealm, let settingData : SettingData = realm.objects(SettingData.self).first else { return self.sortValue }
        self.sortValue = sortIndex(fromIndex:settingData.sortIndex)
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
            return NSLocalizedString("sort.star", comment: "By Star")
        case SortIndex.sortIndexAlphabet :
            return NSLocalizedString("sort.alphabet", comment: "By Alphabet")
        default :
            return NSLocalizedString("sort.all", comment: "All")
        }
    }
}
