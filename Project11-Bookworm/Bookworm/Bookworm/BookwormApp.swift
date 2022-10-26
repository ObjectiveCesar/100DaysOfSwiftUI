//
//  BookwormApp.swift
//  Bookworm
//
//  Created by Lippmann, Erik on 26.10.22.
//

import SwiftUI

@main
struct BookwormApp: App {
    @StateObject private var coreDataAndSwiftUIDataController = CoreDataAndSwiftUIDataController()
    @StateObject private var dataController = DataController()

    var body: some Scene {
        WindowGroup {
            ContentView()
                .environment(\.managedObjectContext, dataController.container.viewContext)
        }
    }
}
