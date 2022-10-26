//
//  ContentView.swift
//  Bookworm
//
//  Created by Lippmann, Erik on 26.10.22.
//

import SwiftUI

struct ContentView: View {
    var body: some View {
        NavigationView {
            List {
                Section("Preparations") {
                    NavigationLink("@Binding") {
                        AtBindingView()
                    }

                    NavigationLink("Text Editor") {
                        TextEditorView()
                    }

                    NavigationLink("Combine Core Data and SwiftUI") {
                        CoreDataAndSwiftUI()
                    }
                }

                Section("Bookworm") {
                    NavigationLink("Bookworm") {
                        BookwormView()
                    }
                }
            }
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
