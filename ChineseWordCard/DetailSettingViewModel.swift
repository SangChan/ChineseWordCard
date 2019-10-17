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
            return DetailSettingViewModel(detailType: SetupPageType.speechRate, detailName: SetupPageType.speechRate.rawValue(), details: [SpeechSpeedIndex.speechSpeedSlow, SpeechSpeedIndex.speechSpeedNormal, SpeechSpeedIndex.speechSpeedFast])
        case .sortSelect:
            return DetailSettingViewModel(detailType: SetupPageType.sortSelect, detailName: SetupPageType.sortSelect.rawValue(), details: [SortIndex.sortIndexNone, SortIndex.sortIndexAlphabet, SortIndex.sortIndexStar])
        case .languageSelect:
            return DetailSettingViewModel(detailType: SetupPageType.languageSelect, detailName: SetupPageType.languageSelect.rawValue(), details: [LanguageIndex.languageIndexEN, LanguageIndex.langyageIndexES, LanguageIndex.languageIndexKR])
        }
    }
}
