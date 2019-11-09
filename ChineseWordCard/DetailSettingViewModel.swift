//
//  DetailSettingViewModel.swift
//  ChineseWordCard
//
//  Created by Sangchan Lee on 13/10/2019.
//  Copyright © 2019 VerandaStudio. All rights reserved.
//

import Foundation

struct DetailSettingViewModel {
    let title : String
    let detailType : SetupPageType
    let detailName : String
    let details : [InfoProtocol]
    let sectionHeader : [String]
    let sectionFooter : [String]
}

extension DetailSettingViewModel {
    static func value(with type: SetupPageType) -> DetailSettingViewModel {
        var title : String
        var details : [InfoProtocol]
        var sectionHeader : [String]
        var sectionFooter : [String]
        switch type {
        case .speechRate:
            title = NSLocalizedString("speakRate.title", comment: "speakRate.title")
            details = [SpeechSpeedIndex.speechSpeedSlow, SpeechSpeedIndex.speechSpeedNormal, SpeechSpeedIndex.speechSpeedFast]
            sectionHeader = [NSLocalizedString("speakRate.headerTitle", comment: "speakRate.headerTitle")]
            sectionFooter = [NSLocalizedString("speakRate.footerTitle", comment: "speakRate.footerTitle")]
        case .sortSelect:
            title = NSLocalizedString("sort.title", comment: "sort.title")
            details = [SortIndex.sortIndexNone, SortIndex.sortIndexAlphabet, SortIndex.sortIndexStar]
            sectionHeader = [NSLocalizedString("sort.headerTitle", comment: "sort.headerTitle")]
            sectionFooter = [NSLocalizedString("sort.footerTitle", comment: "sort.footerTitle")]
        case .languageSelect:
            title = type.rawValue()
            details =  [LanguageIndex.languageIndexEN, LanguageIndex.langyageIndexES, LanguageIndex.languageIndexKR]
            sectionHeader = []
            sectionFooter = []
        }
        return DetailSettingViewModel(
            title: title,
            detailType: type,
            detailName: type.rawValue(),
            details: details,
            sectionHeader: sectionHeader,
            sectionFooter: sectionFooter
        )
    }
}
