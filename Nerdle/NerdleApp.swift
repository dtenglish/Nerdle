//
//  NerdleApp.swift
//  Nerdle
//
//  Created by Daniel Taylor English on 9/26/22.
//

import SwiftUI

@main
struct NerdleApp: App {
    @StateObject private var dataModel = NerdleDataModel()
    @StateObject private var schemeManager = ColorSchemeManager()
    
    var body: some Scene {
        WindowGroup {
            GeometryReader { geometry in
                MainView()
                    .environmentObject(dataModel)
                    .environmentObject(schemeManager)
                    .onAppear {
                        dataModel.screenWidth = geometry.size.width
                    }
                    .preferredColorScheme(schemeManager.scheme ?? .none)
            }
        }
    }
}
