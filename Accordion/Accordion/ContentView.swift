//
//  ContentView.swift
//  Arcodion
//
//  Created by Lippmann, Erik on 30.06.22.
//

import SwiftUI

struct Bookmark: Identifiable {
    let id = UUID()
    let name: String
    let icon: String
    var items: [Bookmark]?

    // some example websites
    static let apple = Bookmark(name: "Apple",
                                icon: "1.circle")
    static let bbc = Bookmark(name: "BBC",
                              icon: "square.and.pencil")
    static let swift = Bookmark(name: "Swift",
                                icon: "bolt.fill")
    static let twitter = Bookmark(name: "Twitter",
                                  icon: "mic")

    // some example groups
    static let example1 = Bookmark(name: "Favorites",
                                   icon: "star",
                                   items: [Bookmark.apple, Bookmark.bbc, Bookmark.swift, Bookmark.twitter])
    static let example2 = Bookmark(name: "Recent",
                                   icon: "timer",
                                   items: [Bookmark.apple, Bookmark.bbc, Bookmark.swift, Bookmark.twitter])
    static let example3 = Bookmark(name: "Recommended", icon: "hand.thumbsup", items: [Bookmark.apple, Bookmark.bbc, Bookmark.swift, Bookmark.twitter])

    @State private var opened: [String] = []
}

struct MyStyle: DisclosureGroupStyle {
    func makeBody(configuration: Configuration) -> some View {
        VStack {
            Button {
                withAnimation {
                    configuration.isExpanded.toggle()
                }
            } label: {
                HStack(alignment: .firstTextBaseline) {
                    configuration.label
                        .font(.headline)
                        .foregroundColor(.green)
                    Spacer()
                    Image(systemName: configuration.isExpanded ? "minus" : "plus")
                        .foregroundColor(.green)
                        .animation(.easeInOut, value: configuration.isExpanded)
                }
                .contentShape(Rectangle())
            }
            .buttonStyle(.bordered)
            if configuration.isExpanded {
                configuration.content
            }
        }
    }
}

struct ContentView: View {
    let items: [Bookmark] = [.example1, .example2, .example3]

    var body: some View {
        VStack {
            ForEach(items) { item in
                DisclosureGroup(item.name) {
                        VStack (spacing: 8) {
                            HStack {
                                Text("This is a headline")
                                    .font(.title)
                                Spacer()
                            }

                            HStack {
                                Text("This is a very long text to describ stuff that is not really important.")
                                    .font(.body)
                                Spacer()
                            }

                            HStack {
                                Button("This is a Text-Button \(Image(systemName: "arrow.up.right.square"))") {
                                    openAndClose(items.firstIndex{ $0.id == item.id })
                                }
                                Spacer()
                            }
                        }
                        .padding()
                }
                .disclosureGroupStyle(MyStyle())
            }
            Spacer()
        }
        .padding(24)
    }

    func openAndClose(_ index: Int?) {

    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
