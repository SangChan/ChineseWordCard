//
//  ChineseWordCardTests.swift
//  ChineseWordCardTests
//
//  Created by SangChan on 2015. 9. 15..
//  Copyright (c) 2015년 VerandaStudio. All rights reserved.
//

import UIKit
import XCTest
import RealmSwift

class ChineseWordCardTests: XCTestCase {
    
    override func setUp() {
        super.setUp()
        AppInfo.sharedInstance.getAllDataFromRealm()
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }
    
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        super.tearDown()
    }
    
    func testExample() {
        // This is an example of a functional test case.
        XCTAssert(true, "Pass")
    }
    
    func testPerformanceExample() {
        // This is an example of a performance test case.
        self.measureBlock() {
            // Put the code you want to measure the time of here.
        }
    }
    
    func testAppInfoData() {
        XCTAssert(AppInfo.sharedInstance.sortInfo.getSortInfo() == .SortIndexNone)
        XCTAssert(AppInfo.sharedInstance.speechSpeedInfo.getSpeechSpeed() == .SpeechSpeedNormal)
        XCTAssert(AppInfo.sharedInstance.languageInfo.getLanguageInfo() == .LanguageIndexKR)
    }
    
    func testAppInfoSaveIndex() {
        var wordIndex : Int = 99
        AppInfo.sharedInstance.sortInfo.setSortInfo(.SortIndexNone)
        AppInfo.sharedInstance.setWordIndex(wordIndex)
        XCTAssert(AppInfo.sharedInstance.getWordIndex() == wordIndex,"Pass")
        
        wordIndex = 12
        AppInfo.sharedInstance.sortInfo.setSortInfo(.SortIndexAlphabet)
        AppInfo.sharedInstance.setWordIndex(wordIndex)
        XCTAssert(AppInfo.sharedInstance.getWordIndex() == wordIndex,"Pass")
        
        wordIndex = 58
        AppInfo.sharedInstance.sortInfo.setSortInfo(.SortIndexStar)
        AppInfo.sharedInstance.setWordIndex(wordIndex)
        XCTAssert(AppInfo.sharedInstance.getWordIndex() == wordIndex,"Pass")
        
        AppInfo.sharedInstance.setWordIndex(wordIndex)
        AppInfo.sharedInstance.sortInfo.setSortInfo(.SortIndexNone)
        XCTAssert(AppInfo.sharedInstance.getWordIndex() != wordIndex,"Pass")

    }
    
}
