//
//  Picture.swift
//  NameThisPic
//
//  Created by Lippmann, Erik on 23.02.23.
//

import Foundation

struct NamedPicture: Codable {
    let name: String
    let displayName: String
    let location: Location
}

extension NamedPicture: Comparable {
    static func < (lhs: NamedPicture, rhs: NamedPicture) -> Bool {
        lhs.name < rhs.name
    }
}
