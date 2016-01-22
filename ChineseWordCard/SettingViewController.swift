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
        }
    }
    override func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        // TODO : is it necesarry?
        if indexPath.section == 0 {
            if indexPath.row == 0 {
            }
        }
        else if indexPath.section == 1 {
            
        }
    }

}
