//
//  FriendsApp.swift
//  Friends
//
//  Created by Lippmann, Erik on 21.12.22.
//

import SwiftUI

@main
struct FriendsApp: App {
    var body: some Scene {
        WindowGroup {
            ContentView(usersService: UsersService())
        }
    }
}
