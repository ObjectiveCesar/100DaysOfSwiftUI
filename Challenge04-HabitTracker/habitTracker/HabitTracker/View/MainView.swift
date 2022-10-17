//
//  ContentView.swift
//  HabitTracker
//
//  Created by Lippmann, Erik on 19.09.22.
//

import SwiftUI

struct MainView: View {

    @State private var customSorting: Bool = false
    let trackedItems: [TrackedItem]

    var body: some View {
        VStack(spacing: 24) {
            Text("Habit Tracker")
                .font(.largeTitle)
            Divider()
            VStack {
                HStack {
                    Text("Tracked habits")
                        .font(.title)
                    Spacer()

                    Button {
                        customSorting.toggle()
                    } label: {
                        HStack {
                            Text("Sorted by date")
                            Image(systemName: customSorting ? "arrow.up" : "arrow.down")
                        }
                        .foregroundColor(.primary)
                        .font(.caption)
                    }
                }

                List(customSorting ? trackedItems.sortedByDateAsc : trackedItems.sortedByDateDesc) { item in
                    Text("\(item.habit.name) tracked on \(item.date.formatted(.dateTime))")
                }
                .listStyle(.plain)
            }
            .padding([.vertical], 4)
        }
        .padding()
    }
}

struct MainView_Previews: PreviewProvider {

    static var exampleData: [TrackedItem] = {
        [
            TrackedItem(habit: Habit(name: "Habit 1", description: "Description of habit 1")),
            TrackedItem(habit: Habit(name: "Habit 2", description: "Description of habit 2")),
            TrackedItem(habit: Habit(name: "Habit 3", description: "Description of habit 3"))
        ]
    }()

    static var previews: some View {
        MainView(trackedItems: exampleData)
    }
}

extension Array where Element == TrackedItem {
    var sortedByDateDesc: [TrackedItem] {
        sorted { $0.date > $1.date }
    }

    var sortedByDateAsc: [TrackedItem] {
        sorted { $0.date < $1.date }
    }
}
