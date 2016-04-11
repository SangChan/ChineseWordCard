//
//  SortSelectViewController.swift
//  ChineseWordCard
//
//  Created by SangChan Lee on 2/23/16.
//  Copyright © 2016 VerandaStudio. All rights reserved.
//

import UIKit

class SortSelectViewController: DetailSettingTableViewController {
    let rateArray = [SortIndex.SortIndexNone,SortIndex.SortIndexAlphabet,SortIndex.SortIndexStar]
    
    override func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        super.tableView(tableView, didSelectRowAtIndexPath: indexPath)
        AppInfo.sharedInstance.setSortInfo(rateArray[indexPath.row])
    }
    
    // TODO : If there is no likiIt, have to prevent to select sort by star.
    override func tableView(tableView: UITableView, willDisplayCell cell: UITableViewCell, forRowAtIndexPath indexPath: NSIndexPath) {
        if indexPath.row == 2 {
            //no data for LikeIt, this cell is inactivate.
        }
        
        if AppInfo.sharedInstance.sortInfo ==  rateArray[indexPath.row] {
            cell.accessoryType = .Checkmark
            previousSelect = indexPath
        } else {
            cell.accessoryType = .None
        }
    }
}
