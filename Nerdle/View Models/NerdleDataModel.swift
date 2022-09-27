//
//  GameDataModel.swift
//  Nerdle
//
//  Created by Daniel Taylor English on 9/26/22.
//

import SwiftUI

class NerdleDataModel: ObservableObject {
    @Published var guesses: [Guess] = []

    init() {
        newGame()
    }
    
    func newGame() {
        resetToDefaults()
    }
    
    func resetToDefaults() {
        guesses = []
        for index in 0...5 {
            guesses.append(Guess(index: index))
        }
    }
}
