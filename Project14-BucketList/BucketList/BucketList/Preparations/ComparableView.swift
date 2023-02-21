//
//  ComparableView.swift
//  BucketList
//
//  Created by Lippmann, Erik on 08.02.23.
//

import SwiftUI

struct ComparableView: View {
    let values = [1, 5, 3, 6, 2, 9].sorted()
    let users = [
        User(firstName: "Arnold", lastName: "Rimmer"),
        User(firstName: "Kristine", lastName: "Kochanski"),
        User(firstName: "David", lastName: "Lister"),
    ].sorted()

    var body: some View {
        VStack {
            List(values, id: \.self) {
                Text(String($0))
            }

            List(users) { user in
                Text("\(user.lastName), \(user.firstName)")
            }

            Text("Tap Me!")
                .onTapGesture {
                    let str = "Test Message"
                    let url = getDocumentsDirectory().appendingPathComponent("message.txt")

                    do {
                        try str.write(to: url, atomically: true, encoding: .utf8)
                        let input = try String(contentsOf: url)
                        print(input)
                    } catch {
                        print(error.localizedDescription)
                    }
                }
        }
    }

    func getDocumentsDirectory() -> URL {
        // find all possible documents directories for this user
        let paths = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)

        // just send back the first one, which ought to be the only one
        return paths[0]
    }
}

struct ComparableView_Previews: PreviewProvider {
    static var previews: some View {
        ComparableView()
    }
}


struct User: Identifiable, Comparable {
    let id = UUID()
    let firstName: String
    let lastName: String

    static func <(lhs: User, rhs: User) -> Bool {
        lhs.lastName < rhs.lastName
    }
}
