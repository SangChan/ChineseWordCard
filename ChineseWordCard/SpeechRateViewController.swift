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
    var previousSelect : NSIndexPath = NSIndexPath.init(forRow: 0, inSection: 0)
    // TODO : implement check mark and setting data to AppInfo object
    override func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        tableView.cellForRowAtIndexPath(previousSelect)?.accessoryType = .None
        if indexPath.section == 0 && indexPath.row == 0{
            AppInfo.sharedInstance.speechRate = AVSpeechUtteranceMinimumSpeechRate
        } else if indexPath.section == 0 && indexPath.row == 1 {
            AppInfo.sharedInstance.speechRate = AVSpeechUtteranceDefaultSpeechRate
        } else if indexPath.section == 0 && indexPath.row == 2 {
            AppInfo.sharedInstance.speechRate = AVSpeechUtteranceMaximumSpeechRate
        }
        tableView.cellForRowAtIndexPath(indexPath)?.accessoryType = .Checkmark
        tableView.deselectRowAtIndexPath(indexPath, animated: true);
        previousSelect = indexPath
    }
    
    override func tableView(tableView: UITableView, willDisplayCell cell: UITableViewCell, forRowAtIndexPath indexPath: NSIndexPath) {
        if AppInfo.sharedInstance.speechRate ==  AVSpeechUtteranceMinimumSpeechRate {
            if indexPath.section == 0 && indexPath.row == 0 {
                cell.accessoryType = .Checkmark
                previousSelect = indexPath
            } else {
                cell.accessoryType = .None
            }
        } else if AppInfo.sharedInstance.speechRate == AVSpeechUtteranceDefaultSpeechRate {
            if indexPath.section == 0 && indexPath.row == 1 {
                cell.accessoryType = .Checkmark
                previousSelect = indexPath
            } else {
                cell.accessoryType = .None
            }
        } else if AppInfo.sharedInstance.speechRate == AVSpeechUtteranceMaximumSpeechRate {
            if indexPath.section == 0 && indexPath.row == 2 {
                cell.accessoryType = .Checkmark
                previousSelect = indexPath
            } else {
                cell.accessoryType = .None
            }
        }
    }
}
