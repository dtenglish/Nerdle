//
//  GuessView.swift
//  Nerdle
//
//  Created by Daniel Taylor English on 9/26/22.
//

import SwiftUI

struct GuessView: View {
    @Binding var guess: Guess
    
    var body: some View {
        HStack(spacing: 3) {
            ForEach(0...4, id: \.self) { i in
                LetterView(isFlipped: $guess.cardsFlipped[i], letter: guess.guessLetters[i], letterStatus: guess.letterStatus[i])
            }
        }
    }
}

struct GuessView_Previews: PreviewProvider {
    static var previews: some View {
        GuessView(guess: .constant(Guess(index: 0)))
    }
}
