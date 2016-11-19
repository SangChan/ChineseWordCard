//
//  LanguageSelectViewController.swift
//  ChineseWordCard
//
//  Created by LeeSangchan on 2016. 2. 21..
//  Copyright © 2016년 VerandaStudio. All rights reserved.
//

import UIKit

class LanguageSelectViewController: DetailSettingTableViewController {
    override func setupData() {
        detailName = "LanguageSelect"
        details = [LanguageIndex.languageIndexEN,LanguageIndex.langyageIndexES,LanguageIndex.languageIndexKR]
    }
}
