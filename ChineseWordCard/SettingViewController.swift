//
//  SettingViewController.swift
//  ChineseWordCard
//
//  Created by SangChan Lee on 1/15/16.
//  Copyright © 2016 VerandaStudio. All rights reserved.
//

import UIKit
import AVFoundation
import RxSwift

class SettingViewController: UITableViewController {
    private var model = SettingViewModel.model()
    
    override func viewDidLoad() {
        self.title = model.title
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        for index in 0 ..< self.tableView.numberOfRows(inSection: 0) {
            if let cell = self.tableView.cellForRow(at: IndexPath.init(row: index, section: 0)) {
                setCell(cell, with: CellInfo(title: model.settings[index], detail: model.details[index]))
            }
        }
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
    }
    
    override func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        switch (indexPath.section, indexPath.row) {
        case (0, 0 ... 2) :
            setCell(cell, with: CellInfo(title: model.settings[indexPath.row], detail: model.details[indexPath.row]))
        case (1, 0) :
            setCell(cell, with: CellInfo(title: model.versionTitle, detail: model.versionInfo))
        default :
            return
        }
    }
    
    override func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        guard model.sectionHeaders.count >= section else { return nil }
        return model.sectionHeaders[section]
    }
    
    override var preferredStatusBarStyle : UIStatusBarStyle {
        return .default
    }
    
    @IBAction func clickedDoneButton(_ sender: AnyObject) {
        self.dismiss(animated: true, completion: nil)
    }
}

struct CellInfo {
    let title : String
    let detail : String
}

extension SettingViewController {
    private func setCell(_ cell: UITableViewCell, with info: CellInfo) {
        cell.textLabel?.text = info.title
        cell.detailTextLabel?.text = info.detail
    }
}
