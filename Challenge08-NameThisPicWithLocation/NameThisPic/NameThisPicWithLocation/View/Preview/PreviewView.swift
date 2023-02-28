//
//  PreviewView.swift
//  NameThisPic
//
//  Created by Lippmann, Erik on 27.02.23.
//

import MapKit
import SwiftUI

struct PreviewView: View {

    @Environment(\.dismiss) private var dismiss

    let image: Image
    let name: String
    let location: Location

    @State private var mapRegion: MKCoordinateRegion

    init(image: Image, name: String, location: Location) {
        self.image = image
        self.name = name
        self.location = location

        _mapRegion = State(initialValue: MKCoordinateRegion(center: CLLocationCoordinate2D(latitude: location.latitude, longitude: location.longitude),
                                                            span: MKCoordinateSpan(latitudeDelta: 0.5, longitudeDelta: 0.5)))
    }

    var body: some View {
        NavigationView {
            VStack(spacing: 24) {
                image
                    .resizable()
                    .aspectRatio(contentMode: .fit)

                Map(coordinateRegion: $mapRegion, annotationItems: [location]) { annotation in
                    MapAnnotation(coordinate: location.coordinate) {
                        MapPin()
                    }
                }
                Spacer()
            }
            .padding(.horizontal, 16)
            .navigationTitle(name)
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {
                Button {
                    dismiss()
                } label: {
                    Image(systemName: "xmark")
                        .tint(.black)
                }
            }
        }
    }
}

struct PreviewView_Previews: PreviewProvider {
    static var previews: some View {
        PreviewView(image: Image("kevin-horstmann-141705"), name: "Flowers", location: Location.example)
    }
}
