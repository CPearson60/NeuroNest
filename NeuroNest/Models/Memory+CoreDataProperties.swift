//
//  Memory+CoreDataProperties.swift
//  NeuroNest
//
//  Created by Cameron Pearson on 6/21/25.
//
//

import Foundation
import CoreData


extension Memory {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Memory> {
        return NSFetchRequest<Memory>(entityName: "Memory")
    }

    @NSManaged public var title: String?
    @NSManaged public var emotion: String?
    @NSManaged public var notes: String?
    @NSManaged public var date: Date?
    @NSManaged public var tag: String?
    @NSManaged public var mediaURL: String?
    @NSManaged public var mediaType: String?
    @NSManaged public var imageData: Data?
    @NSManaged public var linkedMemories: NSSet?

}

// MARK: Generated accessors for linkedMemories
extension Memory {

    @objc(addLinkedMemoriesObject:)
    @NSManaged public func addToLinkedMemories(_ value: Memory)

    @objc(removeLinkedMemoriesObject:)
    @NSManaged public func removeFromLinkedMemories(_ value: Memory)

    @objc(addLinkedMemories:)
    @NSManaged public func addToLinkedMemories(_ values: NSSet)

    @objc(removeLinkedMemories:)
    @NSManaged public func removeFromLinkedMemories(_ values: NSSet)

}

extension Memory : Identifiable {

}
