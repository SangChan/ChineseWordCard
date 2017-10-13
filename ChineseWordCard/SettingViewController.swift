//
//  SettingViewController.swift
//  ChineseWordCard
//
//  Created by SangChan Lee on 1/15/16.
//  Copyright © 2016 VerandaStudio. All rights reserved.
//

import UIKit
import AVFoundation

class SettingViewController: UITableViewController {
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        for index in 1 ... self.tableView.numberOfRows(inSection: 0) {
            if let cell = self.tableView.cellForRow(at: IndexPath.init(row: index-1, section: 0)) {
                cell.detailTextLabel?.text = AppInfo.sharedInstance.stringFrom(cellindex: index)
            }
        }
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
    }
    
    override func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        switch (indexPath.section, indexPath.row) {
        case (0, 0 ... 2) :
            cell.detailTextLabel?.text = AppInfo.sharedInstance.stringFrom(cellindex: indexPath.row+1)
        case (1, 0) :
            cell.detailTextLabel?.text = Bundle.main.object(forInfoDictionaryKey: "CFBundleShortVersionString") as? String
        default :
            return
        }
    }
    
    override func tableView(_ tableView: UITableView, didEndDisplaying cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        if indexPath.section == 1 && indexPath.row == 0 {
            // TODO : check update
        }
    }
    
    override var preferredStatusBarStyle : UIStatusBarStyle {
        return .default
    }
    
    @IBAction func clickedDoneButton(_ sender: AnyObject) {
        self.dismiss(animated: true, completion: nil)
    }
}

extension SettingViewController {
    fileprivate func checkToNeedToUpdate(bundleShortVersion: String, minSupportVersion : String) -> Bool {
        let appBuildNumberArray = bundleShortVersion.components(separatedBy: ".")
        let minBuildNumberArray = minSupportVersion.components(separatedBy: ".")
        
        var i = 0
        for minBuildStr in minBuildNumberArray {
            if i > appBuildNumberArray.count-1 {
                return false
            }
            let minBuildNumber : Int = Int(minBuildStr) ?? 0
            let appBuildNumber : Int = Int(appBuildNumberArray[i]) ?? 0
            if appBuildNumber < minBuildNumber {
                return true
            } else if appBuildNumber > minBuildNumber {
                return false
            }
            i += 1
        }
        return false
    }
}
