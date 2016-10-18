//
//  Log.swift
//  ChineseWordCard
//
//  Created by SangChan Lee on 10/18/16.
//  Copyright © 2016 VerandaStudio. All rights reserved.
//

import Foundation

func log(message: String, file: String = #file, function: String = #function, line: Int = #line) {
    print("Message \"\(message)\" (File: \(file), Funtion: \(function), Line\(line)")
}
