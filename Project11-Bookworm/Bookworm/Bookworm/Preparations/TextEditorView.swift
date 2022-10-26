//
//  TextEditorView.swift
//  Bookworm
//
//  Created by Lippmann, Erik on 26.10.22.
//

import SwiftUI

struct TextEditorView: View {
    @AppStorage("notes") private var notes = ""

    var body: some View {
        TextEditor(text: $notes)
            .navigationTitle("Notes")
            .padding()
    }
}

struct TextEditorView_Previews: PreviewProvider {
    static var previews: some View {
        NavigationView {
            TextEditorView()
        }
    }
}
