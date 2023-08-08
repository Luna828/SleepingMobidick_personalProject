//
//  Memo+CoreDataProperties.swift
//  
//
//  Created by t2023-m0050 on 2023/08/03.
//
//

import Foundation
import CoreData


extension Memo {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Memo> {
        return NSFetchRequest<Memo>(entityName: "Memo")
    }

    @NSManaged public var content: String?
    @NSManaged public var date: Date?

}
