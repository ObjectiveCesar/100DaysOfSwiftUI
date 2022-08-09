//
//  ListView.swift
//  Moonshot
//
//  Created by Lippmann, Erik on 08.08.22.
//

import SwiftUI

struct ListView: View {
    let missions: [Mission]
    let astronauts: [String: Astronaut]
    
    var body: some View {
        GeometryReader { geometry in
            List {
                ForEach(missions) { mission in
                    NavigationLink {
                        MissionView(mission: mission, astronauts: astronauts)
                    } label: {
                        HStack {
                            Image(mission.image)
                                .resizable() // Makes the view resizable
                                .scaledToFit()
                                .frame(width: 50)
                                .padding(8)

                            HStack {
                                Text(mission.displayName)
                                    .font(.headline)
                                    .foregroundColor(.white)

                                Text(mission.formattedLaunchDate)
                                    .font(.caption)
                                    .foregroundColor(.white.opacity(0.5))
                            }
                            .padding(.horizontal)

                            Spacer()
                        }
                        .frame(width: geometry.size.width * 0.8, height: 70)
                        .background(.lightBackground)
                        .clipShape(RoundedRectangle(cornerRadius: 10))
                        .overlay(
                            RoundedRectangle(cornerRadius: 10)
                                .stroke(.lightBackground)
                        )
                    }
                }
                .listRowBackground(Color.darkBackground)
            }
            .listStyle(.plain)
        }
    }
}

struct ListView_Previews: PreviewProvider {
    static let missons: [Mission] = Bundle.main.decode("missions.json")
    static let astronauts: [String: Astronaut] = Bundle.main.decode("astronauts.json")

    static var previews: some View {
        ListView(missions: missons, astronauts: astronauts)
            .background(.darkBackground)
            .preferredColorScheme(.dark)
    }
}
