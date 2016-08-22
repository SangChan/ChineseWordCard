//
//  ChineseWordCardTests.swift
//  ChineseWordCardTests
//
//  Created by SangChan Lee on 7/29/16.
//  Copyright © 2016 VerandaStudio. All rights reserved.
//

import XCTest
@testable import ChineseWordCard

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
        // Use XCTAssert and related functions to verify your tests produce the correct results.
    }
    
    func testPerformanceExample() {
        // This is an example of a performance test case.
        self.measureBlock {
            // Put the code you want to measure the time of here.
        }
    }
    func testAppInfoData() {
        XCTAssert(AppInfo.sharedInstance.sortInfo.sortValue == .SortIndexNone)
        XCTAssert(AppInfo.sharedInstance.speechSpeedInfo.speechSpeedValue == .SpeechSpeedNormal)
        XCTAssert(AppInfo.sharedInstance.languageInfo.languageValue == .LanguageIndexKR)
    }
    
    func testAppInfoSaveIndex() {
        var wordIndex : Int = 99
        AppInfo.sharedInstance.sortInfo.setSortVlue(.SortIndexNone)
        AppInfo.sharedInstance.setWordIndex(wordIndex)
        XCTAssert(AppInfo.sharedInstance.getWordIndex() == wordIndex,"Pass")
        
        wordIndex = 12
        AppInfo.sharedInstance.sortInfo.setSortValue(.SortIndexAlphabet)
        AppInfo.sharedInstance.setWordIndex(wordIndex)
        XCTAssert(AppInfo.sharedInstance.getWordIndex() == wordIndex,"Pass")
        
        wordIndex = 58
        AppInfo.sharedInstance.sortInfo.setSortValue(.SortIndexStar)
        AppInfo.sharedInstance.setWordIndex(wordIndex)
        XCTAssert(AppInfo.sharedInstance.getWordIndex() == wordIndex,"Pass")
        
        AppInfo.sharedInstance.setWordIndex(wordIndex)
        AppInfo.sharedInstance.sortInfo.setSortValue(.SortIndexNone)
        XCTAssert(AppInfo.sharedInstance.getWordIndex() != wordIndex,"Pass")
        
    }
}
