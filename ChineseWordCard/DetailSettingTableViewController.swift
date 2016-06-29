//
//  DetailSettingTableViewController.swift
//  ChineseWordCard
//
//  Created by SangChan Lee on 2/19/16.
//  Copyright © 2016 VerandaStudio. All rights reserved.
//

import UIKit

class DetailSettingTableViewController: UITableViewController {
    var previousSelect = NSIndexPath.init(forRow: 0, inSection: 0)
    internal var detailName : String!
    internal var detailArray : Array<Int>!
    
    override func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        tableView.cellForRowAtIndexPath(previousSelect)?.accessoryType = .None
        tableView.cellForRowAtIndexPath(indexPath)?.accessoryType = .Checkmark
        tableView.deselectRowAtIndexPath(indexPath, animated: true);
        previousSelect = indexPath
        switch detailName {
        case "SpeechRate":
            //AppInfo.sharedInstance.speechSpeedInfo.setSpeechSpeed(detailArray[indexPath.row])
            break
        case "LanguageSelect":
            //AppInfo.sharedInstance.languageInfo.setLanguageInfo(detailArray[indexPath.row])
            break
        case "SortSelect":
            //AppInfo.sharedInstance.sortInfo.setSortInfo(detailArray[indexPath.row])
            break
        default:
            return
        }
    }
}
