//
//  HabitTrackerApp.swift
//  HabitTracker
//
//  Created by Lippmann, Erik on 19.09.22.
//

import SwiftUI

@main
struct HabitTrackerApp: App {
    var exampleData: [TrackedItem] = {
        [
            TrackedItem(habit: Habit(name: "Habit 1", description: "Description of habit 1")),
            TrackedItem(habit: Habit(name: "Habit 2", description: "Description of habit 2")),
            TrackedItem(habit: Habit(name: "Habit 3", description: "Description of habit 3"))
        ]
    }()

    var body: some Scene {
        WindowGroup {
            MainView(trackedItems: exampleData)
        }
    }
}
