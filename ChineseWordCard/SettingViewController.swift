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
        for index in 1 ... self.tableView.numberOfRowsInSection(0) {
            self.tableView.cellForRowAtIndexPath(NSIndexPath.init(forRow: index-1, inSection: 0))?.detailTextLabel?.text = AppInfo.sharedInstance.stringFromCellIndex(index)
        }
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
        switch (indexPath.section, indexPath.row) {
        case (0,0 ... 2) :
            cell.detailTextLabel?.text = AppInfo.sharedInstance.stringFromCellIndex(indexPath.row+1)
        case (1,0) :
            cell.detailTextLabel?.text = NSBundle.mainBundle().objectForInfoDictionaryKey("CFBundleShortVersionString") as? String
        default :
            return
        }
    }
    
    @IBAction func unwindToSegue(segue: UIStoryboardSegue) {
        switch segue.identifier as String? {
        case "selectSpeed"? :
            self.tableView.cellForRowAtIndexPath(NSIndexPath.init(forRow: 0, inSection: 0))?.detailTextLabel?.text = AppInfo.sharedInstance.stringSpeechSpeed()
        case "selectLanguage"? :
            self.tableView.cellForRowAtIndexPath(NSIndexPath.init(forRow: 1, inSection: 0))?.detailTextLabel?.text = AppInfo.sharedInstance.stringLanguageInfo()
        case "selectSort"? :
            self.tableView.cellForRowAtIndexPath(NSIndexPath.init(forRow: 2, inSection: 0))?.detailTextLabel?.text = AppInfo.sharedInstance.stringSortInfo()
        default :
            return;
        }
    }
}
