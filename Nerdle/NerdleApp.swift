//
//  NerdleApp.swift
//  Nerdle
//
//  Created by Daniel Taylor English on 9/26/22.
//

import SwiftUI

@main
struct NerdleApp: App {
    @StateObject var dataModel = NerdleDataModel()
    @StateObject var boardViewModel = BoardViewModel()
    
    var body: some Scene {
        WindowGroup {
            GeometryReader { geometry in
                MainView()
                    .environmentObject(dataModel)
                    .environmentObject(boardViewModel)
                    .onAppear {
                        boardViewModel.screenWidth = geometry.size.width
                    }
            }
        }
    }
}
