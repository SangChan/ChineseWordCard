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
    internal var detailName : String?
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        self.detailName = aDecoder.decodeObjectForKey("detailName")?.string
    }
    
    override func encodeWithCoder(aCoder: NSCoder) {
        super.encodeWithCoder(aCoder)
        aCoder.encodeObject(self.detailName, forKey: "detailName")
    }
    
    override func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        tableView.cellForRowAtIndexPath(previousSelect)?.accessoryType = .None
        tableView.cellForRowAtIndexPath(indexPath)?.accessoryType = .Checkmark
        tableView.deselectRowAtIndexPath(indexPath, animated: true);
        previousSelect = indexPath
    }
}
