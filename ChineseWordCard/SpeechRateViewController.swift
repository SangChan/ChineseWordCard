//
//  SpeechRateViewController.swift
//  ChineseWordCard
//
//  Created by SangChan Lee on 1/21/16.
//  Copyright © 2016 VerandaStudio. All rights reserved.
//

import UIKit

class SpeechRateViewController: DetailSettingTableViewController {
    override func setupData() {
        detailName = "SpeechRate"
        detailArray = [SpeechSpeedIndex.SpeechSpeedSlow.rawValue, SpeechSpeedIndex.SpeechSpeedNormal.rawValue, SpeechSpeedIndex.SpeechSpeedFast.rawValue]
        details = [SpeechSpeedIndex.SpeechSpeedSlow, SpeechSpeedIndex.SpeechSpeedNormal, SpeechSpeedIndex.SpeechSpeedFast]
    }
}
