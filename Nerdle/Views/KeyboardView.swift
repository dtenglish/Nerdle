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
            HStack(spacing: 2) {
                ForEach(dataModel.topRowKeys, id: \.key) { key in
                    KeyboardKeyView(key: key)
                }
            }
            
            HStack(spacing: 2) {
                ForEach(dataModel.middleRowKeys, id: \.key) { key in
                    KeyboardKeyView(key: key)
                }
            }
            
            HStack(spacing: 2) {
                ForEach(dataModel.bottomRowKeys, id: \.key) { key in
                    KeyboardKeyView(key: key)
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
