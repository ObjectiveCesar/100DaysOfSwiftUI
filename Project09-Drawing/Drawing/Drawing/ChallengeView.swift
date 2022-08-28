//
//  ChallengeVIew.swift
//  Drawing
//
//  Created by Lippmann, Erik on 13.08.22.
//

import SwiftUI

struct ChallengeView: View {
    @State private var lineWith = 10.0
    @State private var dimensions = 200.0
    var body: some View {
        ArrowShape(lineWidth: lineWith)
            .frame(width: dimensions, height: dimensions)
            .onTapGesture {
                withAnimation {
                    dimensions = Double.random(in: 100...300)
                    lineWith = Double.random(in: dimensions/5...dimensions/3)
                }
            }
    }
}

struct ChallengeView_Previews: PreviewProvider {
    static var previews: some View {
        ChallengeView()
    }
}
