//
//  SpeechRateViewController.swift
//  ChineseWordCard
//
//  Created by SangChan Lee on 1/21/16.
//  Copyright © 2016 VerandaStudio. All rights reserved.
//

import UIKit

class SpeechRateViewController: DetailSettingTableViewController {
    let rateArray = Array(arrayLiteral:SpeechSpeedIndex.SpeechSpeedSlow, SpeechSpeedIndex.SpeechSpeedNormal, SpeechSpeedIndex.SpeechSpeedFast)

    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        detailName = "SpeechRate"
        detailArray = [SpeechSpeedIndex.SpeechSpeedSlow.rawValue, SpeechSpeedIndex.SpeechSpeedNormal.rawValue, SpeechSpeedIndex.SpeechSpeedFast.rawValue]
    }
    
//    override func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
//        super.tableView(tableView, didSelectRowAtIndexPath: indexPath)
//        AppInfo.sharedInstance.speechSpeedInfo.setSpeechSpeed(rateArray[indexPath.row])
//    }
    
    override func tableView(tableView: UITableView, willDisplayCell cell: UITableViewCell, forRowAtIndexPath indexPath: NSIndexPath) {
        if AppInfo.sharedInstance.speechSpeedInfo.speechSpeed ==  rateArray[indexPath.row] {
            cell.accessoryType = .Checkmark
            previousSelect = indexPath
        } else {
            cell.accessoryType = .None
        }
    }
}
