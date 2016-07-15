//
//  EnumInfo.swift
//  ChineseWordCard
//
//  Created by SangChan Lee on 7/6/16.
//  Copyright © 2016 VerandaStudio. All rights reserved.
//

import Foundation

protocol EnumInfo {
    func enumFromIndex(index:Int) -> Any
    func indexFromEnum() -> Int
    func setIndex(index:Int)
}

class EnumInfoImlp : EnumInfo{
    func enumFromIndex(index:Int) -> Any {
        return 0
    }
    
    func indexFromEnum() -> Int {
        return 0
    }
    
    func setIndex(index:Int) {
        
    }
    
    func saveValue() {
        
    }
    
    func loadValue() {
        
    }
}
