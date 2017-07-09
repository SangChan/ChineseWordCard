//
//  EnumInfo.swift
//  ChineseWordCard
//
//  Created by SangChan Lee on 7/6/16.
//  Copyright © 2016 VerandaStudio. All rights reserved.
//

import Foundation

protocol InfoProtocol {
    var rawValue: Int { get }
}

protocol EnumInfo  {
    var  index : InfoProtocol { get }
    func enumInfo(fromIndex:Int) -> InfoProtocol
}

extension EnumInfo {
    func indexFromEnum() -> Int {
        return -1
    }
    
    func enumInfo(setIndex:Int) {
        
    }
    
    func string(fromIndex:Int) -> String {
        return ""
    }
}
