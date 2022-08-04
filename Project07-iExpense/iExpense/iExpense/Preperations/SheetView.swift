//
//  ContentView.swift
//  iExpense
//
//  Created by Lippmann, Erik on 01.08.22.
//

import SwiftUI

struct SecondView: View {

    @Environment(\.dismiss) var dismiss

    let name: String

    var body: some View {
        Button("Dismiss") {
            dismiss()
        }
    }
}

struct SheetView: View {

    @State private var showingSheet = false

    var body: some View {
        Button("Show Sheet") {
            showingSheet.toggle()
        }
        .sheet(isPresented: $showingSheet) {
            SecondView(name: "@Objective_Cesar")
        }
    }
}

struct SheetView_Previews: PreviewProvider {
    static var previews: some View {
        SheetView()
    }
}
