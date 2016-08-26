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
    override func setupData() {
        detailName = "SortSelect"
        detailArray = [SortIndex.SortIndexNone.rawValue,SortIndex.SortIndexAlphabet.rawValue,SortIndex.SortIndexStar.rawValue]
    }
    
    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        let realm = try! Realm()
        guard realm.objects(ChineseWord).filter("likeIt == true").count > 0 else {
            return 2
        }
        return 3
    }
}
