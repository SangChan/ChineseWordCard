//
//  DetailSettingTableViewController.swift
//  ChineseWordCard
//
//  Created by SangChan Lee on 2/19/16.
//  Copyright © 2016 VerandaStudio. All rights reserved.
//

import UIKit
import RealmSwift

protocol SetupData : class {
   func setupData()
}

class DetailSettingTableViewController: UITableViewController {
    internal var previousSelect : IndexPath!
    internal var detailName     : String!
    internal var details        : Array<InfoProtocol>!
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        self.setupData()
    }

    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.cellForRow(at: previousSelect)?.accessoryType = .none
        tableView.cellForRow(at: indexPath)?.accessoryType = .checkmark
        tableView.deselectRow(at: indexPath, animated: true);
        previousSelect = indexPath
        let indexObject : EnumInfo = self.infoObject(fromName:detailName)
        indexObject.enumInfo(setIndex:details[(indexPath as NSIndexPath).row].rawValue)
    }
    
    override func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        let indexObject : EnumInfo = self.infoObject(fromName:detailName)
        let infoIndex : Int = indexObject.indexFromEnum()
        if infoIndex ==  details[(indexPath as NSIndexPath).row].rawValue {
            cell.accessoryType = .checkmark
            previousSelect = indexPath
        } else {
            cell.accessoryType = .none
        }
        cell.textLabel?.text = indexObject.string(fromIndex:(indexPath as NSIndexPath).row)
    }
    
    func infoObject(fromName : String) -> EnumInfo {
        switch fromName {
        case "SpeechRate" :
            return AppInfo.sharedInstance.speechInfo
        case "SortSelect" :
            return AppInfo.sharedInstance.sortInfo
        default:
            return AppInfo.sharedInstance.languageInfo
        }
    }
}

extension DetailSettingTableViewController : SetupData {
    func setupData() {
        detailName = "default"
        details = []
    }
}

class SpeechRateViewController: DetailSettingTableViewController {
    override func setupData() {
        detailName = "SpeechRate"
        details    = [SpeechSpeedIndex.speechSpeedSlow, SpeechSpeedIndex.speechSpeedNormal, SpeechSpeedIndex.speechSpeedFast]
    }
}


class LanguageSelectViewController: DetailSettingTableViewController {
    override func setupData() {
        detailName = "LanguageSelect"
        details    = [LanguageIndex.languageIndexEN,LanguageIndex.langyageIndexES,LanguageIndex.languageIndexKR]
    }
}

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


