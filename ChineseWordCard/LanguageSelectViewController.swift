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
        // TODO : this gonna never happen on 1.0 release!
        log("i hope never happens..")
        detailName = "LanguageSelect"
        details = [LanguageIndex.LanguageIndexEN,LanguageIndex.LangyageIndexES,LanguageIndex.LanguageIndexKR]
    }
}
