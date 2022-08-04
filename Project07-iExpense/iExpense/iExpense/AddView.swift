//
//  AddView.swift
//  iExpense
//
//  Created by Lippmann, Erik on 03.08.22.
//

import SwiftUI

enum Currency: String, CaseIterable, Codable {
    case USD
    case EUR
    case CHF
    case NOK
    case SEK
    case PLN
    case AUD
    case CAD
}

struct AddView: View {
    @Environment(\.dismiss) var dismiss

    @State private var name = ""
    @State private var currency = Currency.USD
    @State private var type = ExpenseType.personal
    @State private var amount = 0.0

    @FocusState private var amountFocus: Bool
    @FocusState private var nameFocus: Bool

    @ObservedObject var personalExpenses: Expenses
    @ObservedObject var businessExpenses: Expenses

    var body: some View {
        NavigationView {
            Form {
                TextField("Name", text: $name)
                    .focused($nameFocus)

                Picker("Currency", selection: $currency) {
                    ForEach(Currency.allCases, id: \.self) {
                        Text($0.rawValue)
                    }
                }

                Picker("Type", selection: $type) {
                    ForEach(ExpenseType.allCases, id: \.self) {
                        Text($0.rawValue)
                    }
                }

                TextField("Amount", value: $amount, format: .currency(code: currency.rawValue))
                    .keyboardType(.decimalPad)
                    .focused($amountFocus)
            }
            .navigationTitle("Add new expense")
            .toolbar {
                Button("Save") {
                    let item = ExpenseItem(name: name, type: type, currency: currency, amount: amount)
                    switch type {
                    case .personal:
                        personalExpenses.items.append(item)
                    case .business:
                        businessExpenses.items.append(item)
                    }

                    dismiss()
                }
            }
            .toolbar {
                ToolbarItemGroup(placement: .keyboard) {
                    Spacer()
                    Button("Done") {
                        nameFocus = false
                        amountFocus = false
                    }
                }
            }
        }
    }
}

struct AddView_Previews: PreviewProvider {
    static var previews: some View {
        AddView(personalExpenses: Expenses(type: .personal), businessExpenses: Expenses(type: .business))
    }
}
