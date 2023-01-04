//
//  Friend.swift
//  Friends
//
//  Created by Lippmann, Erik on 21.12.22.
//

import Foundation

struct Friend: Codable, Identifiable {
    enum CodingKeys: CodingKey {
        case id, name
    }

    let id: String
    let name: String
}
