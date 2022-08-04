//
//  ExpenseItem.swift
//  iExpense
//
//  Created by Lippmann, Erik on 03.08.22.
//

import Foundation

struct ExpenseItem: Codable, Identifiable {
    var id = UUID()
    let name: String
    let type: ExpenseType
    let currency: Currency
    let amount: Double
}

enum ExpenseType: String, CaseIterable, Codable {
    case personal = "Personal"
    case business = "Business"
}

class Expenses: ObservableObject, Identifiable {

    let type: ExpenseType

    @Published var items: [ExpenseItem] = [] {
        didSet {
            if let encoded = try? JSONEncoder().encode(items) {
                UserDefaults.standard.set(encoded, forKey: "\(type.rawValue)_Expanses")
            }
        }
    }

    init(type: ExpenseType) {
        self.type = type
        
        if let savedItems = UserDefaults.standard.data(forKey: "\(type.rawValue)_Expanses"), let decodedItems = try? JSONDecoder().decode([ExpenseItem].self, from: savedItems) {
            items = decodedItems
            return
        }

        items = []
    }
}
