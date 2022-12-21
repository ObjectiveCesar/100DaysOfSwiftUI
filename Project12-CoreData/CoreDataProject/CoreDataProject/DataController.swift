//
//  DataController.swift
//  Bookworm
//
//  Created by Lippmann, Erik on 26.10.22.
//

import CoreData
import Foundation

class DataController: ObservableObject {
//    let container = NSPersistentContainer(name: "Moview")
//    let container = NSPersistentContainer(name: "Wizard")
//    let container = NSPersistentContainer(name: "Ship")
//    let container = NSPersistentContainer(name: "Singer")
    let container = NSPersistentContainer(name: "CandyBar")

    init() {
        container.loadPersistentStores { description, error in
            if let error = error {
                print("Core Data failed to load: \(error.localizedDescription)")
            }

            self.container.viewContext.mergePolicy = NSMergePolicy.mergeByPropertyObjectTrump
        }
    }
}
