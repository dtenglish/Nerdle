//
//  MainView.swift
//  Nerdle
//
//  Created by Daniel Taylor English on 9/26/22.
//

import SwiftUI

struct MainView: View {
    var body: some View {
        NavigationStack {
            GameView()
                .padding()
                .toolbar {
                    ToolbarItem(placement: .navigationBarLeading) {
                        NavigationLink(destination: HelpView()) {
                            Image(systemName: "questionmark.circle")
                        }
                    }
                    ToolbarItem(placement: .principal) {
                        Text("NERDLE")
                            .font(.largeTitle)
                            .fontWeight(.heavy)
                            .foregroundColor(.primary)
                    }
                    ToolbarItem(placement: .navigationBarTrailing) {
                        HStack {
                            NavigationLink(destination: StatsView()) {
                                Image(systemName: "chart.bar")
                            }
                            NavigationLink(destination: SettingsView()) {
                                Image(systemName: "gearshape.fill")
                            }
                        }
                    }
                }
        }
    }
}

struct MainView_Previews: PreviewProvider {
    static var previews: some View {
        let dataModel = NerdleDataModel()
        let boardViewModel = BoardViewModel()
        
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
