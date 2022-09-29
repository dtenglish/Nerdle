//
//  GameDataModel.swift
//  Nerdle
//
//  Created by Daniel Taylor English on 9/26/22.
//

import SwiftUI

class NerdleDataModel: ObservableObject {
    @Published var screenWidth: CGFloat = 0
    @Published var guesses: [Guess] = []
    
    @Published var topRowKeys: [KeyboardKey] = []
    @Published var middleRowKeys: [KeyboardKey] = []
    @Published var bottomRowKeys: [KeyboardKey] = []
    
    var wordQueue: [String] = []
    var completedWords: [String] = []
    var disabledLetters: [String] = []
    
    var currentSolution = ""
    var currentGuess = ""
    var rowIndex = 0
    
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
    }
    
    func resetToDefaults() {
        guesses = []
        
        for i in 0...5 {
            guesses.append(Guess(index: i))
        }
        
        for i in 0 ..< topRowKeys.count {
            topRowKeys[i].color = .unused
        }
        
        for i in 0 ..< middleRowKeys.count {
            middleRowKeys[i].color = .unused
        }
        
        for i in 0 ..< bottomRowKeys.count {
            bottomRowKeys[i].color = .unused
        }
    }
    
}

//MARK: - KEYBOARD

extension NerdleDataModel {

    func populateKeys() {
        for letter in topRowLetters {
            topRowKeys.append(KeyboardKey(key: letter) {
                self.keyPressed(letter)
            })
        }
        
        for letter in middleRowLetters {
            middleRowKeys.append(KeyboardKey(key: letter) {
                self.keyPressed(letter)
            })
        }
        
        bottomRowKeys.append(KeyboardKey(key: "ENTER", isDisabled: true) {
            self.keyPressed("ENTER")
        })
        
        for letter in bottomRowLetters {
            bottomRowKeys.append(KeyboardKey(key: letter) {
                self.keyPressed(letter)
            })
        }
        
        bottomRowKeys.append(KeyboardKey(key: "BACKSPACE", isDisabled: true) {
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
        
        for i in 0 ..< topRowKeys.count {
            if disabledLetters.contains(topRowKeys[i].key) {
                topRowKeys[i].isDisabled = true
            }
        }
        
        for i in 0 ..< middleRowKeys.count {
            if disabledLetters.contains(middleRowKeys[i].key) {
                middleRowKeys[i].isDisabled = true
            }
        }
        
        for i in 0 ..< bottomRowKeys.count {
            if disabledLetters.contains(bottomRowKeys[i].key) {
                bottomRowKeys[i].isDisabled = true
            }
        }
        
        if currentGuess.count > 0 {
            bottomRowKeys[8].isDisabled = false
        } else {
            bottomRowKeys[8].isDisabled = true
        }
        if currentGuess.count == 5 {
            bottomRowKeys[0].isDisabled = false
        } else {
            bottomRowKeys[0].isDisabled = true
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
        print(currentGuess)
    }

    func backspace() {
        if currentGuess.count > 0 {
            currentGuess.removeLast()
            updateRow()
        }
        print(currentGuess)
    }

    func enterWord() {
        if currentGuess.count == 5 {
            if verifyWord() {
                print("valid word")
                if currentGuess == currentSolution {
                    print("correct guess")
                } else {
                    print("incorrect guess")
                }
                checkLetters()
                if rowIndex < 6 {
                    rowIndex += 1
                    currentGuess = ""
                }
            } else {
                print("invalid word")
            }
        }
    }
    
    func verifyWord() -> Bool {
        UIReferenceLibraryViewController.dictionaryHasDefinition(forTerm: currentGuess)
    }
    
    func checkLetters() {
        let guessLetters = currentGuess.map { String($0) }
        let solutionLetters = currentSolution.map { String($0) }
        let invalidLetters = guessLetters.filter{!solutionLetters.contains($0)}
        disabledLetters += invalidLetters
        print("solution: " + currentSolution)
        print("guess: " + currentGuess)
        print(disabledLetters)
    }
    
    func updateRow() {
        let rowLetters = currentGuess.padding(toLength: 5, withPad: " ", startingAt: 0)
        guesses[rowIndex].word = rowLetters
    }
    
}
