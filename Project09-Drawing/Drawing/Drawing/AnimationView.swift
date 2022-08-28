//
//  AnimationView.swift
//  Drawing
//
//  Created by Lippmann, Erik on 13.08.22.
//

import SwiftUI

struct AnimationView: View {
    @State private var inset = 50.0

    var body: some View {
        Trapezoid(insetAmount: inset)
            .frame(width: 200, height: 100)
            .onTapGesture {
                withAnimation {
                    inset = Double.random(in: 10...90)
                }
            }
    }
}

struct AnimationView_Previews: PreviewProvider {
    static var previews: some View {
        AnimationView()
    }
}
