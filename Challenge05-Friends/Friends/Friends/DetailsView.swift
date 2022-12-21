//
//  DetailsView.swift
//  Friends
//
//  Created by Lippmann, Erik on 21.12.22.
//

import SwiftUI

struct DetailsView: View {
    let viewModel: DetailsViewModel
    var body: some View {
        List {
            Section("Personal data") {
                VStack(alignment: .leading, spacing: 8) {
                    HStack {
                        Text("Active: ")
                        Image(systemName: viewModel.user.isActive ? "checkmark.seal.fill" : "checkmark.seal")
                            .foregroundColor(viewModel.user.isActive ? .green : .gray)
                    }

                    HStack {
                        Text("Name: ")
                        Text(viewModel.user.name)
                    }

                    HStack {
                        Text("Age: ")
                        Text("\(viewModel.user.age)")
                    }
                }
            }

            Section("Joined") {
                Text(viewModel.user.registered.formatted())
            }

            Section("About") {
                Text(viewModel.user.about)
            }

            Section("Contact") {
                HStack {
                    Text("Address: ")
                    Text("\(viewModel.user.address)")
                }

                HStack {
                    Text("Email: ")
                    Text("\(viewModel.user.email)")
                }
            }

            Section("Tags") {
                    ScrollView(.horizontal, showsIndicators: true) {
                        HStack {
                            ForEach(viewModel.user.tags, id: \.self) { tag in
                                Text(tag)
                                    .foregroundColor(.white)
                                    .padding(.horizontal, 6)
                                    .padding(.vertical, 2)
                                    .background(Color.green)
                                    .clipShape(RoundedRectangle(cornerRadius: 8.0))
                                    .shadow(radius: 4, y: 2)
                                    .padding(.vertical, 8)
                                
                            }
                        }
                    }
            }

            Section("Friends") {
                    ForEach(viewModel.user.friends) { friend in
                        Text(friend.name)
                    }
            }
        }
        .navigationTitle(viewModel.user.name)
        .navigationBarTitleDisplayMode(.inline)
    }
}

struct DetailsView_Previews: PreviewProvider {
    static var previews: some View {

        let mockUser = User(
            id: "No ID",
            isActive: true,
            name: "Mock User",
            age: 21,
            company: "ACME",
            email: "mock.user@acme.com",
            address: "ACME lane 1, 123456 Los Angeles",
            about: "Just another user never to exist",
            registered: Date.now,
            tags: ["mock", "user", "acme"],
            friends: [
                Friend(id: "ID 1", name: "Mock Friend"),
                Friend(id: "ID 2", name: "Mock Friend 2")
            ]
        )

        NavigationView {
            DetailsView(viewModel: DetailsViewModel(user: mockUser))
        }
    }
}
