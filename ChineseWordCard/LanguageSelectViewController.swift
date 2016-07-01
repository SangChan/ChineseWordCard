//
//  LanguageSelectViewController.swift
//  ChineseWordCard
//
//  Created by LeeSangchan on 2016. 2. 21..
//  Copyright © 2016년 VerandaStudio. All rights reserved.
//

import UIKit

class LanguageSelectViewController: DetailSettingTableViewController {
    let rateArray = Array(arrayLiteral:LanguageIndex.LanguageIndexEN,LanguageIndex.LangyageIndexES,LanguageIndex.LanguageIndexKR)
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        detailName = "LanguageSelect"
        detailArray = [LanguageIndex.LanguageIndexEN.rawValue,LanguageIndex.LangyageIndexES.rawValue,LanguageIndex.LanguageIndexKR.rawValue]
    }
    
    override func tableView(tableView: UITableView, willDisplayCell cell: UITableViewCell, forRowAtIndexPath indexPath: NSIndexPath) {
        if AppInfo.sharedInstance.languageInfo.languageInfo ==  rateArray[indexPath.row] {
            cell.accessoryType = .Checkmark
            previousSelect = indexPath
        } else {
            cell.accessoryType = .None
        }
    }

}
