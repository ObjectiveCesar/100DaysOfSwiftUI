//
//  TrackedItem.swift
//  HabitTracker
//
//  Created by Lippmann, Erik on 19.09.22.
//

import Foundation

struct TrackedItem: Identifiable, Codable {
    let id: UUID
    let habit: Habit
    let date: Date

    init(id: UUID = UUID(), habit: Habit, date: Date = .now) {
        self.id = id
        self.habit = habit
        self.date = date
    }
}
