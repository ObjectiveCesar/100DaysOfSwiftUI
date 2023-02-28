//
//  Location.swift
//  NameThisPicWithLocation
//
//  Created by Lippmann, Erik on 28.02.23.
//

import Foundation
import MapKit

struct Location: Identifiable, Codable {
    let id: UUID
    let latitude: Double
    let longitude: Double

    var coordinate: CLLocationCoordinate2D {
        CLLocationCoordinate2D(latitude: latitude, longitude: longitude)
    }

    init(id: UUID = UUID(), latitude: Double, longitude: Double) {
        self.id = id
        self.latitude = latitude
        self.longitude = longitude
    }
}

extension Location: Equatable {
    static func ==(lhs: Location, rhs: Location) -> Bool {
        lhs.latitude == rhs.latitude && lhs.longitude == rhs.longitude
    }
}

extension Location {
    static let example = Location(latitude: 51.501, longitude: -0.141)
}
