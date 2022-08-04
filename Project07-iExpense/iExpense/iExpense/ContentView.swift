//
//  ContentView.swift
//  iExpense
//
//  Created by Lippmann, Erik on 01.08.22.
//

import SwiftUI

struct ContentView: View {

    @StateObject var personalExpenses = Expenses(type: .personal)
    @StateObject var businessExpenses = Expenses(type: .business)

    @State private var showingAddExpense = false {
        didSet {
            if showingAddExpense == false {
                formFocus = true
            }
        }
    }

    @FocusState private var formFocus: Bool

    var body: some View {
        NavigationView {
            Form {
                Section("Personal") {
                    if personalExpenses.items.count < 1 {
                        Text("No expenses, yet. Tap here or the \(Image(systemName: "plus")) to add one.")
                            .onTapGesture {
                                showingAddExpense = true
                            }
                    } else {
                        List {
                            ForEach(personalExpenses.items) { item in
                                HStack {
                                    VStack(alignment: .leading) {
                                        Text(item.name)
                                            .font(.headline)
                                        Text(item.type.rawValue)
                                    }

                                    Spacer()
                                    Text(item.amount, format: .currency(code: item.currency.rawValue))
                                        .foregroundColor(color(for: item.amount))
                                        .fontWeight(.bold)
                                }
                            }
                            .onDelete(perform: removePersonalItem)
                        }
                    }
                }

                Section("Business") {
                    if businessExpenses.items.count < 1 {
                        Text("No expenses, yet. Tap here or the \(Image(systemName: "plus")) to add one.")
                            .onTapGesture {
                                showingAddExpense = true
                            }
                    } else {
                        List {
                            ForEach(businessExpenses.items) { item in
                                HStack {
                                    VStack(alignment: .leading) {
                                        Text(item.name)
                                            .font(.headline)
                                        Text(item.type.rawValue)
                                    }

                                    Spacer()
                                    Text(item.amount, format: .currency(code: item.currency.rawValue))
                                        .foregroundColor(color(for: item.amount))
                                        .fontWeight(.bold)
                                }
                            }
                            .onDelete(perform: removeBusinessItem)
                        }
                    }
                }
            }
            .navigationTitle("iExpense")
            .toolbar {
                Button {
                    showingAddExpense = true
                } label: {
                    Image(systemName: "plus")
                }
            }
            .sheet(isPresented: $showingAddExpense) {
                AddView(personalExpenses: personalExpenses, businessExpenses: businessExpenses)
            }
            .focused($formFocus)
        }
    }
}

private extension ContentView {

    func removePersonalItem(at offsets: IndexSet) {
        personalExpenses.items.remove(atOffsets: offsets)
    }

    func removeBusinessItem(at offsets: IndexSet) {
        businessExpenses.items.remove(atOffsets: offsets)
    }

    func color(for amount: Double) -> Color {
        switch amount {
        case 0..<10.0:
            return .green
        case 10.0..<100.0:
            return .yellow
        case 100.0...Double.infinity:
            return .red
        default:
            return .gray
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
