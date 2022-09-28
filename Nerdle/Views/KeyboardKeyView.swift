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
    var scaleFactor: CGFloat
    let action: () -> Void
    
    var keyHeight: CGFloat {
        return scaleFactor * 50
    }
    
    var smallKeyWidth: CGFloat {
        return scaleFactor * 35
    }
    
    var largeKeyWidth: CGFloat {
        return scaleFactor * 60
    }
    
    var fontSize: CGFloat {
        return scaleFactor * 16
    }
    
    var body: some View {
        Button {
            action()
        } label: {
            if key != "BACKSPACE" {
                Text(key)
                    .font(.system(size: fontSize))
                    .frame(width: key.count == 1 ? smallKeyWidth : largeKeyWidth, height: keyHeight)
                    .background(color)
                    .foregroundColor(.primary)
            } else {
                Image(systemName: "delete.backward.fill")
                    .font(.system(size: fontSize + 3, weight: .heavy))
                    .frame(width: largeKeyWidth, height: keyHeight)
                    .background(color)
                    .foregroundColor(.primary)
            }
        }
        .buttonStyle(.plain)
        .cornerRadius(5)
    }
}

struct KeyboardButtonView_Previews: PreviewProvider {
    static var previews: some View {
        KeyboardKeyView(key: "L", color: .unused, scaleFactor: 1, action: { return })
    }
}
