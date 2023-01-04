//
//  ContentView.swift
//  Friends
//
//  Created by Lippmann, Erik on 21.12.22.
//

import SwiftUI

struct ListView: View {
    @State private var users: [User] = []
    @State private var forceReload = false

    @ObservedObject private var viewModel: ListViewModel

    init(viewModel: ListViewModel) {
        self.viewModel = viewModel
    }

    var body: some View {
        NavigationView {
            List {
                ForEach(viewModel.users, id: \.id) { user in
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
            .alert("Data Loading Failed", isPresented: $viewModel.showAlert) {
                Button("Retry", role: .none) {
                    Task {
                        viewModel.showAlert = false
                        await reloadUsers()
                    }
                }
                Button("Cancel", role: .cancel) {
                    viewModel.showAlert = false
                }
            } message: {
                Text("The data could not be loaded. Would you like to try again?")
            }
            .refreshable {
                Task {
                    await reloadUsers(force: true)
                }
            }
        }
        .task {
            await reloadUsers()
        }

    }
}

private extension ListView {
    func reloadUsers(force: Bool = false) async {
        Task(priority: .userInitiated) {
            await viewModel.retrieveUsers(forceReload: force)
        }
    }
}

struct ListView_Previews: PreviewProvider {

    static var previews: some View {
        ListView(
            viewModel: ListViewModel(usersService: UsersService())
        )
    }
}
