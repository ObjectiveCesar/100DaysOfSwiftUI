//
//  ContentView.swift
//  CupcakeCorner
//
//  Created by Lippmann, Erik on 16.10.22.
//

import SwiftUI

struct ContentView: View {
    var body: some View {
        NavigationView {
            List {
                NavigationLink("Preparations") {
                    List {
                        NavigationLink("Codable @Published") {
                            CodablePublishedProperty()
                        }
                        
                        NavigationLink("Loading from Itunes API") {
                            LoadingFromItunesAPI()
                        }

                        NavigationLink("Async Image") {
                            AsyncImages()
                        }

                        NavigationLink("Phased Loading") {
                            PhasedLoading()
                        }
                    }
                }
            }
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
