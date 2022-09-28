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
        newGame()
        populateKeys()
    }
    
    func newGame() {
        resetToDefaults()
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
            topRowKeys.append(KeyboardKey(key: letter) { self.addLetter(letter)
            })
        }
        
        for letter in middleRowLetters {
            middleRowKeys.append(KeyboardKey(key: letter) { self.addLetter(letter)
            })
        }
        
        bottomRowKeys.append(KeyboardKey(key: "ENTER") {
            self.enterWord()
        })
        
        for letter in bottomRowLetters {
            bottomRowKeys.append(KeyboardKey(key: letter) { self.addLetter(letter)
            })
        }
        
        bottomRowKeys.append(KeyboardKey(key: "BACKSPACE") {
            self.backspace()
        })
    }

    func addLetter(_ letter: String) {
        print(letter)
    }

    func backspace() {
        print(scaleFactor)
    }

    func enterWord() {
        print(screenWidth)
    }

}
