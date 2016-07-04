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
            AppInfo.sharedInstance.speechSpeedInfo.setSpeechSpeed(AppInfo.sharedInstance.speechSpeedInfo.speechSpeedIndexFromIndex(detailArray[indexPath.row]))
            break
        case "LanguageSelect":
            AppInfo.sharedInstance.languageInfo.setLanguageInfo(AppInfo.sharedInstance.languageInfo.languageIndexFromIndex(detailArray[indexPath.row]))
            break
        case "SortSelect":
            AppInfo.sharedInstance.sortInfo.setSortInfo(AppInfo.sharedInstance.sortInfo.sortIndexFromIndex(detailArray[indexPath.row]))
            break
        default:
            return
        }
    }
    // TODO : tableview check makr thing.
    override func tableView(tableView: UITableView, willDisplayCell cell: UITableViewCell, forRowAtIndexPath indexPath: NSIndexPath) {
        var infoIndex : Int = 0
        switch detailName {
        case "SpeechRate":
            infoIndex = AppInfo.sharedInstance.speechSpeedInfo.getSpeechSpeed().rawValue
            break
        case "LanguageSelect":
            infoIndex = AppInfo.sharedInstance.languageInfo.getLanguageInfo().rawValue
            break
        case "SortSelect":
            infoIndex = AppInfo.sharedInstance.sortInfo.getSortInfo().rawValue
            break
        default:
            return
        }
        if infoIndex ==  detailArray[indexPath.row] {
            cell.accessoryType = .Checkmark
            previousSelect = indexPath
        } else {
            cell.accessoryType = .None
        }
    }
}
