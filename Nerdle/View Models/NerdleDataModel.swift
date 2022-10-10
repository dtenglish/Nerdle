//
//  GameDataModel.swift
//  Nerdle
//
//  Created by Daniel Taylor English on 9/26/22.
//

import SwiftUI

class NerdleDataModel: ObservableObject {
    
    enum GameStatus {
        case inPlay, win, lose
    }
    
    @Published var gameStatus: GameStatus = .inPlay
    @Published var screenWidth: CGFloat = 0
    @Published var guesses: [Guess] = []
    @Published var keys: [String: KeyboardKey] = [:]
    @Published var alertMessage: String?
    @Published var showStats = false
    
    var wordQueue: [String] = []
    var completedWords: [String] = []
    var correctLetters: [String] = []
    var misplacedLetters: [String] = []
    var incorrectLetters: [String] = []
    var stats: Stats = Stats()
    
    var currentSolution = ""
    var currentGuess = ""
    var rowIndex = 0
    var isFlipping = false
    
    let letters = "ABCDEFGHIJKLMNOPQRSTUVWXYZ".map { String($0) }
    let topRowLetters = "QWERTYUIOP".map { String($0) }
    let middleRowLetters = "ASDFGHJKL".map { String($0) }
    let bottomRowLetters = "ZXCVBNM".map { String($0) }
    
    var scaleFactor: CGFloat {
        switch screenWidth {
        case 0...743:
            return screenWidth / 390
        case 744...1023:
            return 1.5
        default:
            return 1.8
        }
    }
    
    init() {
        wordQueue = generateWordList()
        newGame()
        populateKeys()
    }
    
    func newGame() {
        resetToDefaults()
        
        if currentSolution != "" {
            completedWords.append(currentSolution)
        }
        
        currentSolution = getNextWord()
        
        while completedWords.contains(currentSolution) {
            currentSolution = getNextWord()
        }
        
        gameStatus = .inPlay
    }
    
    func resetToDefaults() {
        guesses = []
        correctLetters = []
        misplacedLetters = []
        incorrectLetters = []
        rowIndex = 0
        currentGuess = ""
        alertMessage = nil
        
        for i in 0...5 {
            guesses.append(Guess(index: i))
        }
        
        for (key, _) in keys {
            keys[key]?.color = .unused
            keys[key]?.isDisabled = false
        }
        
        keys["ENTER"]?.isDisabled = true
        keys["BACKSPACE"]?.isDisabled = true
        
    }
    
}

//MARK: - KEYBOARD

extension NerdleDataModel {

    func populateKeys() {
        for letter in letters {
            keys[letter] = (KeyboardKey(key: letter) {
                self.keyPressed(letter)
            })
        }
        
        keys["ENTER"] = (KeyboardKey(key: "ENTER", isDisabled: true) {
            self.keyPressed("ENTER")
        })
        
        keys["BACKSPACE"] = (KeyboardKey(key: "BACKSPACE", isDisabled: true) {
            self.keyPressed("BACKSPACE")
        })
    }
    
    func keyPressed(_ key: String) {
        if !isFlipping {
            switch key {
            case "ENTER": enterWord()
            case "BACKSPACE": backspace()
            default: addLetter(key)
            }
            
            updateKeyboard()
        }
    }
    
    func updateKeyboard() {
        if currentGuess.count > 0 {
            keys["BACKSPACE"]?.isDisabled = false
        } else {
            keys["BACKSPACE"]?.isDisabled = true
        }
        if currentGuess.count == 5 {
            keys["ENTER"]?.isDisabled = false
        } else {
            keys["ENTER"]?.isDisabled = true
        }
    }
    
    func updateKeyColors() {
        for letter in incorrectLetters {
            keys[letter]?.color = .incorrect
        }
        
        for letter in misplacedLetters {
            keys[letter]?.color = .misplaced
        }
        
        for letter in correctLetters {
            keys[letter]?.color = .correct
        }
    }
    
    func disableLetters() {
        for letter in incorrectLetters {
            keys[letter]?.isDisabled = true
        }
    }
    
}

//MARK: - WORD LIST

extension NerdleDataModel {
    
    func checkForUserData() {
        // user data check
    }
    
    func generateWordList() -> [String] {
        var userWordList = wordList
        
        userWordList.shuffle()
        
        return userWordList
    }
    
    func getNextWord() -> String {
        if let nextWord = wordQueue.popLast() {
            return nextWord
        } else {
            print("error retrieving next word")
            return ""
        }
    }
    
}

//MARK: - GAMEPLAY

extension NerdleDataModel {
    
    func addLetter(_ letter: String) {
        if currentGuess.count < 5 {
            currentGuess.append(letter)
            updateRow()
        }
    }

