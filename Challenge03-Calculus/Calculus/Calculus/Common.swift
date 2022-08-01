//
//  Constants.swift
//  Calculus
//
//  Created by Lippmann, Erik on 24.07.22.
//


import SwiftUI

enum Constants {
    static let colors: [Color] = [.primary, .secondary,
                                  .yellow, .red, .blue,
                                  .orange, .cyan, .brown,
                                  .green, .indigo, .mint,
                                  .pink, .purple, .orange]
    static let bubbleSize = 60.0
    static let bubbleRange = 2..<13
    static let questionRange = 3...12.0
}

struct Common {
    struct BubbleView: View {
        let text: String
        let color: Color
        var onTap: (() -> Void)?

        init(text: String, color: Color, onTap: (() -> Void)? = nil) {
            self.text = text
            self.color = color
            self.onTap = onTap
        }

        var body: some View {
            ZStack {
                Circle()
                    .fill(color)
                    .shadow(radius: 1.0)

                Text(text)
                    .foregroundColor(.white)
                    .font(.title)
                    .fontWeight(.bold)
                    .shadow(radius: 1)
            }
            .onTapGesture {
                onTap?()
            }
        }
    }
}
