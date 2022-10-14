//
//  HelpView.swift
//  Nerdle
//
//  Created by Daniel Taylor English on 9/27/22.
//

import SwiftUI

struct HelpView: View {
    @EnvironmentObject var dataModel: NerdleDataModel
    
    @State var example1 = Guess(index: 0, word: "WEARY")
    @State var example2 = Guess(index: 0, word: "PILLS")
    @State var example3 = Guess(index: 0, word: "VAGUE")
    
    var rem: CGFloat {
        return dataModel.screenWidth * 0.1
    }
    
    var body: some View {
        VStack(alignment: .leading) {
            HStack {
                Spacer()
                Button {
                    dataModel.showHelp = false
                } label: {
                    Image(systemName: "multiply")
                        .font(.title2)
                        .fontWeight(.semibold)
                        .foregroundColor(.accentColor)
                }
                .padding(.top, rem * 0.25)
            }
            VStack(alignment: .leading, spacing: 0) {
                Text("How To Play")
                    .font(.largeTitle)
                    .fontWeight(.heavy)
                    .padding(.bottom, rem * 0.1)
                Text("Guess the Nerdle in 6 tries.")
                    .font(.title3)
                    .fontWeight(.semibold)
                    .padding(.bottom, rem * 0.25)
                Label {
                    Text("Each guess must be a valid five letter word.")
                } icon: {
                    Text("•")
                        .font(.largeTitle)
                        .offset(y: -2)
                }
                Label {
                    Text("The color of the tile will change to show how close your guess was to the word.")
                } icon: {
                    Text("•")
                        .font(.largeTitle)
                        .offset(y: -2)
                }
            }
            .font(.callout)
            .fontWeight(.medium)
            .padding(.bottom, rem * 0.25)
            VStack(alignment: .leading, spacing: 10) {
                Text("Examples")
                    .font(.title2)
                    .fontWeight(.heavy)
                    .padding(.bottom, rem * 0.25)
                
                GuessView(guess: $example1)
                    .padding(.trailing, rem * 2)
                Text("**W** is in the word and in the correct spot.")
                
                GuessView(guess: $example2)
                    .padding(.trailing, rem * 2)
                Text("**I** is in the word but in the wrong spot.")
                
                
                GuessView(guess: $example3)
                    .padding(.trailing, rem * 2)
                Text("**U** is not in the word in any spot.")
            }
            .padding(.bottom, rem * 0.25)
            .onAppear(perform: animateExamples)
            Divider()
                .padding(.bottom, rem * 0.25)
            Text("Have feedback? email us at nerdle@fakeemail.com")
                .padding(.bottom, rem * 0.5)
                .lineSpacing(5)
        }
        .padding(.vertical, rem * 0.25)
        .padding(.horizontal, rem * 0.5)
        .frame(width: rem * 9)
        .fixedSize()
        .background(RoundedRectangle(cornerRadius: 8)
            .fill(Color(UIColor.systemGray6))
            .shadow(color: .black.opacity(0.3), radius: 6, x: 2, y: 2)
        )
    }
}

//MARK: - FUNCTIONS

extension HelpView {
    func animateExamples() {
        example1.letterStatus[0] = .correct
        example2.letterStatus[1] = .misplaced
        
        example1.cardsFlipped[0] = true
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
            self.example2.cardsFlipped[1] = true
        }
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
            self.example3.cardsFlipped[3] = true
        }
    }
}
