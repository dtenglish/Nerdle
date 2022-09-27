//
//  GameView.swift
//  Nerdle
//
//  Created by Daniel Taylor English on 9/26/22.
//

import SwiftUI

struct GameView: View {
    @EnvironmentObject var dataModel: NerdleDataModel
    @EnvironmentObject var boardViewModel: BoardViewModel
    
    var body: some View {
        VStack(spacing: 3) {
            ForEach(0...5, id: \.self) { index in
                GuessView(guess: $dataModel.guesses[index])
            }
        }
        .frame(width: boardViewModel.boardWidth, height: boardViewModel.boardHeight)
    }
}
