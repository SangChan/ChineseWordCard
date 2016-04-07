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
        var previousSegueNumber : Int = 1
        if segue.identifier == "selectLanguage" {
            previousSegueNumber = 2
        } else if segue.identifier == "selectSort" {
            previousSegueNumber = 3
        }
        
        self.tableView.cellForRowAtIndexPath(NSIndexPath.init(forRow: previousSegueNumber-1, inSection: 0))?.detailTextLabel?.text = AppInfo.sharedInstance.stringFromCellIndex(previousSegueNumber)
    }
}
