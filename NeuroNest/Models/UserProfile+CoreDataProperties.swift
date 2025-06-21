//
//  UserProfile+CoreDataProperties.swift
//  NeuroNest
//
//  Created by Cameron Pearson on 6/21/25.
//
//

import Foundation
import CoreData


extension UserProfile {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<UserProfile> {
        return NSFetchRequest<UserProfile>(entityName: "UserProfile")
    }

    @NSManaged public var name: String?
    @NSManaged public var age: Int16
    @NSManaged public var profession: String?

}

extension UserProfile : Identifiable {

}
