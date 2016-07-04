//
//  SpeechRateViewController.swift
//  ChineseWordCard
//
//  Created by SangChan Lee on 1/21/16.
//  Copyright © 2016 VerandaStudio. All rights reserved.
//

import UIKit

class SpeechRateViewController: DetailSettingTableViewController {
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        detailName = "SpeechRate"
        detailArray = [SpeechSpeedIndex.SpeechSpeedSlow.rawValue, SpeechSpeedIndex.SpeechSpeedNormal.rawValue, SpeechSpeedIndex.SpeechSpeedFast.rawValue]
    }
}
