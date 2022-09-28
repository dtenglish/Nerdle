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
    
    var body: some Scene {
        WindowGroup {
            GeometryReader { geometry in
                MainView()
                    .environmentObject(dataModel)
                    .onAppear {
                        dataModel.screenWidth = geometry.size.width
                    }
            }
        }
    }
}
