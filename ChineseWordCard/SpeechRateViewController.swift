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
        details = [SpeechSpeedIndex.speechSpeedSlow, SpeechSpeedIndex.speechSpeedNormal, SpeechSpeedIndex.speechSpeedFast]
    }
}
