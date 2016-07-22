//
//  EnumInfo.swift
//  ChineseWordCard
//
//  Created by SangChan Lee on 7/6/16.
//  Copyright © 2016 VerandaStudio. All rights reserved.
//

import Foundation

protocol EnumInfo {
    func indexFromEnum() -> Int
    func setIndex(index:Int)
    func stringFromIndex(index:Int) -> String
}