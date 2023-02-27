//
//  A11yApp.swift
//  A11y
//
//  Created by Lippmann, Erik on 22.02.23.
//

import SwiftUI

@main
struct A11yApp: App {
    var body: some Scene {
        WindowGroup {
            NavigationView {
                List {
                    Section("Preparations") {
                        NavigationLink("Labels") {
                            A11yLabelsView()
                        }
                    }
                }
            }

        }
    }
}
