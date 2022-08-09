//
//  MissionView.swift
//  Moonshot
//
//  Created by Lippmann, Erik on 08.08.22.
//

import SwiftUI

struct MissionView: View {
    let mission: Mission
    let crew: [CrewMember]

    var body: some View {
        GeometryReader { geometry in
            ScrollView {
                VStack {
                    Image(mission.image)
                        .resizable()
                        .scaledToFit()
                        .frame(maxWidth: geometry.size.width * 0.6)
                        .padding([.vertical])

                    Text("Launched: \(mission.formattedLaunchDate)")
                        .font(.title3.bold())

                    VStack(alignment: .leading) {
                        DividerView(color: .lightBackground)

                        Text("Mission Hightlights")
                            .font(.title.bold())
                            .padding(.bottom, 5)

                        Text(mission.description)

                        DividerView(color: .lightBackground)

                        CrewScrollView(crew: crew)
                    }
                    .padding(.horizontal)

                }
                .padding(.bottom)
            }
        }
        .navigationTitle(mission.displayName)
        .navigationBarTitleDisplayMode(.inline)
        .background(.darkBackground)
    }

    init(mission: Mission, astronauts: [String: Astronaut]) {
        self.mission = mission

        self.crew = mission.crew.map { member in
            guard let astronaut = astronauts[member.name] else {
                fatalError("Could not find astronaut.")
            }

            return CrewMember(role: member.role, astronaut: astronaut)
        }
    }
}

struct MissionView_Previews: PreviewProvider {
    static let missions: [Mission] = Bundle.main.decode("missions.json")
    static let astronauts: [String: Astronaut] = Bundle.main.decode("astronauts.json")

    static var previews: some View {
        MissionView(mission: missions[1], astronauts: astronauts)
            .preferredColorScheme(.dark)
    }
}
