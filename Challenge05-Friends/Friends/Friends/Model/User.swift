//
//  User.swift
//  Friends
//
//  Created by Lippmann, Erik on 21.12.22.
//

import Foundation

struct User: Codable, Identifiable {
    enum CodingKeys: CodingKey {
        case id, isActive, name, age, company, email, address, about, registered, tags, friends
    }

    let id: String
    let isActive: Bool
    let name: String
    let age: Int
    let company: String
    let email: String
    let address: String
    let about: String
    let registered: Date
    let tags: [String]
    let friends: [Friend]
}
