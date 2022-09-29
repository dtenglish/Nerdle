//
//  KeyboardKeyView.swift
//  Nerdle
//
//  Created by Daniel Taylor English on 9/27/22.
//

import SwiftUI

struct KeyboardKeyView: View {
    @EnvironmentObject var dataModel: NerdleDataModel
    
    var key: KeyboardKey
    
    var keyHeight: CGFloat {
        return dataModel.scaleFactor * 50
    }
    
    var smallKeyWidth: CGFloat {
        return dataModel.scaleFactor * 35
    }
    
    var largeKeyWidth: CGFloat {
        return dataModel.scaleFactor * 60
    }
    
    var fontSize: CGFloat {
        return dataModel.scaleFactor * 16
    }
    
    var body: some View {
        Button {
            key.action()
        } label: {
            if key.key != "BACKSPACE" {
                Text(key.key)
                    .font(.system(size: fontSize))
                    .frame(width: key.key.count == 1 ? smallKeyWidth : largeKeyWidth, height: keyHeight)
                    .background(key.color)
                    .foregroundColor(.primary)
            } else {
                Image(systemName: "delete.backward.fill")
                    .font(.system(size: fontSize + 3, weight: .heavy))
                    .frame(width: largeKeyWidth, height: keyHeight)
                    .background(key.color)
                    .foregroundColor(.primary)
            }
        }
        .buttonStyle(.plain)
        .cornerRadius(5)
        .disabled(key.isDisabled)
        .opacity(key.isDisabled ? 0.6 : 1.0)
    }
}
