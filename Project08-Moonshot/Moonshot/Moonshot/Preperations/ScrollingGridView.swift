//
//  ScrollingGridView.swift
//  Moonshot
//
//  Created by Lippmann, Erik on 05.08.22.
//

import SwiftUI

struct ScrollingGridView: View {
    let layout = [
        GridItem(.adaptive(minimum: 80, maximum: 120))
    ]

    var body: some View {
        VStack(spacing: 16) {
            Section("LazyVGrid") {
                ScrollView {
                    LazyVGrid(columns: layout) {
                        ForEach(0..<1000) {
                            Text("Item \($0)")
                        }
                    }
                }
            }

            Section("LazyHGrid") {
                ScrollView(.horizontal) {
                    LazyHGrid(rows: layout) {
                        ForEach(0..<1000) {
                            Text("Item \($0)")
                        }
                    }
                }
            }
        }
        .padding()
    }
}

struct ScrollingGridView_Previews: PreviewProvider {
    static var previews: some View {
        ScrollingGridView()
    }
}
