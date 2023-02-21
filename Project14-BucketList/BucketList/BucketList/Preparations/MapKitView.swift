//
//  MapKitView.swift
//  BucketList
//
//  Created by Lippmann, Erik on 08.02.23.
//

import MapKit
import SwiftUI

struct MapKitView: View {
    @State private var mapRegion = MKCoordinateRegion(center: CLLocationCoordinate2D(latitude: 51.5, longitude: -0.12), span: MKCoordinateSpan(latitudeDelta: 0.2, longitudeDelta: 0.2))

    private let locations = [
        MapLocation(name: "Buckingham Palace", coordinate: CLLocationCoordinate2D(latitude: 51.501, longitude: -0.141)),
        MapLocation(name: "Tower of London", coordinate: CLLocationCoordinate2D(latitude: 51.508, longitude: -0.076))
    ]

    var body: some View {
        List {
            NavigationLink("Map Marker") {
                Map(coordinateRegion: $mapRegion, annotationItems: locations) { location in
                    MapMarker(coordinate: location.coordinate)
                }
                .navigationTitle("Map Marker")
            }

            NavigationLink("Map Annotation") {
                Map(coordinateRegion: $mapRegion, annotationItems: locations) { location in
                    MapAnnotation(coordinate: location.coordinate) {
                        Circle()
                            .stroke(.red, lineWidth: 3)
                            .frame(width: 44, height: 44)
                    }
                }
                .navigationTitle("Map Annotation")
            }

            NavigationLink("Map Annotation with name") {
                Map(coordinateRegion: $mapRegion, annotationItems: locations) { location in
                    MapAnnotation(coordinate: location.coordinate) {
                        VStack {
                            Circle()
                                .stroke(.red, lineWidth: 3)
                                .frame(width: 44, height: 44)
                                .onTapGesture {
                                    print("Tapped on \(location.name)")
                                }

                            Text(location.name)
                                .padding(.horizontal, 2)
                                .background(
                                    RoundedRectangle(cornerRadius: 4)
                                        .foregroundColor(.gray.opacity(0.8))
                                )
                        }
                    }
                }
                .navigationTitle("Map Annotation with name")
            }
        }
        .navigationBarTitleDisplayMode(.inline)


    }
}

struct MapKitView_Previews: PreviewProvider {
    static var previews: some View {
        NavigationView {
            MapKitView()
        }
    }
}

struct MapLocation: Identifiable {
    let id = UUID()
    let name: String
    let coordinate: CLLocationCoordinate2D
}
