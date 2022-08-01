//
//  GameView.swift
//  Calculus
//
//  Created by Lippmann, Erik on 24.07.22.
//

import SwiftUI

struct GameView: View {
    let selectedTable: Int
    let maxRounds: Int
    let gameFinished: () -> Void

    @State private var currentRound: Int = 1
    @State private var correctAnswers: Int = 0

    @State private var currentFactor: Int = 2
    @State private var correct: Int = 0
    @State private var incorrect: [Int] = []
    @State private var options: [Int] = [1, 2, 3]
    @State private var rotationAngles: [Double] = [0, 0, 0]
    @State private var selectedBubble = -1
    @State private var bubbleColors: [Color] = [Constants.colors[5], Constants.colors[6], Constants.colors[7]]

    @State private var finished: Bool = false
    
    var body: some View {
        ZStack {
            if finished == false {
                VStack {
                    Text("Let’s calculate!")
                        .multilineTextAlignment(.center)
                        .font(.largeTitle)
                        .fontWeight(.bold)
                        .frame(height: 50)

                    Section {
                        HStack {
                            Text("What is")

                            Common.BubbleView(text: selectedTable.formatted(),
                                              color: Constants.colors[selectedTable])

                            Text(" x ")

                            Common.BubbleView(text: currentFactor.formatted(),
                                              color: Constants.colors[currentFactor])

                            Text("?")

                        }
                        .font(.title2)
                        .fontWeight(.bold)
                    }

                    Section("Choose the correct answer!") {
                        HStack {
                            ForEach(0..<3) { bubble in
                                let option = options[bubble]

                                Common.BubbleView(text: option.formatted(),
                                                  color: bubbleColors[bubble]) {
                                    bubbleTapped(bubble)
                                }
                                                  .rotation3DEffect(.degrees(rotationAngles[bubble]), axis: (x: 0, y: 1, z: 0))
                                                  .scaleEffect(selectedBubble == bubble ? 1.1 : selectedBubble == -1 ? 1.0 : 0.8)
                            }
                        }
                    }

                    if selectedBubble != -1 && finished == false {
                        let correct = options[selectedBubble] == correct
                        Button() {
                            nextGame(correct)
                        } label: {
                            ZStack {
                                RoundedRectangle(cornerRadius: 32)
                                    .frame(width: .infinity, height: 120)
                                    .foregroundColor(correct ? .green : .red)

                                VStack(spacing: 8) {
                                    Text(correct ? "Great, correct!" : "Sorry, wrong!")
                                        .foregroundColor(.white)
                                        .font(.title)
                                        .fontWeight(.bold)

                                    Text("Tap for \(currentRound == maxRounds ? "summery" : "next game.")")
                                        .foregroundColor(.white)
                                        .font(.caption)
                                }
                            }
                        }
                        .padding()

                    }

                    Spacer()

                    Section("Summary") {
                        VStack {
                            Text("You are playing round \(currentRound) of \(maxRounds)")
                        }
                        .font(.title2)
                    }
                }
                .padding(24)
                .onAppear {
                    prepareGame()
                }
            } else {
                Button {
                    gameFinished()
                } label: {
                    ZStack {
                        RoundedRectangle(cornerRadius: 32)
                            .frame(width: .infinity, height: .infinity)
                            .foregroundColor(.mint)

                        VStack(spacing: 16) {
                            Spacer()
                            Spacer()
                            Text("All done!")
                                .font(.largeTitle)
                                .fontWeight(.bold)

                            VStack(spacing: 8) {
                                Text("You did \(maxRounds) rounds.")
                                    .font(.body)
                                Text("You answered \(correctAnswers) correct.")
                                    .font(.body)
                                Text("\(maxRounds != correctAnswers ? "Keep practicing" : "Great work")!")
                                    .font(.body)
                            }

                            Spacer()
                            Spacer()
                            Text("Tap to set up a new game.")
                                .font(.caption)
                            Spacer()
                        }
                        .foregroundColor(.white)
                    }
                }
                .padding()
            }
        }
    }

    private func bubbleTapped(_ bubble: Int) {
        withAnimation {
            if selectedBubble != -1 {
                return
            } else {
                selectedBubble = bubble
                rotationAngles[bubble] += 360
                for index in 0..<3 {
                    if index != bubble {
                        bubbleColors[index] = .gray
                    }
                }
            }
        }
    }

    private func prepareGame() {
        withAnimation {
            currentFactor = Constants.bubbleRange.randomElement() ?? 2
            correct = selectedTable * currentFactor
            bubbleColors = randomColors()
        }

        selectedBubble = -1
        prepareOptions()
    }

    private func prepareOptions() {
        var array: [Int] = []
        for factor in 2...12 {
            array.append(selectedTable * factor)
        }

        incorrect = array.filter { $0 != correct }
            .shuffled()

        self.options = [incorrect.removeFirst(), correct, incorrect.removeFirst()].shuffled()
    }

    private func randomColors() -> [Color] {
        Constants.colors[2..<12]
            .shuffled()[0..<3]
            .shuffled()
    }

    private func nextGame(_ correct: Bool) {
        if correct {
            correctAnswers += 1
        }

        if currentRound != maxRounds {
            currentRound += 1
            prepareGame()
        } else {
            withAnimation(.linear(duration: 0.25)) {
                finished = true
            }
        }
    }
}

struct GameView_Previews: PreviewProvider {
    static var previews: some View {
        GameView(selectedTable: 5, maxRounds: 2) { }
    }
}
