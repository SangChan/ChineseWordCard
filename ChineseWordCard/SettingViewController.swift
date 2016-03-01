//
//  SettingViewController.swift
//  ChineseWordCard
//
//  Created by SangChan Lee on 1/15/16.
//  Copyright © 2016 VerandaStudio. All rights reserved.
//

import UIKit
import AVFoundation

class SettingViewController: UITableViewController {
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated);
        self.tableView.cellForRowAtIndexPath(NSIndexPath.init(forRow: 0, inSection: 0))?.detailTextLabel?.text = "\(stringSpeechRate(AppInfo.sharedInstance.speechRate))"
    }
    
    @IBAction func clickedDoneButton(sender: AnyObject) {
        self.dismissViewControllerAnimated(true) { () -> Void in
        }
    }
    
    // TODO : implement check mark and setting data to AppInfo object
    override func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        tableView.deselectRowAtIndexPath(indexPath, animated: true);
    }
    
    override func tableView(tableView: UITableView, willDisplayCell cell: UITableViewCell, forRowAtIndexPath indexPath: NSIndexPath) {
        if indexPath.section == 0 && indexPath.row == 0 {
            cell.detailTextLabel?.text = "\(stringSpeechRate(AppInfo.sharedInstance.speechRate))"
        } else if indexPath.section == 0 && indexPath.row == 1 {
            cell.detailTextLabel?.text = "\(stringLanguage(AppInfo.sharedInstance.languageInfo))"
        } else if indexPath.section == 0 && indexPath.row == 2 {
            cell.detailTextLabel?.text = "\(stringSort(AppInfo.sharedInstance.queryWithStar))"
        } else if indexPath.section == 1 && indexPath.row == 0 {
            let versionText = NSBundle.mainBundle().objectForInfoDictionaryKey("CFBundleShortVersionString") as! String
            cell.detailTextLabel?.text = versionText
        }
    }
    
    func stringSpeechRate(speechRate:Float) -> String {
        if speechRate == AVSpeechUtteranceMinimumSpeechRate {
            return "Slow"
        } else if speechRate == AVSpeechUtteranceMaximumSpeechRate {
            return "Fast"
        }
        return "Normal"
    }
    
    func stringLanguage(index:LanguageIndex) -> String {
        if index == .LanguageIndexEN {
            return "English"
        } else if index == .LangyageIndexES {
            return "Espanõl"
        }
        return "한국어"
    }
    
    func stringSort(index:SortIndex) -> String {
        if index == .SortIndexStar {
            return "By Star"
        } else if index == .SortIndexAlphabet {
            return "By Alphabet"
        }
        return "All"
    }
    
    @IBAction func unwindToSegue(segue: UIStoryboardSegue) {
        if segue.identifier == "speechRate" {
            self.tableView.cellForRowAtIndexPath(NSIndexPath.init(forRow: 0, inSection: 0))?.detailTextLabel?.text = "\(stringSpeechRate(AppInfo.sharedInstance.speechRate))"
        }
    }
}
