//
//  DetailSettingTableViewController.swift
//  ChineseWordCard
//
//  Created by SangChan Lee on 2/19/16.
//  Copyright © 2016 VerandaStudio. All rights reserved.
//

import UIKit

class DetailSettingTableViewController: UITableViewController {
    internal var previousSelect : NSIndexPath!
    internal var detailName : String!
    internal var detailArray : Array<Int>!
    
    override func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        tableView.cellForRowAtIndexPath(previousSelect)?.accessoryType = .None
        tableView.cellForRowAtIndexPath(indexPath)?.accessoryType = .Checkmark
        tableView.deselectRowAtIndexPath(indexPath, animated: true);
        previousSelect = indexPath
        let indexObject : EnumInfo = self.infoObject(detailName)
        indexObject.setIndex(detailArray[indexPath.row])
    }
    
    override func tableView(tableView: UITableView, willDisplayCell cell: UITableViewCell, forRowAtIndexPath indexPath: NSIndexPath) {
        let indexObject : EnumInfo = self.infoObject(detailName)
        let infoIndex : Int = indexObject.indexFromEnum()
        if infoIndex ==  detailArray[indexPath.row] {
            cell.accessoryType = .Checkmark
            previousSelect = indexPath
        } else {
            cell.accessoryType = .None
        }
    }
    
    func infoObject(name : String) -> EnumInfo {
        switch name {
        case "SpeechRate":
            return AppInfo.sharedInstance.speechSpeedInfo
        case "SortSelect" :
            return AppInfo.sharedInstance.sortInfo
        default:
            return AppInfo.sharedInstance.languageInfo
        }
    }
}
