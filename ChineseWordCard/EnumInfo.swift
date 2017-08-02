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
        return -65535
    }
    
    func enumInfo(setIndex:Int) {
        // do nothing but should implement at another
        assert(setIndex >= 0,"do nothing!")
    }
    
    func string(fromIndex:Int) -> String {
        return "test"
    }
}
