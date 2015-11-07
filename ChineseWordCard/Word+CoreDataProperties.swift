//
//  Word+CoreDataProperties.swift
//  ChineseWordCard
//
//  Created by LeeSangchan on 2015. 11. 5..
//  Copyright © 2015년 VerandaStudio. All rights reserved.
//
//  Choose "Create NSManagedObject Subclass…" from the Core Data editor menu
//  to delete and recreate this implementation file for your updated model.
//

import Foundation
import CoreData

extension Word {

    @NSManaged var chapter: NSNumber?
    @NSManaged var desc: String?
    @NSManaged var id: NSNumber?
    @NSManaged var level: NSNumber?
    @NSManaged var pinyin: String?
    @NSManaged var hanyu: String?
}
