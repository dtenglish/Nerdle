//
//  KeyboardKeyView.swift
//  Nerdle
//
//  Created by Daniel Taylor English on 9/27/22.
//

import SwiftUI

struct KeyboardKeyView: View {
    let key: String
    var color: Color
    let action: () -> Void
    
    var body: some View {
        Button {
            action()
        } label: {
            if key != "BACKSPACE" {
                Text(key)
                    .font(.body)
                    .frame(width: key.count == 1 ? 35 : 60, height: 50)
                    .background(color)
                    .foregroundColor(.primary)
            } else {
                Image(systemName: "delete.backward.fill")
                    .font(.system(size: 20, weight: .heavy))
                    .frame(width: 60, height: 50)
                    .background(color)
                    .foregroundColor(.primary)
            }
        }
        .buttonStyle(.plain)
    }
}

struct KeyboardButtonView_Previews: PreviewProvider {
    static var previews: some View {
        KeyboardKeyView(key: "L", color: .unused, action: { return })
    }
}
