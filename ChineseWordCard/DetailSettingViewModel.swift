//
//  DetailSettingViewModel.swift
//  ChineseWordCard
//
//  Created by Sangchan Lee on 13/10/2019.
//  Copyright © 2019 VerandaStudio. All rights reserved.
//

import Foundation

struct DetailSettingViewModel {
    let detailType : SetupPageType
    let detailName : String
    let details : [InfoProtocol]
}

extension DetailSettingViewModel {
    static func value(with type: SetupPageType) -> DetailSettingViewModel {
        switch type {
        case .speechRate:
            return DetailSettingViewModel(detailType: type, detailName: type.rawValue(), details: [SpeechSpeedIndex.speechSpeedSlow, SpeechSpeedIndex.speechSpeedNormal, SpeechSpeedIndex.speechSpeedFast])
        case .sortSelect:
            return DetailSettingViewModel(detailType: type, detailName: type.rawValue(), details: [SortIndex.sortIndexNone, SortIndex.sortIndexAlphabet, SortIndex.sortIndexStar])
        case .languageSelect:
            return DetailSettingViewModel(detailType: type, detailName: type.rawValue(), details: [LanguageIndex.languageIndexEN, LanguageIndex.langyageIndexES, LanguageIndex.languageIndexKR])
        }
    }
}
