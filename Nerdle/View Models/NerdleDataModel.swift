//
//  GameDataModel.swift
//  Nerdle
//
//  Created by Daniel Taylor English on 9/26/22.
//

import SwiftUI

class NerdleDataModel: ObservableObject {
    @Published var guesses: [Guess] = []
    @Published var topRowKeys: [KeyboardKey] = []
    @Published var middleRowKeys: [KeyboardKey] = []
    @Published var bottomRowKeys: [KeyboardKey] = []
    
    let topRowLetters = "QWERTYUIOP".map { String($0) }
    let middleRowLetters = "ASDFGHJKL".map { String($0) }
    let bottomRowLetters = "ZXCVBNM".map { String($0) }
    
//    @Published var keys: [KeyboardKey] = []
//
//    let letters = "ABCDEFGHIJKLMNOPQRSTUVWXYZ".map { String($0) }
    
    init() {
        newGame()
        populateKeys()
    }
    
    func newGame() {
        resetToDefaults()
    }
    
    func resetToDefaults() {
        guesses = []
        
        for index in 0...5 {
            guesses.append(Guess(index: index))
        }
        
//        for i in 0 ..< keys.count {
//            keys[i].color = .unused
//        }
    }
    
}

//MARK: - KEYBOARD

extension NerdleDataModel {

    func populateKeys() {
        for letter in topRowLetters {
            topRowKeys.append(KeyboardKey(key: letter, action: {self.addLetter(letter)}))
        }
        
        for letter in middleRowLetters {
            middleRowKeys.append(KeyboardKey(key: letter, action: {self.addLetter(letter)}))
        }
        
        bottomRowKeys.append(KeyboardKey(key: "ENTER", action: {self.enterWord()}))
        
        for letter in bottomRowLetters {
            bottomRowKeys.append(KeyboardKey(key: letter, action: {self.addLetter(letter)}))
        }
        
        bottomRowKeys.append(KeyboardKey(key: "BACKSPACE", action: {self.backspace()}))
    }

    func addLetter(_ letter: String) {
        print(letter)
    }

    func backspace() {
        print("backspace")
    }

    func enterWord() {
        print("enter word")
    }

}
