//
//  SortInfo.swift
//  ChineseWordCard
//
//  Created by LeeSangchan on 2016. 6. 5..
//  Copyright © 2016년 VerandaStudio. All rights reserved.
//

import Foundation

public let SORT_INDEX : String = "SortIndex"

public enum SortIndex : Int {
    case SortIndexNone = 0
    case SortIndexAlphabet
    case SortIndexStar
}


class SortInfo {
    internal var sortInfo : SortIndex = .SortIndexNone
    
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
    
    func setDataToUserDefaults(value : Int, WithKey key:String) {
        let defaults: NSUserDefaults = NSUserDefaults.standardUserDefaults()
        defaults.setInteger(value, forKey: key)
        defaults.synchronize()
    }
    
    func setSortInfo(index : SortIndex) {
        self.sortInfo = index
        self.setDataToUserDefaults(self.sortInfo.rawValue, WithKey: SORT_INDEX)
    }
    
    func getSortInfo() -> SortIndex {
        if (NSUserDefaults.standardUserDefaults().objectForKey(SORT_INDEX) == nil) {
            return .SortIndexNone
        }
        return sortIndexFromIndex(NSUserDefaults.standardUserDefaults().integerForKey(SORT_INDEX));
    }
}