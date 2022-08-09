//
//  CodableView.swift
//  Moonshot
//
//  Created by Lippmann, Erik on 05.08.22.
//

import SwiftUI

struct User: Codable {
    let name: String
    let address: Address
}

struct Address: Codable {
    let street: String
    let city: String
}

struct CodableView: View {
    var body: some View {
        Button("Decode JSON") {
            let input = """
            {
                "name": "Taylor Swift",
                "address": {
                        "street": "55, Taylor Swift Avenue",
                        "city": "Nashville"
                }
            }
            """

            let data = Data(input.utf8)

            if let user = try? JSONDecoder().decode(User.self, from: data) {
                print(user.address.street)
            }
        }
    }
}

struct CodableView_Previews: PreviewProvider {
    static var previews: some View {
        CodableView()
    }
}
