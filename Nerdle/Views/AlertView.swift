//
//  AlertView.swift
//  Nerdle
//
//  Created by Daniel Taylor English on 10/4/22.
//

import SwiftUI

struct AlertView: View {
    let message: String
    
    var body: some View {
        Text(message)
            .padding()
            .foregroundColor(.systemBackground)
            .background(RoundedRectangle(cornerRadius: 10).fill(Color.primary))
    }
}

struct AlertView_Previews: PreviewProvider {
    static var previews: some View {
        AlertView(message: "Word not found in word list")
    }
}
