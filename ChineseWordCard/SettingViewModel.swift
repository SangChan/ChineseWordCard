//
//  SettingViewModel.swift
//  ChineseWordCard
//
//  Created by Sangchan Lee on 13/10/2019.
//  Copyright © 2019 VerandaStudio. All rights reserved.
//

import Foundation

struct SettingViewModel {
    let settings : [String]
    let details : [String]
    let version : String
}

extension SettingViewModel {
    static func model() -> SettingViewModel {
        var settings = [String]()
        for index in 1 ... 3 {
            settings.append(AppInfo.sharedInstance.titleStringFrom(index))
        }
        
        var details = [String]()
        for index in 1 ... 3 {
            details.append(AppInfo.sharedInstance.detailStringFrom(index))
        }
        
        return SettingViewModel(settings: settings, details:details, version: Bundle.main.object(forInfoDictionaryKey: "CFBundleShortVersionString") as? String ?? "1.0")
    }
}
