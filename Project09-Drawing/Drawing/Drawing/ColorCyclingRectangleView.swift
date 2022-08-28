//
//  ColorCyclingRectangleView.swift
//  Drawing
//
//  Created by Lippmann, Erik on 28.08.22.
//

import SwiftUI

struct ColorCyclingRectangle: View {
    var startPoint: UnitPoint = .top
    var endPoint: UnitPoint = .bottom
    var amount = 0.0
    var steps = 100
    var cornerRadius = 0.0
    var lineWidth = 2.0
    var brightness = 0.5

    var body: some View {
        ZStack {
            ForEach(0..<steps) { value in
                RoundedRectangle(cornerRadius: cornerRadius)
                    .inset(by: Double(value))
                    .strokeBorder(
                        LinearGradient(
                            gradient: Gradient(colors: [
                                color(for: value, brightness: 1),
                                color(for: value, brightness: brightness)
                            ]),
                            startPoint: startPoint,
                            endPoint: endPoint
                        ),
                        lineWidth: lineWidth
                    )
            }
        }
        .drawingGroup() // Just wow, the performance differance!
    }

    func color(for value: Int, brightness: Double) -> Color {
        var targetHue = Double(value) / Double(steps) + amount

        if targetHue > 1 {
            targetHue -= 1
        }

        return Color(hue: targetHue, saturation: 1, brightness: brightness)
    }
}

struct ColorCyclingRectangleContentView: View {
    @State private var startX = 0.0
    @State private var startY = 0.0
    @State private var startPoint: UnitPoint = .top
    @State private var endPoint: UnitPoint = .bottom
    @State private var colorCycle = 0.0
    @State private var steps = 100.0
    @State private var cornerRadius = 0.0
    @State private var lineWidth = 2.0
    @State private var point: UnitPoint = .top
    @State private var brightness = 0.5

    var body: some View {
        VStack {
            ColorCyclingRectangle(startPoint: startPoint,
                                  endPoint: endPoint,
                                  amount: colorCycle,
                                  steps: Int(steps),
                                  cornerRadius: cornerRadius,
                                  lineWidth: lineWidth,
                                  brightness: brightness)
                .frame(width: 300, height: 300)
                .padding(.bottom)

            ScrollView {
                Group {
                    Text("Color Cycle")
                    Slider(value: $colorCycle)
                        .padding([.horizontal, .bottom])

                    Text("Steps")
                    Slider(value: $steps, in: 10...200, step: 1)
                        .padding([.horizontal, .bottom])

                    Text("Corner Radius")
                    Slider(value: $cornerRadius, in: 0...150, step: 1)
                        .padding([.horizontal, .bottom])

                    Text("Brightness")
                    Slider(value: $brightness, in: 0...1)
                        .padding([.horizontal, .bottom])

                    Text("Line Width")
                    Slider(value: $lineWidth, in: 2...20, step: 1)
                        .padding([.horizontal, .bottom])
                }

                Group {
                    Text("Start X")
                    Slider(value: $startPoint.x, in: 0...1)
                        .padding([.horizontal, .bottom])

                    Text("Start Y")
                    Slider(value: $startPoint.y, in: 0...1)
                        .padding([.horizontal, .bottom])

                    Text("End X")
                    Slider(value: $endPoint.x, in: 0...1)
                        .padding([.horizontal, .bottom])

                    Text("End Y")
                    Slider(value: $endPoint.y, in: 0...1)
                        .padding([.horizontal, .bottom])
                }
            }
        }
    }
}

struct ColorCyclingRectangleView_Previews: PreviewProvider {
    static var previews: some View {
        ColorCyclingRectangleContentView()
    }
}
