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
    
    var wordQueue: [String] = []
    var completedWords: [String] = []
    var disabledLetters: [String] = []
    
    var currentSolution = ""
    var currentGuess = ""
    var rowIndex = 0
    
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
    }
    
    func resetToDefaults() {
        guesses = []
        disabledLetters = []
        rowIndex = 0
        currentGuess = ""
        
        for i in 0...5 {
            guesses.append(Guess(index: i))
        }
        
        for (key, _) in keys {
            keys[key]?.color = .unused
            keys[key]?.isDisabled = false
        }
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
        switch key {
        case "ENTER": enterWord()
        case "BACKSPACE": backspace()
        default: addLetter(key)
        }
        
        updateKeyboard()
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
    
    func disableLetters() {
        for letter in disabledLetters {
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
                flipCards(row: rowIndex)
                
                if currentGuess == currentSolution {
                    print("correct guess, you win")
                    gameStatus = .win
//                    newGame()
                    return
                }
                
                disableLetters()
                
                if rowIndex < 6 {
                    rowIndex += 1
                    currentGuess = ""
                } else {
                    gameStatus = .lose
                }
                
            } else {
                withAnimation {
                    guesses[rowIndex].shake = 1
                }
                guesses[rowIndex].shake = 0
            }
        }
    }
    
    func verifyWord() -> Bool {
        UIReferenceLibraryViewController.dictionaryHasDefinition(forTerm: currentGuess)
    }
    
    func checkLetters() {
        var solutionLetters = currentSolution.map { String($0) }
        let guessLetters = guesses[rowIndex].guessLetters
        let invalidLetters = guessLetters.filter{ !solutionLetters.contains($0) }
        
        disabledLetters += invalidLetters
        
        for i in 0...4 {
            if guessLetters[i] == solutionLetters[i] {
                guesses[rowIndex].letterStatus[i] = .correct
                solutionLetters[i] = ""
            } else if solutionLetters.contains(guessLetters[i]) {
                guesses[rowIndex].letterStatus[i] = .misplaced
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
    
    func flipCards(row: Int) {
        for i in 0...4 {
            DispatchQueue.main.asyncAfter(deadline: .now() + Double(i) * 0.2) {
                self.guesses[row].cardsFlipped[i] = true
            }
        }
    }
    
}
