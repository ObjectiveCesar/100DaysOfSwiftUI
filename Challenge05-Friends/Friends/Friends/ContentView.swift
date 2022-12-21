//
//  ContentView.swift
//  Friends
//
//  Created by Lippmann, Erik on 21.12.22.
//

import SwiftUI

struct ContentView: View {
    @State private var users: [User] = []
    let usersService: UsersService

    var body: some View {
        NavigationView {
            List {
                ForEach(users, id: \.id) { user in
                    NavigationLink {
                        DetailsView(viewModel: DetailsViewModel(user: user))
                    } label: {
                        HStack {
                            Text(user.name)
                            Image(systemName: user.isActive ? "checkmark.seal.fill" : "checkmark.seal")
                                .foregroundColor(user.isActive ? .green : .gray)
                        }
                    }
                }
            }
            .listStyle(.plain)
            .navigationTitle("Friends")

        }
        .task {
            guard users.isEmpty else { return }
            do {
                users = try await usersService.fetchData()
            } catch {
                print("Loading failed")
            }
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView(usersService: UsersService())
    }
}
