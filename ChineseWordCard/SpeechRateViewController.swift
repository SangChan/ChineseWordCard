//
//  SpeechRateViewController.swift
//  ChineseWordCard
//
//  Created by SangChan Lee on 1/21/16.
//  Copyright © 2016 VerandaStudio. All rights reserved.
//

import UIKit
import AVFoundation

class SpeechRateViewController: UITableViewController {
    
    // TODO : implement check mark and setting data to AppInfo object
    override func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        if indexPath.section == 0 {
            tableView.cellForRowAtIndexPath(indexPath)?.accessoryType = .Checkmark
            if indexPath.row == 0 {
                AppInfo.sharedInstance.speechRate = AVSpeechUtteranceMinimumSpeechRate
                
            } else if indexPath.row == 1 {
                AppInfo.sharedInstance.speechRate = AVSpeechUtteranceDefaultSpeechRate
                
            } else if indexPath.row == 2 {
                AppInfo.sharedInstance.speechRate = AVSpeechUtteranceMaximumSpeechRate
            }
        }
    }
    override func tableView(tableView: UITableView, didDeselectRowAtIndexPath indexPath: NSIndexPath) {
        tableView.cellForRowAtIndexPath(indexPath)?.accessoryType = .None
    }
}
