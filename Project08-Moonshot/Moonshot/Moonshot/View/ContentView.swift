//
//  ContentView.swift
//  Moonshot
//
//  Created by Lippmann, Erik on 05.08.22.
//

import SwiftUI

struct ContentView: View {
    let astronauts: [String: Astronaut] = Bundle.main.decode("astronauts.json")
    let missions: [Mission] = Bundle.main.decode("missions.json")

    @State private var showingGrid = true

    var body: some View {
        NavigationView {
            Group {
                if showingGrid {
                    ScrollView {
                        GridView(missions: missions, astronauts: astronauts)
                    }
                } else {
                    ListView(missions: missions, astronauts: astronauts)
                }
            }
            .asHeadline("Moonshot")
            .toolbar {
                Button {
                    showingGrid.toggle()
                } label: {
                    if showingGrid {
                        Image(systemName: "list.bullet")
                    } else {
                        Image(systemName: "square.grid.2x2")
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


