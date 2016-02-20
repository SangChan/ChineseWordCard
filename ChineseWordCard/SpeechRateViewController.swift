//
//  SpeechRateViewController.swift
//  ChineseWordCard
//
//  Created by SangChan Lee on 1/21/16.
//  Copyright © 2016 VerandaStudio. All rights reserved.
//

import UIKit
import AVFoundation

class SpeechRateViewController: DetailSettingTableViewController {
    let rateArray = [AVSpeechUtteranceMinimumSpeechRate, AVSpeechUtteranceDefaultSpeechRate, AVSpeechUtteranceMaximumSpeechRate]
    override func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        super.tableView(tableView, didSelectRowAtIndexPath: indexPath)
        AppInfo.sharedInstance.speechRate = rateArray[indexPath.row]
    }
    
    override func tableView(tableView: UITableView, willDisplayCell cell: UITableViewCell, forRowAtIndexPath indexPath: NSIndexPath) {
        if AppInfo.sharedInstance.speechRate ==  rateArray[indexPath.row] {
            cell.accessoryType = .Checkmark
            previousSelect = indexPath
        } else {
            cell.accessoryType = .None
        }
    }
}
