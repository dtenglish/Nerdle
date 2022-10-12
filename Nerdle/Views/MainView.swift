//
//  MainView.swift
//  Nerdle
//
//  Created by Daniel Taylor English on 9/26/22.
//

import SwiftUI

struct MainView: View {
    @EnvironmentObject var dataModel: NerdleDataModel
    
    var body: some View {
        ZStack {
            NavigationStack {
                GameView()
                    .padding()
                    .navigationBarTitleDisplayMode(.inline)
                    .toolbar {
                        ToolbarItem(placement: .navigationBarLeading) {
                            Button {
                                dataModel.showHelp.toggle()
                            } label: {
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
                                Button {
                                    dataModel.showStats.toggle()
                                } label: {
                                    Image(systemName: "chart.bar")
                                }
                                NavigationLink(destination: SettingsView()) {
                                    Image(systemName: "gearshape.fill")
                                }
                            }
                        }
                    }
            }
            .disabled(dataModel.showStats || dataModel.showHelp)
            if dataModel.showStats {
                StatsView()
                    .offset(y: dataModel.screenWidth * -0.15)
            }
            if dataModel.showHelp {
                HelpView()
            }
        }
    }
}

struct MainView_Previews: PreviewProvider {
    static var previews: some View {
        let dataModel = NerdleDataModel()
        
        GeometryReader { geometry in
            MainView()
                .environmentObject(dataModel)
                .onAppear {
                    dataModel.screenWidth = geometry.size.width
                }
        }
    }
}
