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
        self.tableView.cellForRowAtIndexPath(NSIndexPath.init(forRow: 0, inSection: 0))?.detailTextLabel?.text = AppInfo.sharedInstance.stringSpeechSpeed()
        self.tableView.cellForRowAtIndexPath(NSIndexPath.init(forRow: 1, inSection: 0))?.detailTextLabel?.text = AppInfo.sharedInstance.stringLanguageInfo()
        self.tableView.cellForRowAtIndexPath(NSIndexPath.init(forRow: 2, inSection: 0))?.detailTextLabel?.text = AppInfo.sharedInstance.stringSortInfo()
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
            cell.detailTextLabel?.text = AppInfo.sharedInstance.stringSpeechSpeed()
        } else if indexPath.section == 0 && indexPath.row == 1 {
            cell.detailTextLabel?.text = AppInfo.sharedInstance.stringLanguageInfo()
        } else if indexPath.section == 0 && indexPath.row == 2 {
            cell.detailTextLabel?.text = AppInfo.sharedInstance.stringSortInfo()
        } else if indexPath.section == 1 && indexPath.row == 0 {
            let versionText = NSBundle.mainBundle().objectForInfoDictionaryKey("CFBundleShortVersionString") as! String
            cell.detailTextLabel?.text = versionText
        }
    }
    
    @IBAction func unwindToSegue(segue: UIStoryboardSegue) {
        if segue.identifier == "selectSpeed" {
            self.tableView.cellForRowAtIndexPath(NSIndexPath.init(forRow: 0, inSection: 0))?.detailTextLabel?.text = AppInfo.sharedInstance.stringSpeechSpeed()
        } else if segue.identifier == "selectLanguage" {
            self.tableView.cellForRowAtIndexPath(NSIndexPath.init(forRow: 1, inSection: 0))?.detailTextLabel?.text = AppInfo.sharedInstance.stringLanguageInfo()
        } else if segue.identifier == "selectSort" {
            self.tableView.cellForRowAtIndexPath(NSIndexPath.init(forRow: 2, inSection: 0))?.detailTextLabel?.text = AppInfo.sharedInstance.stringSortInfo()
        }
    }
}
