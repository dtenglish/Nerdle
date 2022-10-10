//
//  LetterView.swift
//  Nerdle
//
//  Created by Daniel Taylor English on 10/3/22.
//

import SwiftUI

struct LetterView: View {
    @Binding var isFlipped: Bool
    @Binding var isBouncing: Bool
    @State var frontRotation: Double = 0.0
    @State var backRotation: Double = 90.0
    @State var verticalOffset: CGFloat = 0
    
    var letter: String
    var letterStatus: Guess.LetterStatus
    
    private var bgColor: Color {
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
                .offset(y: verticalOffset)
                .animation(.spring(response: 0.5, dampingFraction: 0.75, blendDuration: 0), value: verticalOffset)
                .rotation3DEffect(Angle(degrees: frontRotation), axis: (x: 0, y: 1, z: 0.00000001)) // z being 0 gives warning message?
    
            Text(letter)
                .frame(maxWidth: .infinity, maxHeight: .infinity)
                .border(Color(.secondaryLabel))
                .font(.system(size: 35, weight: .heavy))
                .foregroundColor(.primary)
                .background(bgColor)
                .offset(y: verticalOffset)
                .animation(.spring(response: 0.5, dampingFraction: 0.75, blendDuration: 0), value: verticalOffset)
                .rotation3DEffect(Angle(degrees: backRotation), axis: (x: 0, y: 1, z: 0.00000001)) // z being 0 gives warning message?
        }
        .onChange(of: isFlipped) { _ in
            if isFlipped {
                flipCard()
            } else {
                frontRotation = 0
                backRotation = 90
            }
        }
        .onChange(of: isBouncing) { _ in
            if isBouncing {
                bounceCard()
            } else {
                verticalOffset = 0
            }
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
    
    func bounceCard() {
        verticalOffset = -25
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.2) {
            verticalOffset = 0
        }
    }
}
