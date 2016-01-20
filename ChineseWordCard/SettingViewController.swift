//
//  SettingViewController.swift
//  ChineseWordCard
//
//  Created by SangChan Lee on 1/15/16.
//  Copyright © 2016 VerandaStudio. All rights reserved.
//

import UIKit

class SettingViewController: UITableViewController {
    @IBAction func clickedDoneButton(sender: AnyObject) {
        self.dismissViewControllerAnimated(true) { () -> Void in
            NSLog("dissmiss setting vc")
        }
    }
    
    override func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        if indexPath.section == 0 {
            if indexPath.row == 0 {
                // TODO : Show selection for 3 type of speak speed
            }
        }
        else if indexPath.section == 1 {
            
        }
    }

}
