//
//  ContentView.swift
//  WordScramble
//
//  Created by Lippmann, Erik on 11.07.22.
//

import SwiftUI

struct ContentView: View {
    @State private var usedWords: [String] = []
    @State private var rootWord = ""
    @State private var newWord = ""

    @State private var errroTitle = ""
    @State private var errorMessage = ""
    @State private var showingError = false

    @State private var score = 0

    var body: some View {
        NavigationView {
            VStack (spacing: 16) {
                Text("Welcome to Word Scrable. Your goal is to create new original real existing English words from the root word. Good luck. ")
                    .padding()
                List {
                    Section("Root word") {
                        Text(rootWord)
                    }

                    Section("Your word") {
                        TextField("Enter your word", text: $newWord)
                            .autocapitalization(.none)
                            .autocorrectionDisabled()
                    }

                    Section("Score") {
                        Text(score.formatted())
                    }

                    Section("Already used words") {
                        ForEach(usedWords, id: \.self) { word in
                            HStack {
                                Image(systemName: "\(word.count).circle")
                                Text(word)
                            }
                        }
                    }
                }
                .listStyle(.grouped)
                .navigationTitle("Word Scrable")
                .onSubmit(addNewWord)
                .onAppear(perform: reset)
                .alert(errroTitle, isPresented: $showingError) {
                    Button("OK", role: .cancel) { }
                } message: {
                    Text(errorMessage)
                }
                .toolbar {
                    Button("Reset", action: reset)
                }
            }
        }
    }

    func addNewWord() {
        let answer = newWord.lowercased().trimmingCharacters(in: .whitespacesAndNewlines)
        guard answer.count > 2 else {
            wordError(title: "Word too short", message: "The word must at least be three letters long!")
            return
        }

        guard isOriginal(word: answer) else {
            wordError(title: "Word used already", message: "Be more original!")
            return
        }

        guard isPossible(word: answer) else {
            wordError(title: "Word is not possible", message: "You can't spell that word from '\(rootWord)'")
            return
        }

        guard isReal(word: answer) else {
            wordError(title: "Word not recognized", message: "You can‘t make them up, you know!")
            return
        }

        withAnimation {
            usedWords.insert(answer, at: 0)
        }

        addScore(for: newWord)
        newWord = ""
    }

    func reset() {
        if let startWordURL = Bundle.main.url(forResource: "start", withExtension: "txt"),
           let startWords = try? String(contentsOf: startWordURL) {
            let allWords = startWords.components(separatedBy: "\n")
            rootWord = allWords.randomElement() ?? "silkworm"
            usedWords = []
            newWord = ""
            score = 0
            return
        }

        fatalError("Could not load start.txt from bundle.")
    }

    func isOriginal(word: String) -> Bool {
        !usedWords.contains(word) && word != rootWord
    }

    func isPossible(word: String) -> Bool {
        var tempWord = rootWord

        for letter in word {
            if let pos = tempWord.firstIndex(of: letter) {
                tempWord.remove(at: pos)
            } else {
                return false
            }
        }

        return true
    }

    func isReal(word: String) -> Bool {
        let checker = UITextChecker()
        let range = NSRange(location: 0, length: word.utf16.count)
        let misspelledRange = checker.rangeOfMisspelledWord(in: word, range: range, startingAt: 0, wrap: false, language: "en")

        return misspelledRange.location == NSNotFound
    }

    func wordError(title: String, message: String) {
        errroTitle = title
        errorMessage = message
        showingError = true
    }

    func addScore(for word: String) {
        let wordScore = (word.count + usedWords.count) / 2
        score += wordScore
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
