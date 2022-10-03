//
//  Guess.swift
//  Nerdle
//
//  Created by Daniel Taylor English on 9/26/22.
//

import SwiftUI

struct Guess {
    enum LetterStatus {
        case correct, incorrect, misplaced
    }
    
    let index: Int
    var word = "     "
    var shake: CGFloat = 0
    var letterStatus = [LetterStatus](repeating: .incorrect, count: 5)
    var cardsFlipped = [Bool](repeating: false, count: 5)
    var guessLetters: [String] {
        word.map { String($0) }
    }
}
