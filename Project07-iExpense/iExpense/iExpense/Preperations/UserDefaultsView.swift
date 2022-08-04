//
//  UserDefaultsView.swift
//  iExpense
//
//  Created by Lippmann, Erik on 01.08.22.
//

import SwiftUI

struct UserDefaultsView: View {
    @AppStorage("tapCount") private var appStorageTaps = 0
    @State private var userDefaultsTapCount = UserDefaults.standard.integer(forKey: "userDefaultsTapCount")

    var body: some View {
        VStack {
            Form {
                Section("@AppStorage") {
                    Button("\(appStorageTaps) taps stored") {
                        appStorageTaps += 1
                    }
                }

                Section ("UserDefaults") {
                    Button("\(userDefaultsTapCount) taps stored") {
                        userDefaultsTapCount += 1
                        UserDefaults.standard.set(userDefaultsTapCount, forKey: "userDefaultsTapCount")
                    }
                }
            }
        }
    }
}

struct UserDefaultsView_Previews: PreviewProvider {
    static var previews: some View {
        UserDefaultsView()
    }
}
