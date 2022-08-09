//
//  ScrollViewView.swift
//  Moonshot
//
//  Created by Lippmann, Erik on 05.08.22.
//

import SwiftUI

struct CustomText: View {
    let text: String

    var body: some View {
        Text(text)
    }

    init(_ text: String) {
        print("Creating a new Custom Text")
        self.text = text
    }
}

struct ScrollViewView: View {
    var body: some View {
        VStack(spacing: 16) {
            VStack (spacing: 8) {
                Section("Horizontal ScrollView") {
                    ScrollView(.horizontal) {
                        LazyHStack(spacing: 10) {
                            ForEach(0..<100) {
                                CustomText("Item \($0)")
                                    .font(.title)
                            }
                        }
                        .frame(maxWidth: .infinity, maxHeight: 50)
                    }
                }
            }

            VStack (spacing: 8) {
                Section("Vertical ScrollView") {
                    ScrollView(.vertical) {
                        LazyVStack(spacing: 10) {
                            ForEach(0..<100) {
                                Text("Item \($0)")
                                    .font(.title)
                            }
                        }
                        .frame(maxWidth: .infinity)
                    }
                }
            }
        }
        .padding()
    }
}

struct ScrollViewView_Previews: PreviewProvider {
    static var previews: some View {
        ScrollViewView()
    }
}
