//
//  SortSelectViewController.swift
//  ChineseWordCard
//
//  Created by SangChan Lee on 2/23/16.
//  Copyright © 2016 VerandaStudio. All rights reserved.
//

import UIKit
import RealmSwift

class SortSelectViewController: DetailSettingTableViewController {
    let rateArray = Array(arrayLiteral:SortIndex.SortIndexNone,SortIndex.SortIndexAlphabet,SortIndex.SortIndexStar)
    
    override func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        super.tableView(tableView, didSelectRowAtIndexPath: indexPath)
        AppInfo.sharedInstance.sortInfo.setSortInfo(rateArray[indexPath.row])
    }
    
    override func tableView(tableView: UITableView, willDisplayCell cell: UITableViewCell, forRowAtIndexPath indexPath: NSIndexPath) {
        if AppInfo.sharedInstance.sortInfo.sortInfo ==  rateArray[indexPath.row] {
            cell.accessoryType = .Checkmark
            previousSelect = indexPath
        } else {
            cell.accessoryType = .None
        }
    }
    
    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        let realm = try! Realm()
        return (realm.objects(ChineseWord).filter("likeIt == true").count > 0) ? 3 : 2
    }
}
