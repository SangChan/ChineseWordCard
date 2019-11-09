//
//  SettingViewModel.swift
//  ChineseWordCard
//
//  Created by Sangchan Lee on 13/10/2019.
//  Copyright © 2019 VerandaStudio. All rights reserved.
//

import Foundation

struct SettingViewModel {
    let title : String
    let settings : [String]
    let details : [String]
    let versionTitle : String
    let versionInfo : String
    let sectionHeaders : [String]
}

extension SettingViewModel {
    static func model() -> SettingViewModel {
        let title = NSLocalizedString("setting.title", comment: "Setting")
        
        var settings = [String]()
        for index in 1 ... 3 {
            settings.append(AppInfo.sharedInstance.titleStringFrom(index))
        }
        
        var details = [String]()
        for index in 1 ... 3 {
            details.append(AppInfo.sharedInstance.detailStringFrom(index))
        }
        
        let versionTitle = NSLocalizedString("version.title", comment: "Version")
        let versionInfo = Bundle.main.object(forInfoDictionaryKey: "CFBundleShortVersionString") as? String ?? "1.0"
        
        var sectionHeaders = [String]()
        for index in 1 ... 2 {
            sectionHeaders.append(AppInfo.sharedInstance.sectionHeader(index))
        }
        
        return SettingViewModel(
            title: title,
            settings: settings,
            details: details,
            versionTitle: versionTitle,
            versionInfo: versionInfo,
            sectionHeaders: sectionHeaders
        )
    }
}
