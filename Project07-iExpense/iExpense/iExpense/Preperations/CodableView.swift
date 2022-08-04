//
//  CodableView.swift
//  iExpense
//
//  Created by Lippmann, Erik on 01.08.22.
//

import SwiftUI

struct CodableView: View {

    struct User: Codable {
        let firstName: String
        let lastName: String
    }

    @State private var user = User(firstName: "Taylor", lastName: "Swift")

    var body: some View {
        Form {
            Section("JSON Encode") {
                Button("Tap Me!") {
                    let encoder = JSONEncoder()

                    if let data = try? encoder.encode(user) {
                        UserDefaults.standard.set(data, forKey: "UserData")
                    }

                    // Restart app to see changes in saved data.
                }
            }

            Section("JSON Decode") {
                let decoder = JSONDecoder()

                if let data = UserDefaults.standard.data(forKey: "UserData"), let user = try? decoder.decode(User.self, from: data) {
                    Text("First name: \(user.firstName) \nLast name: \(user.lastName)")
                }

            }
        }
    }
}

struct CodableView_Previews: PreviewProvider {
    static var previews: some View {
        CodableView()
    }
}
