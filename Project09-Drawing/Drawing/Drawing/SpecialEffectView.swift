//
//  SpecialEffectView.swift
//  Drawing
//
//  Created by Lippmann, Erik on 13.08.22.
//

import SwiftUI

struct SpecialEffectView: View {
    var body: some View {
//        MultiplyView()
//        ScreenView()
        BlurrSaturationView()
    }
}

struct MultiplyView: View {
    var body: some View {
        VStack {
            ZStack {
                Image("PaulHudson")

                Rectangle()
                    .fill(.red)
                    .blendMode(.multiply)
            }
            .frame(width: 400, height: 500)
            .clipped()

            // Modifier `colorMultiply` same as ZStack above
            Image("PaulHudson")
                .frame(width: 400, height: 500)
                .clipped()
                .colorMultiply(.red)
        }
    }
}

struct ScreenView: View {
    @State private var amount = 0.0

    var body: some View {
        VStack {
            ZStack {
                Circle()
//                    .fill(.red) // Adaptive color red
                    .fill(Color(red: 1, green: 0, blue: 0)) // Real color red
                    .frame(width: 200 * amount)
                    .offset(x: -50, y: -80)
                    .blendMode(.screen)

                Circle()
//                    .fill(.green) // Adaptive color green
                    .fill(Color(red: 0, green: 1, blue: 0)) // Real color green
                    .frame(width: 200 * amount)
                    .offset(x: 50, y: -80)
                    .blendMode(.screen)

                Circle()
//                    .fill(.blue) // Adaptive color blue
                    .fill(Color(red: 0, green: 0, blue: 1)) // Real color blue
                    .frame(width: 200 * amount)
                    .blendMode(.screen)
            }
            .frame(width: 300, height: 300)

            Slider(value: $amount)
                .padding()
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .background(.black)
        .ignoresSafeArea()
    }
}

struct BlurrSaturationView: View {
    @State private var amount = 0.0
    var body: some View {
        VStack {
            Image("PaulHudson")
                .resizable()
                .scaledToFit()
                .frame(width: 200, height: 200)
                .saturation(amount)
                .blur(radius: (1 - amount) * 20)

            Slider(value: $amount)
                .padding()
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .background(.black)
        .ignoresSafeArea()
    }
}

struct SpecialEffectView_Previews: PreviewProvider {
    static var previews: some View {
        SpecialEffectView()
    }
}
