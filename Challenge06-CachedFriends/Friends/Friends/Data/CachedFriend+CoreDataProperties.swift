//
//  CachedFriend+CoreDataProperties.swift
//  Friends
//
//  Created by Lippmann, Erik on 21.12.22.
//
//

import Foundation
import CoreData


extension CachedFriend {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<CachedFriend> {
        return NSFetchRequest<CachedFriend>(entityName: "CachedFriend")
    }

    @NSManaged public var id: String?
    @NSManaged public var name: String?
    @NSManaged public var user: CachedUser?

    public var unwrappedId: String { id ?? "Data missing" }
    public var unwrappedName: String { name ?? "Data missing" }
}

extension CachedFriend : Identifiable {

}
