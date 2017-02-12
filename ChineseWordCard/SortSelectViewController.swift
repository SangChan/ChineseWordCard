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
        details    = [SortIndex.sortIndexNone,SortIndex.sortIndexAlphabet,SortIndex.sortIndexStar]
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        let realm = try! Realm()
        guard realm.objects(ChineseWord.self).filter("likeIt == true").count > 0 else {
            return 2
        }
        return 3
    }
}
