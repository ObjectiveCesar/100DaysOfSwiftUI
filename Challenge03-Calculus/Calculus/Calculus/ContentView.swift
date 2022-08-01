//
//  ContentView.swift
//  Calculus
//
//  Created by Lippmann, Erik on 19.07.22.
//

import SwiftUI



struct ContentView: View {

    @State private var isSettingUp = true

    @State private var numberOfQuestions = 3
    @State private var selectedTable = 2

    @State private var enteredText: String = ""
    @State private var usedQuestions: [(Int, Int)] = []

    let possibleFactors = 2...12
    @State var currentFactor = 2

    var body: some View {
        if isSettingUp {
            SettingsView { table, questions in
                withAnimation {
                    selectedTable = table
                    numberOfQuestions = questions
                    isSettingUp = false
                }
            }
        } else {
            GameView(selectedTable: selectedTable, maxRounds: numberOfQuestions) {
                withAnimation {
                    isSettingUp = true
                    selectedTable = 2
                    numberOfQuestions = 3
                }
            }
        }
    }

    func question(for table: Int) -> (first: Int, second: Int) {
        var pair: (Int, Int) = (table, possibleFactors.randomElement() ?? table)

        while (usedQuestions.contains { $0 == pair }) {
            pair = (table, possibleFactors.randomElement() ?? table)
        }

        return pair
    }

    func possibleAnswers(table: Int) -> [Int] {
        var answers: [Int] = []
        for factor in 1...12 {
            answers.append(factor * table)
        }

        return answers
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
