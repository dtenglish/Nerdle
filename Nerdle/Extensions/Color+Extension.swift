//
//  Color+Extension.swift
//  Nerdle
//
//  Created by Daniel Taylor English on 9/26/22.
//

import SwiftUI

extension Color {
    static var correct: Color {
        Color(UIColor(named: "correct")!)
    }
    static var misplaced: Color {
        Color(UIColor(named: "misplaced")!)
    }
    static var unused: Color {
        Color(UIColor(named: "unused")!)
    }
    static var wrong: Color {
        Color(UIColor(named: "wrong")!)
    }
    static var systemBackground: Color {
        Color(.systemBackground)
    }
}
