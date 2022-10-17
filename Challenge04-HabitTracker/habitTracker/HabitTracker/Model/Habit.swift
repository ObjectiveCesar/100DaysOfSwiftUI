//
//  Habit.swift
//  HabitTracker
//
//  Created by Lippmann, Erik on 19.09.22.
//

import Foundation

struct Habit: Identifiable, Codable {
    var id: String { name }
    let name: String
    let description: String
}