    func backspace() {
        if currentGuess.count > 0 {
            currentGuess.removeLast()
            updateRow()
        }
    }

    func enterWord() {
        if currentGuess.count == 5 {
            if verifyWord() {
                checkLetters()
                updateGameUI()
                checkGameStatus()
                
            } else {
                withAnimation {
                    guesses[rowIndex].shake = 1
                }
                guesses[rowIndex].shake = 0
                showAlert(message: "Not in word list")
            }
        }
    }
    
    func checkGameStatus() {
        if currentGuess == currentSolution {
            stats.totalGames += 1
            stats.wins[rowIndex] += 1
            stats.currentStreak += 1
            if stats.currentStreak > stats.highestStreak {
                stats.highestStreak = stats.currentStreak
            }
            gameStatus = .win
        } else if rowIndex == 5 {
            stats.totalGames += 1
            stats.currentStreak = 0
            gameStatus = .lose
        } else {
            rowIndex += 1
            currentGuess = ""
        }
    }
    
    func verifyWord() -> Bool {
        UIReferenceLibraryViewController.dictionaryHasDefinition(forTerm: currentGuess)
    }
    
    func checkLetters() {
        var solutionLetters = currentSolution.map { String($0) }
        let guessLetters = guesses[rowIndex].guessLetters
        
        incorrectLetters += guessLetters.filter{ !solutionLetters.contains($0) }
        
        for i in 0...4 {
            let guessLetter = guessLetters[i]
            
            if guessLetter == solutionLetters[i] {
                guesses[rowIndex].letterStatus[i] = .correct
                solutionLetters[i] = ""
                if !correctLetters.contains(guessLetter) {
                    correctLetters.append(guessLetter)
                }
            } else if solutionLetters.contains(guessLetter) {
                guesses[rowIndex].letterStatus[i] = .misplaced
                if !misplacedLetters.contains(guessLetter) {
                    misplacedLetters.append(guessLetter)
                }
            } else {
                guesses[rowIndex].letterStatus[i] = .incorrect
            }
        }
        
        print("solution: " + currentSolution)
        print("guess: " + currentGuess)
    }
    
    func updateRow() {
        let rowLetters = currentGuess.padding(toLength: 5, withPad: " ", startingAt: 0)
        guesses[rowIndex].word = rowLetters
    }
    
}

//MARK: - UI

extension NerdleDataModel {
    
    func updateGameUI() {
        isFlipping = true
        flipCards(row: rowIndex)
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 1.5) { [self] in
            isFlipping = false
            updateKeyColors()
            if gameStatus != .inPlay
            {
                if gameStatus == .win {
                    showAlert(message: "Correct guess, you win!")
                    bounceCards(row: rowIndex)
                } else if gameStatus == .lose {
                    showAlert(message: "Out of guesses, you lose")
                    DispatchQueue.main.asyncAfter(deadline: .now() + 2) { [self] in
                        showAlert(message: "Solution: " + currentSolution)
                    }
                }
                
                withAnimation(Animation.linear(duration: 0.2).delay(gameStatus == .lose ? 4 : 2)) {
                    showStats = true
                }
            }
        }
        
    }
    
    func flipCards(row: Int) {
        for i in 0...4 {
            DispatchQueue.main.asyncAfter(deadline: .now() + Double(i) * 0.25) {
                self.guesses[row].cardsFlipped[i] = true
            }
        }
    }
    
    func bounceCards(row: Int) {
        for i in 0...4 {
            DispatchQueue.main.asyncAfter(deadline: .now() + Double(i) * 0.3) {
                self.guesses[row].cardsBouncing[i] = true
            }
        }
    }
    
    func showAlert(message: String) {
        withAnimation {
            alertMessage = message
        }
        if gameStatus != .lose {
            withAnimation(Animation.linear(duration: 0.2).delay(3)) {
                alertMessage = nil
            }
        }
    }
    
    func getResult() -> String {
        var resultString = "Nerdle #\(stats.totalGames) - \(rowIndex + 1) / 6"
        
        for i in 0...rowIndex {
            resultString += "\n"
            for letter in guesses[i].letterStatus {
                switch letter {
                case .correct: resultString += "🟩"
                case .incorrect: resultString += "⬛"
                case .misplaced: resultString += "🟨"
                }
            }
        }
        
        return resultString
    }
    
    // TODO: add ability to share overall stats
    
    func getStatString() -> String {
        var statString = "My Nerdle Stats\n"
        statString += "Games Played: \(stats.totalGames)\n"
        statString += "Win %: \(stats.winPercentage)\n"
        statString += "Current Streak: \(stats.currentStreak)\n"
        statString += "Best Streak: \(stats.highestStreak)\n"
        
        return statString
    }
    
}
