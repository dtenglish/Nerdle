//
//  ColorSchemeManager.swift
//  Nerdle
//
//  Created by Daniel Taylor English on 10/11/22.
//

import SwiftUI

class ColorSchemeManager: ObservableObject {
    enum Scheme: String {
        case system, light, dark
    }

    @AppStorage("theme") var selectedScheme: Scheme = .system
    @Environment(\.colorScheme) private var systemScheme
    
    var scheme: ColorScheme? {
        switch selectedScheme {
        case .system: return nil
        case .light: return .light
        case .dark: return .dark
        }
    }
    
    func applyTheme() {
        
    }
}
