//
//  CoreDataAndSwiftUIDataController.swift
//  Bookworm
//
//  Created by Lippmann, Erik on 26.10.22.
//

import CoreData
import Foundation

class CoreDataAndSwiftUIDataController: ObservableObject {
    let container = NSPersistentContainer(name: "CoreDataAndSwiftUI")

    init() {
        container.loadPersistentStores { description, error in
            if let error = error {
                print("Core Data failed to load: \(error.localizedDescription)")
            }
        }
    }
}
