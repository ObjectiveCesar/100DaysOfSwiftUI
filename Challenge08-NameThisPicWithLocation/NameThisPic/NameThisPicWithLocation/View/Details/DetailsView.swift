//
//  NamingView.swift
//  NameThisPic
//
//  Created by Lippmann, Erik on 23.02.23.
//

import CoreLocation
import MapKit
import SwiftUI

struct DetailsView: View {

    @State private var displayName: String = ""
    private let image: Image
    private let onSave: (String, Location) -> Void
    @State private var mapRegion = MKCoordinateRegion(center: CLLocationCoordinate2D(latitude: 0.0, longitude: 0.0),
                                                      span: MKCoordinateSpan(latitudeDelta: 25, longitudeDelta: 25))
    @State private var location = Location(latitude: 0.0, longitude: 0.0)
    @State private var locationSet = false

    @Environment(\.dismiss) private var dismiss
    let locationFetcher = LocationFetcher()

    init(image: Image, onSave: @escaping (String, Location) -> Void) {
        self.image = image
        self.onSave = onSave
    }

    var body: some View {
        NavigationView {
            VStack(spacing: 24) {
                image
                    .resizable()
                    .aspectRatio(contentMode: .fit)

                TextField("Enter a name...", text: $displayName)
                    .font(.body)

                if locationSet {
                    Map(coordinateRegion: $mapRegion, annotationItems: [location]) { location in
                        MapAnnotation(coordinate: location.coordinate) {
                            MapPin()
                        }
                    }
                }

                Button {
                    if let location = locationFetcher.lastKnownLocation {
                        self.mapRegion = MKCoordinateRegion(center: CLLocationCoordinate2D(latitude: location.latitude,
                                                                                           longitude: location.longitude),
                                                            span: MKCoordinateSpan(latitudeDelta: 0.5, longitudeDelta: 0.5))
                        self.location = Location(latitude: location.latitude, longitude: location.longitude)
                        self.locationSet = true
                    } else {
                        print("Your location is unknown")
                    }
                } label: {
                    HStack {
                        Image(systemName: "location.circle")
                        Text("Add current location")

                    }
                    .padding(8)
                    .foregroundColor(.white)
                    .background(.brown)
                    .clipShape(RoundedRectangle(cornerRadius: 8))
                }
                .font(.body)
                .foregroundColor(.primary)
                .disabled(locationFetcher.lastKnownLocation == nil)

                Spacer()
            }
            .padding(.horizontal, 16)
            .navigationTitle("Enter a name")
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {
                Button {
                    onSave(displayName, location)
                    dismiss()
                } label: {
                    Image(systemName: "tray.and.arrow.down.fill")
                        .tint(.black)
                }
                .disabled(displayName.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty)
            }
            .onAppear {
                locationFetcher.start()
            }
        }
    }
}

struct NamingView_Previews: PreviewProvider {
    static let name = ""
    static var previews: some View {
        DetailsView(image: Image("kevin-horstmann-141705")) { _, _ in
            // Do nothing.
        }
    }
}
