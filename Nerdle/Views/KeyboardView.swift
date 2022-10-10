//
//  KeyboardView.swift
//  Nerdle
//
//  Created by Daniel Taylor English on 9/27/22.
//

import SwiftUI

struct KeyboardView: View {
    @EnvironmentObject var dataModel: NerdleDataModel
    
    var body: some View {
        VStack(spacing: 2) {
            HStack(spacing: 2) {
                ForEach(dataModel.topRowLetters, id: \.self) { letter in
                    if let key = dataModel.keys[letter] {
                        KeyboardKeyView(key: key)
                    }
                }
            }
            
            HStack(spacing: 2) {
                ForEach(dataModel.middleRowLetters, id: \.self) { letter in
                    if let key = dataModel.keys[letter] {
                        KeyboardKeyView(key: key)
                    }
                }
            }
            
            HStack(spacing: 2) {
                
                if let enterKey = dataModel.keys["ENTER"] {
                    KeyboardKeyView(key: enterKey)
                }
                
                ForEach(dataModel.bottomRowLetters, id: \.self) { letter in
                    if let key = dataModel.keys[letter] {
                        KeyboardKeyView(key: key)
                    }
                }
                
                if let backspaceKey = dataModel.keys["BACKSPACE"] {
                    KeyboardKeyView(key: backspaceKey)
                }
            }
        }
    }
}

struct KeyboardView_Previews: PreviewProvider {
    static var previews: some View {
        KeyboardView()
            .environmentObject(NerdleDataModel())
    }
}
