//
//  EditView.swift
//  BucketList
//
//  Created by Lippmann, Erik on 21.02.23.
//

import SwiftUI

struct EditView: View {
    @Environment(\.dismiss) var dismiss
    var location: Location
    var onSave: (Location) -> Void

    @StateObject private var viewModel: ViewModel

    init(location: Location, onSave: @escaping (Location) -> Void) {
        self.location = location
        self.onSave = onSave

        _viewModel = StateObject(wrappedValue: ViewModel(name: location.name,
                                                         description: location.description))
    }

    var body: some View {
        NavigationView {
            Form {
                Section {
                    TextField("Place name", text: $viewModel.name)
                    TextField("Description", text: $viewModel.description)
                }

                Section("Nearby…") {
                    switch viewModel.loadingState {
                    case .loaded:
                        ForEach(viewModel.pages, id: \.pageid) { page in
                            Text(page.title)
                                .font(.headline)
                            + Text(": ") +
                            Text(page.description)
                                .italic()
                        }
                    case .loading:
                        Text("Loading…")
                    case .failed:
                        Text("Please try again later.")
                    }
                }
            }
            .navigationTitle("Place details")
            .toolbar {
                Button("Save") {
                    let location = viewModel.copyLocation(location)
                    onSave(location)
                    dismiss()
                }
            }
            .task {
                await viewModel.fetchNearbyPlaces(coordinate: location.coordinate)
            }
        }
    }


}

struct EditView_Previews: PreviewProvider {
    static var previews: some View {
        EditView(location: .example) { _ in }
    }
}
