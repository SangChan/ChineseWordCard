//
//  LanguageSelectViewController.swift
//  ChineseWordCard
//
//  Created by LeeSangchan on 2016. 2. 21..
//  Copyright © 2016년 VerandaStudio. All rights reserved.
//

import UIKit

class LanguageSelectViewController: DetailSettingTableViewController {
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        detailName = "LanguageSelect"
        detailArray = [LanguageIndex.LanguageIndexEN.rawValue,LanguageIndex.LangyageIndexES.rawValue,LanguageIndex.LanguageIndexKR.rawValue]
    }

}
