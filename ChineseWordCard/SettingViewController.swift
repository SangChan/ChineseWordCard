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
            // TODO : If nothing changed, ViewController.swift's viewWillApear method should doing nothing.
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
    
    override func preferredStatusBarStyle() -> UIStatusBarStyle {
        return .Default
    }
    
    func indexFromSegue(segue:UIStoryboardSegue) -> Int {
        if segue.identifier == "selectLanguage" {
            return 2
        } else if segue.identifier == "selectSort" {
            return 3
        }
        return 1
    }
    
    @IBAction func unwindToSegue(segue: UIStoryboardSegue) {
        let previousSegueNumber = self.indexFromSegue(segue)
        
        self.tableView.cellForRowAtIndexPath(NSIndexPath.init(forRow: previousSegueNumber-1, inSection: 0))?.detailTextLabel?.text = AppInfo.sharedInstance.stringFromCellIndex(previousSegueNumber)
    }
}
