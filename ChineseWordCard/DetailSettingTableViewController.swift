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
    
    override func viewDidLoad() {
        self.title = self.model.title
    }

    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        guard model.details.count > 0, model.detailName.isEmpty == false else { return }
        tableView.cellForRow(at: previousSelect)?.accessoryType = .none
        tableView.cellForRow(at: indexPath)?.accessoryType = .checkmark
        tableView.deselectRow(at: indexPath, animated: true)
        previousSelect = indexPath
        let indexObject : EnumInfo = model.indexObject
        indexObject.enumInfo(setIndex:model.details[(indexPath as NSIndexPath).row].rawValue)
    }
    
    override func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        guard model.details.count > 0, model.detailName.isEmpty == false else { return }
        let indexObject : EnumInfo = model.indexObject
        let infoIndex : Int = indexObject.indexFromEnum()
        if infoIndex ==  model.details[(indexPath as NSIndexPath).row].rawValue {
            cell.accessoryType = .checkmark
            previousSelect = indexPath
        } else {
            cell.accessoryType = .none
        }
        cell.textLabel?.text = indexObject.string(fromIndex:(indexPath as NSIndexPath).row)
    }
    
    override func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        guard model.sectionHeader.count >= section else { return nil }
        return model.sectionHeader[section]
    }
    
    override func tableView(_ tableView: UITableView, titleForFooterInSection section: Int) -> String? {
        guard model.sectionFooter.count >= section else { return nil }
        return model.sectionFooter[section]
    }
    
    func setupData() { }
}

// MARK: - speech rate select
class SpeechRateViewController: DetailSettingTableViewController {
    override func setupData() {
        model = DetailSettingViewModel.value(with: .speechRate)
    }
}
// MARK: - language select
class LanguageSelectViewController: DetailSettingTableViewController {
    override func setupData() {
        model = DetailSettingViewModel.value(with: .languageSelect)
    }
}
// MARK: - sort select
class SortSelectViewController: DetailSettingTableViewController {
    override func setupData() {
        model = DetailSettingViewModel.value(with: .sortSelect)
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        guard let realm = self.lazyRealm else { return 2 }
        guard realm.objects(ChineseWord.self).filter("likeIt == true").count > 0 else {
            return 2
        }
        return 3
    }
}
