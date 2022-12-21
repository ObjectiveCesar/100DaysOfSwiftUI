//
//  CoreDataProjectApp.swift
//  CoreDataProject
//
//  Created by Lippmann, Erik on 23.11.22.
//

import SwiftUI

@main
struct CoreDataProjectApp: App {
    @StateObject private var dataController = DataController()

    var body: some Scene {
        WindowGroup {
            ContentView()
                .environment(\.managedObjectContext, dataController.container.viewContext)
        }
    }
}
