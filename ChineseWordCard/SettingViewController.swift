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
            self.tableView.cellForRow(at: IndexPath.init(row: index-1, section: 0))?.detailTextLabel?.text = AppInfo.sharedInstance.stringFrom(Cellindex: index)
        }
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true);
    }
    
    override func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        switch (indexPath.section, indexPath.row) {
        case (0,0 ... 2) :
            cell.detailTextLabel!.text = AppInfo.sharedInstance.stringFrom(Cellindex: indexPath.row+1)
        case (1,0) :
            cell.detailTextLabel!.text = Bundle.main.object(forInfoDictionaryKey: "CFBundleShortVersionString") as? String
        default :
            return
        }
    }
    
    override var preferredStatusBarStyle : UIStatusBarStyle {
        return .default
    }
    
}

extension SettingViewController {
    @IBAction func clickedDoneButton(_ sender: AnyObject) {
        self.dismiss(animated: true, completion: nil)
    }
}
