//
//  GameView.swift
//  Nerdle
//
//  Created by Daniel Taylor English on 9/26/22.
//

import SwiftUI

struct GameView: View {
    @EnvironmentObject var dataModel: NerdleDataModel
    
    var boardWidth: CGFloat {
        switch dataModel.screenWidth {
        case 0...743:
            return dataModel.screenWidth * 0.85
        case 744...1023:
            return 500
        default:
            return 650
        }
    }
    
    var boardHeight: CGFloat {
        6 * boardWidth / 5
    }
    
    var body: some View {
        VStack {
            Spacer()
            
            VStack(spacing: 3) {
                ForEach(0...5, id: \.self) { i in
                    GuessView(guess: $dataModel.guesses[i])
                        .modifier(Shake(animatableData: dataModel.guesses[i].shake))
                }
            }
            .frame(width: boardWidth, height: boardHeight)
            
            Spacer()
            
            KeyboardView()
            
            Spacer()
        }
    }
}
