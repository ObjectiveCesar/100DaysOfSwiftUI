//
//  ContentView.swift
//  RockPaperScissors
//
//  Created by Lippmann, Erik on 03.07.22.
//

import SwiftUI

struct Constants {

    enum Colors {
        static let red = Color(red: 0.46, green: 0.15, blue: 0.26)
        static let blue = Color(red: 0.1, green: 0.2, blue: 0.35)
        static let lightBlue = Color(red: 0.5, green: 0.75, blue: 1.0)
    }
}

struct ButtonShape: ViewModifier {

    let color: Color
    func body(content: Content) -> some View {
        content
            .frame(minWidth: 100, minHeight: 100)
            .foregroundColor(Constants.Colors.blue)
            .background(color)
            .background(.thinMaterial)
            .clipShape(RoundedRectangle(cornerRadius: 8))
            .shadow(radius: 4)
    }
}

extension View {

    func buttonShaped(color: Color = .indigo) -> some View {
        modifier(ButtonShape(color: color))
    }
}

struct ContentView: View {
    enum Option: String, CaseIterable {
        case rock, paper, scissors

        enum Result {
            case win, lose, draw
        }

        var imageName: String {
            switch self {
            case .rock:
                return "square"
            case .paper:
                return "newspaper"
            case .scissors:
                return rawValue
            }
        }

        var archEnemy: Option {
            switch self {
            case .rock:
                return .paper
            case .paper:
                return .scissors
            case .scissors:
                return.rock
            }
        }

        var action: String {
            switch self {
            case .rock:
                return "smash"
            case .paper:
                return "wrap"
            case .scissors:
                return "cut"
            }
        }

        func fightAgainst(_ enemy: Option) -> Result {
            switch (self, enemy) {
            case (_, archEnemy):
                return .lose
            case (enemy.archEnemy, _):
                return .win
            case (_, _):
                return .draw
            }
        }
    }

    @State private var selected: Option = .rock
    @State private var computerOption: Option = Option.allCases.randomElement() ?? .rock
    @State private var round = 1
    @State private var score = 0
    @State private var showAlert = false
    @State private var alertText = (title: "", message: "")
    @State private var shouldWin = Bool.random()
    @State private var gameOver = false

    private var maxRounds = 10

    var body: some View {
        ZStack {
            RadialGradient(stops: [
                .init(color: Constants.Colors.blue, location: 0.3),
                .init(color: Constants.Colors.red, location: 0.3),
            ], center: .top, startRadius: 400, endRadius: 700)
            .ignoresSafeArea()

            VStack(spacing: 24) {
                Spacer()
                VStack {
                    Text("Rock / Paper / Scissors")
                        .font(.largeTitle)
                        .foregroundColor(.white)
                        .padding()
                        .frame(maxWidth: 380)
                        .background(Constants.Colors.red)
                        .clipShape(RoundedRectangle(cornerRadius: 8))
                }

                VStack(spacing: 16) {
                    Text("Computer")
                        .font(.title)
                        .foregroundColor(.white)
                        .padding()
                        .clipShape(RoundedRectangle(cornerRadius: 4))

                    VStack(spacing: 0) {
                        Image(systemName: computerOption.imageName)
                            .dynamicTypeSize(.accessibility5)
                        Text(computerOption.rawValue.capitalized)
                            .font(.caption)
                    }
                    .buttonShaped(color: Constants.Colors.lightBlue)
                }
                .padding(24)
                .background(Constants.Colors.red.opacity(0.8))
                .backgroundStyle(.ultraThinMaterial)
                .clipShape(RoundedRectangle(cornerRadius: 8))

                Spacer()
                VStack {
                    Text("Choose the option that will make you \(shouldWin ? "win" : "lose")!".capitalized)
                        .multilineTextAlignment(.center)
                        .font(.title)
                        .foregroundColor(Constants.Colors.blue)
                        .padding()
                        .background(Constants.Colors.lightBlue)
                        .clipShape(RoundedRectangle(cornerRadius: 8))

                    HStack(spacing: 16) {
                        ForEach(Option.allCases,
                                id: \.self) { option in
                            Button {
                                select(option)
                            } label: {
                                VStack(spacing: 0) {
                                    Image(systemName: option.imageName)
                                        .dynamicTypeSize(.accessibility5)
                                    Text(option.rawValue.capitalized)
                                        .font(.caption)
                                }
                            }
                            .buttonShaped(color: Constants.Colors.lightBlue)
                        }
                    }
                    .padding()
                    .frame(maxWidth: 380)
                }

                VStack {
                    Text("Score: \(score)")
                    Text("Round \(round) of \(maxRounds)")
                }
                .font(.title)
                .foregroundColor(.white)

                Spacer()
                Spacer()
            }
            .frame(maxWidth: .infinity, maxHeight: .infinity)
            .padding()
        }
        .alert(alertText.title, isPresented: $showAlert) {
            Button("OK", action: shuffle)
        } message: {
            Text(alertText.message)
        }
        .alert("Game Over", isPresented: $gameOver) {
            Button("New Game", action: reset)
        } message: {
            Text("You've played the max number of \(maxRounds) rounds with a final score of \(score) points.")
        }
    }

    func select(_ option: Option) {
        let correct =
        shouldWin && option.fightAgainst(computerOption) == .win ||
        !shouldWin && option.fightAgainst(computerOption) == .lose

        score += correct ? 1 : 0

        let alertTitle = correct ? "Correct!" : "Wrong!"
        let alertMessage = "You did\(correct ? "" : " not") \(shouldWin ? "win" : "lose" ) this round as expected.\n Your current score is: \(score).\n \(maxRounds - round) more rounds to go."

        alertText = (title: alertTitle, message: alertMessage)
        showAlert = true
    }

    func shuffle() {
        if round == maxRounds {
            gameOver = true
        } else {
            round += 1
        }

        computerOption = Option.allCases.randomElement() ?? .rock
        shouldWin.toggle()
    }

    func reset() {
        round = 1
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
