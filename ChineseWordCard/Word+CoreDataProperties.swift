//
//  Word+CoreDataProperties.swift
//  ChineseWordCard
//
//  Created by LeeSangchan on 2015. 11. 13..
//  Copyright © 2015년 VerandaStudio. All rights reserved.
//
//  Choose "Create NSManagedObject Subclass…" from the Core Data editor menu
//  to delete and recreate this implementation file for your updated model.
//

import Foundation
import CoreData

extension Word {

    @NSManaged var chapter: Int16
    @NSManaged var desc: String?
    @NSManaged var hanyu: String?
    @NSManaged var id: Int16
    @NSManaged var level: Int16
    @NSManaged var pinyin: String?

}
