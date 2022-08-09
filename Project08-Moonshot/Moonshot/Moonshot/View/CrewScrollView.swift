//
//  CrewScrollView.swift
//  Moonshot
//
//  Created by Lippmann, Erik on 08.08.22.
//

import SwiftUI

struct CrewScrollView: View {
    let crew: [CrewMember]
    
    var body: some View {
        VStack(alignment: .leading) {
            Text("Mission crew")
                .font(.title.bold())
                .padding(.bottom, 5)
                .padding(.horizontal)

            ScrollView(.horizontal, showsIndicators: false) {
                HStack {
                    ForEach(crew, id: \.role) { crew in
                        NavigationLink {
                            AstronautView(astronaut: crew.astronaut)
                        } label: {
                            HStack {
                                Image(crew.astronaut.id)
                                    .resizable()
                                    .frame(width: 104, height: 72)
                                    .clipShape(Capsule())
                                    .overlay {
                                        Capsule()
                                            .strokeBorder(.white, lineWidth: 1)
                                    }

                                VStack(alignment: .leading) {
                                    Text(crew.astronaut.name)
                                        .foregroundColor(.white)
                                        .font(.headline)

                                    Text(crew.role)
                                        .foregroundColor(.secondary)
                                }
                            }
                            .padding(.horizontal)
                        }
                    }
                }
            }
        }
    }
}

struct CrewScrollView_Previews: PreviewProvider {
    static let crew: [CrewMember] = [CrewMember(role: "Commander", astronaut: Astronaut(id: "armstrong", name: "Neil A. Armstrong", description: "Neil A. Armstrong")),
                                    CrewMember(role: "Secondary", astronaut: Astronaut(id: "collins", name: "Michaal Collins", description: "Michaal Collins"))]

    static var previews: some View {
        CrewScrollView(crew: crew)
            .background(.darkBackground)
            .preferredColorScheme(.dark)
    }
}
