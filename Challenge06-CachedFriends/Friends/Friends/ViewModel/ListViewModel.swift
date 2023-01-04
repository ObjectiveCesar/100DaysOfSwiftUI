//
//  ListViewModel.swift
//  Friends
//
//  Created by Lippmann, Erik on 22.12.22.
//

import CoreData
import Foundation
import SwiftUI

@MainActor
class ListViewModel: ObservableObject {

    private let usersService: UsersService

    @Published var users: [User] = []
    @Published var showAlert = false

    private let dataController: DataController
    private let context: NSManagedObjectContext

    private var cachedUsers: [CachedUser] = []

    init(usersService: UsersService, dataControler: DataController = DataController()) {
        self.usersService = usersService
        self.dataController = dataControler
        context = dataControler.container.viewContext
        Task {
            await loadCachedUsers()
        }
    }

    func retrieveUsers(forceReload: Bool = false) async {
        guard forceReload == false else { await downloadUsers(); return }
        guard users.isEmpty else { return }
        guard cachedUsers.isEmpty else { await loadCachedUsers(); return }

        await downloadUsers()
    }
}

private extension ListViewModel {
    func downloadUsers() async {
        print("Downloading...")
        do {
            let users = try await usersService.fetchData()
            print("Downloading done.")
            await saveUsers(users: users)
        } catch {
            print("Could not fetch data.")
            return
        }

        await loadCachedUsers()
    }

    func loadCachedUsers() async {
        print("Loading from cache...")
        do {
            let fetchRequest = CachedUser.fetchRequest()
            fetchRequest.sortDescriptors = [NSSortDescriptor(keyPath: \CachedUser.name, ascending: true)]
            cachedUsers = try context.fetch(fetchRequest)
        } catch {
            print("Failed to fetch users.")
            cachedUsers = []
        }

        await MainActor.run {
            users = cachedUsers.map {
                User(
                    id: $0.unwrappedId,
                    isActive: $0.isActive,
                    name: $0.unwrappedName,
                    age: Int($0.age),
                    company: $0.unwrappedCompany,
                    email: $0.unwrappedEmail,
                    address: $0.unwrappedAddress,
                    about: $0.unwrappedAbout,
                    registered: $0.unwrappedRegistered,
                    tags: $0.unwrappedTags,
                    friends: $0.unwrappedFriends.map({
                        Friend(id: $0.unwrappedId,
                               name: $0.unwrappedName)
                    })
                )
            }
        }
        print("Loading is done.")
    }

    func saveUsers(users: [User]) async {
        users.forEach {
            let user = CachedUser(context: context)
            user.about = $0.about
            user.address = $0.address
            user.age = Int16($0.age)
            user.company = $0.company
            user.email = $0.email
            user.id = $0.id
            user.isActive = $0.isActive
            user.name = $0.name
            user.registered = $0.registered
            user.tags = $0.tags.joined(separator: ",")
//            user.friends = NSSet(array: $0.friends)
        }

        print("Caching...")
        await MainActor.run {
            do {
                try context.save()
                print("Caching done!")
            } catch {
                print("Caching failed!")
            }
        }
    }
}
