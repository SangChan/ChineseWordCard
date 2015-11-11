//
//  Word+CoreDataProperties.swift
//  ChineseWordCard
//
//  Created by SangChan Lee on 11/11/15.
//  Copyright © 2015 VerandaStudio. All rights reserved.
//
//  Choose "Create NSManagedObject Subclass…" from the Core Data editor menu
//  to delete and recreate this implementation file for your updated model.
//

import Foundation
import CoreData

extension Word {

    @NSManaged var chapter: NSNumber?
    @NSManaged var desc: String?
    @NSManaged var hanyu: String?
    @NSManaged var id: NSNumber?
    @NSManaged var level: NSNumber?
    @NSManaged var pinyin: String?

}
