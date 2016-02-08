//
//  AppInfo.swift
//  ChineseWordCard
//
//  Created by SangChan Lee on 1/22/16.
//  Copyright © 2016 VerandaStudio. All rights reserved.
//
import AVFoundation

class AppInfo {
    static let sharedInstance = AppInfo()
    
    var speechRate:Float
    init() {
        speechRate = AVSpeechUtteranceDefaultSpeechRate
    }
}