//
//  EditViewModel.swift
//  BucketList
//
//  Created by Lippmann, Erik on 21.02.23.
//

import Foundation
import MapKit

extension EditView {

    @MainActor class ViewModel: ObservableObject {
        enum LoadingState {
            case loading, loaded, failed
        }

        @Published var loadingState = LoadingState.loading
        @Published var pages = [Page]()

        @Published var name: String
        @Published var description: String

        init(loadingState: LoadingState = LoadingState.loading,
             pages: [Page] = [Page](),
             name: String,
             description: String) {
            self.loadingState = loadingState
            self.pages = pages
            self.name = name
            self.description = description
        }

        func fetchNearbyPlaces(coordinate: CLLocationCoordinate2D) async {
            let urlString = "https://en.wikipedia.org/w/api.php?ggscoord=\(coordinate.latitude)%7C\(coordinate.longitude)&action=query&prop=coordinates%7Cpageimages%7Cpageterms&colimit=50&piprop=thumbnail&pithumbsize=500&pilimit=50&wbptterms=description&generator=geosearch&ggsradius=10000&ggslimit=50&format=json"

            guard let url = URL(string: urlString) else {
                print("Bad URL: \(urlString)")
                return
            }

            do {
                let (data, _) = try await URLSession.shared.data(from: url)

                // we got some data back!
                let items = try JSONDecoder().decode(Result.self, from: data)

                // success – convert the array values to our pages array
                pages = items.query.pages.values.sorted()
                loadingState = .loaded
            } catch {
                // if we're still here it means the request failed somehow
                loadingState = .failed
            }
        }

        func copyLocation(_ location: Location) -> Location {
            var copy = location
            copy.id = UUID()
            copy.name = name
            copy.description = description
            return copy
        }
    }
}
