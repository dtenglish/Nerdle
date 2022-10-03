//
//  LetterView.swift
//  Nerdle
//
//  Created by Daniel Taylor English on 10/3/22.
//

import SwiftUI

struct LetterView: View {
    @Binding var isFlipped: Bool
    @State var frontRotation: Double = 0.0
    @State var backRotation: Double = 90.0
    
    var letter: String
    var letterStatus: Guess.LetterStatus
    var bgColor: Color {
        switch letterStatus {
        case .correct: return .correct
        case .misplaced: return .misplaced
        case .incorrect: return .incorrect
        }
    }
    
    var body: some View {
        ZStack {
            Text(letter)
                .frame(maxWidth: .infinity, maxHeight: .infinity)
                .border(Color(.secondaryLabel))
                .font(.system(size: 35, weight: .heavy))
                .foregroundColor(.primary)
                .background(Color.systemBackground)
                .rotation3DEffect(Angle(degrees: frontRotation), axis: (x: 0, y: 1, z: 0.0001)) // z being 0 gives warning message?
    
            Text(letter)
                .frame(maxWidth: .infinity, maxHeight: .infinity)
                .border(Color(.secondaryLabel))
                .font(.system(size: 35, weight: .heavy))
                .foregroundColor(.primary)
                .background(bgColor)
                .rotation3DEffect(Angle(degrees: backRotation), axis: (x: 0, y: 1, z: 0.0001)) // z being 0 gives warning message?
        }
        .onChange(of: isFlipped) { _ in
            flipCard()
        }
    }
    
    func flipCard() {
        let duration = 0.25
        
        withAnimation(.linear(duration: duration)) {
            frontRotation = -90
        }
        
        withAnimation(.linear(duration: duration).delay(duration)){
            backRotation = 0
        }
    }
}
