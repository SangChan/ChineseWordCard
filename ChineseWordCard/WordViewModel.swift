//
//  WordViewModel.swift
//  ChineseWordCard
//
//  Created by Sangchan Lee on 07/08/2019.
//  Copyright © 2019 VerandaStudio. All rights reserved.
//

import RxSwift
import AVFoundation

struct WordViewModel {
    var wordIndex = BehaviorSubject<Int>(value: 0)
    var currentWord = BehaviorSubject<ChineseWord>(value: ChineseWord())
    var touchCount = BehaviorSubject<Int>(value: 0)
    var prevEnable = BehaviorSubject<Bool>(value: false)
    var nextEnable = BehaviorSubject<Bool>(value: false)
    var hanyu = BehaviorSubject<String>(value: "")
    var desc = BehaviorSubject<String>(value: "")
    var pinyin = BehaviorSubject<String>(value: "")
    var likeIt = BehaviorSubject<Bool>(value: false)
    var hanyuAlpha = BehaviorSubject<Float>(value: 1.0)
    var descAlpha = BehaviorSubject<Float>(value: 0.0)
    var pinyinAlpha = BehaviorSubject<Float>(value: 0.0)
    var starButtonHidden = BehaviorSubject<Bool>(value: false)
    var autoPlay = BehaviorSubject<Bool>(value: false)
}
