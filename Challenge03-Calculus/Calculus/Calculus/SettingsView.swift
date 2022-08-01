//
//  SettingsView.swift
//  Calculus
//
//  Created by Lippmann, Erik on 22.07.22.
//

import SwiftUI

struct SettingsView: View {

    @State private var numberOfQuestions = Constants.questionRange.lowerBound
    @State private var selectedBubble = 0

    @State private var rotationAngles: [Int: Double] = [:]

    let onButtonTap: (_ table: Int, _ questions: Int) -> Void

    var body: some View {
        VStack(spacing: 16) {
            Text("Welcome to Calculus")
                .multilineTextAlignment(.center)
                .font(.largeTitle)
                .fontWeight(.bold)
                .frame(height: 50)


                VStack(spacing: 8) {
                    Text("Select a Multiplication Table")
                        .font(.title2)
                        .multilineTextAlignment(.center)
                        .padding(EdgeInsets(top: 0, leading: 0, bottom: 8, trailing: 0))
                    HStack {
                        ForEach(2..<7) { bubble in
                            ZStack {
                                Circle()
                                    .fill(selectedBubble == 0 ? Constants.colors[bubble] : selectedBubble == bubble ? Constants.colors[bubble] : .secondary)
                                    .shadow(radius: selectedBubble == bubble ? 6.0 : 1.0)
                                    .opacity(selectedBubble == bubble ? 1.0 : selectedBubble == 0 ? 1.0 : 0.4)

                                Text("\(bubble)")
                                    .foregroundColor(.white)
                                    .font(selectedBubble == bubble ? .largeTitle : .title)
                                    .fontWeight(.bold)
                                    .shadow(color: .white, radius: selectedBubble == bubble ? 1 : 0)
                            }
                            .onTapGesture { bubbleTapped(bubble) }
                            .scaleEffect(selectedBubble == bubble ? 1.2 : selectedBubble == 0 ? 1.0 : 0.8)
                            .rotation3DEffect(.degrees(rotationAngles[bubble] ?? 0),
                                              axis: (x: 0, y: 1, z: 0))
                        }
                    }
                    .padding(EdgeInsets(top: 0, leading: 24, bottom: 8, trailing: 24))

                    HStack {
                        ForEach(8..<13) { bubble in
                            ZStack {
                                Circle()
                                    .fill(selectedBubble == 0 ? Constants.colors[bubble] : selectedBubble == bubble ? Constants.colors[bubble] : .secondary)
                                    .shadow(radius: selectedBubble == bubble ? 6.0 : 1.0)
                                    .opacity(selectedBubble == bubble ? 1.0 : selectedBubble == 0 ? 1.0 : 0.4)

                                Text("\(bubble)")
                                    .foregroundColor(.white)
                                    .font(selectedBubble == bubble ? .largeTitle : .title)
                                    .fontWeight(.bold)
                                    .shadow(color: .white, radius: selectedBubble == bubble ? 1 : 0)
                            }
                            .onTapGesture { bubbleTapped(bubble) }
                            .scaleEffect(selectedBubble == bubble ? 1.2 : selectedBubble == 0 ? 1.0 : 0.8)
                            .rotation3DEffect(.degrees(rotationAngles[bubble] ?? 0),
                                              axis: (x: 0, y: 1, z: 0))
                        }
                    }
                    .padding(EdgeInsets(top: 0, leading: 24, bottom: 16, trailing: 24))
                }

                if selectedBubble != 0 {
                    VStack {
                        VStack(spacing: 8) {
                            Text("How many calculations to you want?")
                                .font(.title2)

                            Slider(value: $numberOfQuestions,
                                   in: Constants.questionRange,
                                   step: 1) {
                                Text("Select the number questions.")
                            } minimumValueLabel: {
                                Text("Min. \(Constants.questionRange.lowerBound.formatted())")
                                    .font(.caption)
                            } maximumValueLabel: {
                                Text("Max. \(Constants.questionRange.upperBound.formatted())")
                                    .font(.caption)
                            }
                            .padding(EdgeInsets(top: 0, leading: 24, bottom: 0, trailing: 24))

                            Text("Let‘s do \(numberOfQuestions.formatted()) questions!")
                                .font(.title2)
                        }

                        Button("Start Game") {
                            onButtonTap(selectedBubble,
                                        Int(numberOfQuestions))
                        }
                            .font(.title)
                            .fontWeight(.bold)
                            .foregroundColor(.white)
                            .padding()
                            .background {
                                LinearGradient(colors: [Color(red: 0.3, green: 0.7, blue: 0.3),
                                                        Color(red: 0.3, green: 0.9, blue: 0.3)], startPoint: .topLeading, endPoint: .bottomTrailing)
                            }
                            .clipShape(RoundedRectangle(cornerRadius: 20))
                            .shadow(radius: 2.0)
                    }
                }

            Spacer()
        }
    }

    func bubbleTapped(_ bubble: Int) {
        if selectedBubble == bubble {
            withAnimation {
                selectedBubble = 0
            }
        } else {
            withAnimation {
                selectedBubble = bubble
                if rotationAngles[bubble] == nil {
                    rotationAngles[bubble] = 360
                } else {
                    rotationAngles[bubble]? += 360
                }
            }
        }
    }
}

struct SettingsView_Previews: PreviewProvider {
    static var previews: some View {
        SettingsView(onButtonTap: { table, questions in })
    }
}
