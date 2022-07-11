//
//  ContentView.swift
//  GuessTheFlag
//
//  Created by Lippmann, Erik on 29.06.22.
//

import SwiftUI

struct TitleModifier: ViewModifier {

    let color: Color

    func body(content: Content) -> some View {
        content
            .foregroundColor(color)
            .font(.title.bold())
    }
}

struct LargeTitleModifier: ViewModifier {

    let color: Color

    func body(content: Content) -> some View {
        content
            .foregroundColor(color)
            .font(.largeTitle.bold())
    }
}

extension View {

    func asTitle(color: Color) -> some View {
        modifier(TitleModifier(color: color))
    }

    func asLargeTitle(color: Color) -> some View {
        modifier(LargeTitleModifier(color: color))
    }
}

struct FlagView: View {

    let name: String
    let number: Int

    let tapped: (Int) -> Void

    var body: some View {
        Button {
            tapped(number)
        } label: {
            Image(name)
                .renderingMode(.original)
                .clipShape(RoundedRectangle(cornerRadius: 5))
                .shadow(color: .secondary, radius: 25)
        }
    }
}

struct ContentView: View {

    @State private var showingScore = false
    @State private var scoreTitle = ""

    @State private var countries = ["Estonia", "France", "Germany", "Ireland", "Italy", "Nigeria", "Poland", "Russia", "Spain", "UK", "US"].shuffled()
    @State private var correctAnswer = Int.random(in: 0...2)
    @State private var score = 0

    var body: some View {
        ZStack {
            RadialGradient(stops: [
                .init(color: Color(red: 0.1, green: 0.2, blue: 0.35), location: 0.3),
                .init(color: Color(red: 0.46, green: 0.15, blue: 0.26), location: 0.3)
            ], center: .top, startRadius: 200, endRadius: 700)
            .ignoresSafeArea()

            VStack {
                Spacer()

                Text("Guess the Flag")
                    .asLargeTitle(color: .white)
                VStack(spacing: 15) {
                    VStack {
                        Text("Tap the flag of")
                            .foregroundStyle(.secondary)
                            .font(.subheadline.weight(.heavy))

                        Text(countries[correctAnswer])
                            .asLargeTitle(color: .primary)
                    }

                    ForEach(0..<3) { number in
                        FlagView(name: countries[number],
                                 number: number) {
                            flagTapped($0)
                        }
                    }
                }
                .frame(maxWidth: .infinity)
                .padding(.vertical, 20)
                .background(.regularMaterial)
                .clipShape(RoundedRectangle(cornerRadius: 20))
                .shadow(color: .secondary, radius: 10)

                Spacer()
                Spacer()

                Text("Score \(score)")
                    .asTitle(color: .white)

                Spacer()
            }
            .padding()
        }
        .alert(scoreTitle, isPresented: $showingScore) {
            Button("Continue", action: askQuestion)
        } message: {
            Text("Your score is \(score)")
        }
    }

    func flagTapped(_ number: Int) {
        if number == correctAnswer {
            scoreTitle = "Correct"
            score += 1
        } else {
            scoreTitle = "Wrong"
        }

        showingScore = true
    }

    func askQuestion() {
        countries = countries.shuffled()
        correctAnswer = Int.random(in: 0...2)
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
