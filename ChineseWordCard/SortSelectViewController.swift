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
        AppInfo.sharedInstance.queryWithStar = rateArray[indexPath.row]
    }
}
