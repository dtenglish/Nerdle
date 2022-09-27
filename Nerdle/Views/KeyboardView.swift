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
        VStack {
            HStack(spacing: 1) {
                ForEach(dataModel.topRowKeys, id: \.key) { key in
                    KeyboardKeyView(key: key.key, color: key.color) {
                        key.action()
                    }
                }
            }
            
            HStack(spacing: 1) {
                ForEach(dataModel.middleRowKeys, id: \.key) { key in
                    KeyboardKeyView(key: key.key, color: key.color) {
                        key.action()
                    }
                }
            }
            
            HStack(spacing: 1) {
                ForEach(dataModel.bottomRowKeys, id: \.key) { key in
                    KeyboardKeyView(key: key.key, color: key.color) {
                        key.action()
                    }
                }
            }
        }
    }
}

struct KeyboardView_Previews: PreviewProvider {
    static var previews: some View {
        KeyboardView()
    }
}
