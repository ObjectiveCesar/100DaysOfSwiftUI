//
//  CachedUser+CoreDataProperties.swift
//  Friends
//
//  Created by Lippmann, Erik on 21.12.22.
//
//

import Foundation
import CoreData


extension CachedUser {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<CachedUser> {
        return NSFetchRequest<CachedUser>(entityName: "CachedUser")
    }

    @NSManaged public var about: String?
    @NSManaged public var address: String?
    @NSManaged public var age: Int16
    @NSManaged public var company: String?
    @NSManaged public var email: String?
    @NSManaged public var id: String?
    @NSManaged public var isActive: Bool
    @NSManaged public var name: String?
    @NSManaged public var registered: Date?
    @NSManaged public var tags: String?
    @NSManaged public var friends: NSSet?

    public var unwrappedAbout: String { about ?? "Data missing" }
    public var unwrappedAddress: String  { address ?? "Data missing" }
    public var unwrappedCompany: String { company ?? "Data missing" }
    public var unwrappedEmail: String { email ?? "Data missing" }
    public var unwrappedId: String { id ?? "Data missing" }
    public var unwrappedName: String { name ?? "Data missing" }
    public var unwrappedRegistered: Date { registered ?? Date.distantPast }
    public var unwrappedTags: [String]  { tags?.components(separatedBy: ",") ?? [] }
    public var unwrappedFriends: [CachedFriend] {
        let set = friends as? Set<CachedFriend> ?? []
        return set.sorted {
            $0.unwrappedName < $1.unwrappedName
        }
    }
}
// MARK: Generated accessors for friends
extension CachedUser {

    @objc(addFriendsObject:)
    @NSManaged public func addToFriends(_ value: CachedFriend)

    @objc(removeFriendsObject:)
    @NSManaged public func removeFromFriends(_ value: CachedFriend)

    @objc(addFriends:)
    @NSManaged public func addToFriends(_ values: NSSet)

    @objc(removeFriends:)
    @NSManaged public func removeFromFriends(_ values: NSSet)

}

extension CachedUser : Identifiable {

}
