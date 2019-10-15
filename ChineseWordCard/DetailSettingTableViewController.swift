//
//  DetailSettingTableViewController.swift
//  ChineseWordCard
//
//  Created by SangChan Lee on 2/19/16.
//  Copyright © 2016 VerandaStudio. All rights reserved.
//

import UIKit
import RealmSwift
import RxSwift

protocol SetupData {
   func setupData()
}

enum SetupPageType {
    case speechRate
    case languageSelect
    case sortSelect
    
    func rawValue() -> String {
        switch self {
        case .speechRate : return "SpeechRate"
        case .languageSelect : return "LanguageSelect"
        case .sortSelect : return "SortSelect"
        }
    }
}

class DetailSettingTableViewController: UITableViewController {
    internal var previousSelect : IndexPath!
    internal var model : DetailSettingViewModel!
    
    lazy var lazyRealm : Realm? = {
        do {
            return try Realm()
        } catch let error {
            print("error : \(error)")
            return nil
        }
    }()
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        self.setupData()
    }

    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        guard model.details.count > 0, model.detailName.isEmpty == false else { return }
        tableView.cellForRow(at: previousSelect)?.accessoryType = .none
        tableView.cellForRow(at: indexPath)?.accessoryType = .checkmark
        tableView.deselectRow(at: indexPath, animated: true)
        previousSelect = indexPath
        let indexObject : EnumInfo = self.infoObject(fromName:model.detailName)
        indexObject.enumInfo(setIndex:model.details[(indexPath as NSIndexPath).row].rawValue)
    }
    
    override func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        guard model.details.count > 0, model.detailName.isEmpty == false else { return }
        let indexObject : EnumInfo = self.infoObject(fromName:model.detailName)
        let infoIndex : Int = indexObject.indexFromEnum()
        if infoIndex ==  model.details[(indexPath as NSIndexPath).row].rawValue {
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
    @objc func setupData() {
        // if app enters these era, it better to be fault
        model = DetailSettingViewModel(detailType: SetupPageType.speechRate,
                                 detailName: "TEST",
                                 details: [])
    }
}
// MARK: - speech rate select
class SpeechRateViewController: DetailSettingTableViewController {
    override func setupData() {
        model = DetailSettingViewModel(detailType: SetupPageType.speechRate,
                                 detailName: SetupPageType.speechRate.rawValue(),
                                 details: [SpeechSpeedIndex.speechSpeedSlow, SpeechSpeedIndex.speechSpeedNormal, SpeechSpeedIndex.speechSpeedFast])
    }
}
// MARK: - language select
class LanguageSelectViewController: DetailSettingTableViewController {
    override func setupData() {
        model = DetailSettingViewModel(detailType: SetupPageType.languageSelect,
                                 detailName: SetupPageType.languageSelect.rawValue(),
                                 details: [LanguageIndex.languageIndexEN, LanguageIndex.langyageIndexES, LanguageIndex.languageIndexKR])
    }
}
// MARK: - sort select
class SortSelectViewController: DetailSettingTableViewController {
    override func setupData() {
        model = DetailSettingViewModel(detailType: SetupPageType.sortSelect,
                                 detailName: SetupPageType.sortSelect.rawValue(),
                                 details: [SortIndex.sortIndexNone, SortIndex.sortIndexAlphabet, SortIndex.sortIndexStar])
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        guard let realm = self.lazyRealm else { return 2 }
        guard realm.objects(ChineseWord.self).filter("likeIt == true").count > 0 else {
            return 2
        }
        return 3
    }
}
