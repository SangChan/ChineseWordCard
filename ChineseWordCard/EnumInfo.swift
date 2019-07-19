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

protocol EnumInfo {
    var  index : InfoProtocol { get }
    
    /// Returns Enum from input
    ///
    /// - Parameter fromIndex: int value
    /// - Returns: Enum from input
    func enumInfo(fromIndex:Int) -> InfoProtocol
    
    /// Returns rawValue from Enum
    ///
    /// - Returns: Enum's int value
    func indexFromEnum() -> Int
    
    /// Set Enum from input
    ///
    /// - Parameter setIndex: int value for new enum
    func enumInfo(setIndex:Int)
    
    /// Stringify this enum
    ///
    /// - Parameter fromIndex: int value for enum
    /// - Returns: stringify this enum (for showing)
    func string(fromIndex:Int) -> String
}
