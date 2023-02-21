//
//  ContentView.swift
//  BucketList
//
//  Created by Lippmann, Erik on 08.02.23.
//

import SwiftUI

struct ContentView: View {
    var body: some View {
        NavigationView {
            List {
                Section("Preparations") {
                    NavigationLink("Comparable View") {
                        ComparableView()
                    }

                    NavigationLink("View State Switch") {
                        ViewStateSwitch()
                    }

                    NavigationLink("MapKit View") {
                        MapKitView()
                    }

                    NavigationLink("Biometric Auth View") {
                        BiometricAuthView()
                    }
                }

                Section("Project") {
                    NavigationLink("Bucket List") {
                        BucketListView()
                    }
                }
            }
            .navigationTitle("Project 13")
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
