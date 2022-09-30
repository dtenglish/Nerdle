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
            ForEach(0...4, id: \.self) { index in
                Text(guess.guessLetters[index])
                    .frame(maxWidth: .infinity, maxHeight: .infinity)
                    .border(Color(.secondaryLabel))
                    .font(.system(size: 35, weight: .heavy))
                    .foregroundColor(.primary)
                    .background(guess.bgColors[index])
            }
        }
    }
}

struct GuessView_Previews: PreviewProvider {
    static var previews: some View {
        GuessView(guess: .constant(Guess(index: 0)))
    }
}
