//
//  BoardViewModel.swift
//  Nerdle
//
//  Created by Daniel Taylor English on 9/27/22.
//

import SwiftUI

class BoardViewModel: ObservableObject {
    @Published var screenWidth: CGFloat = 0
    
    var boardWidth: CGFloat {
        if screenWidth < 744 {
            return screenWidth * 0.85
        } else {
            return 450
        }
    }
    
    var boardHeight: CGFloat {
        6 * boardWidth / 5
    }
}
