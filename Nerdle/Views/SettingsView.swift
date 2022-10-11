//
//  SettingsView.swift
//  Nerdle
//
//  Created by Daniel Taylor English on 9/26/22.
//

import SwiftUI

struct SettingsView: View {
    @EnvironmentObject var dataModel: NerdleDataModel
    @EnvironmentObject var schemeManager: ColorSchemeManager
    
    var gameInProgress: Bool {
        if dataModel.gameStatus == .inPlay && dataModel.rowIndex > 0 {
            return true
        } else {
            return false
        }
    }
    
    var body: some View {
        VStack {
            Form {
                Section("DISPLAY SETTINGS") {
                    Picker("Color Scheme", selection: schemeManager.$selectedScheme) {
                        Text("System Default").tag(ColorSchemeManager.Scheme.system)
                        Text("Light Mode").tag(ColorSchemeManager.Scheme.light)
                        Text("Dark Mode").tag(ColorSchemeManager.Scheme.dark)
                    }
                    .pickerStyle(.menu)
                }
                Section("GAME DIFFICULTY") {
                    Picker("Difficulty", selection: dataModel.$hardMode) {
                        Text("Normal").tag(false)
                        Text("Hard").tag(true)
                    }
                    .pickerStyle(.segmented)
                    .disabled(gameInProgress)
                    .opacity(gameInProgress ? 0.75 : 1)
                    
                    if gameInProgress {
                        Text("Difficulty cannot be changed while game in progress")
                            .foregroundColor(.red)
                            .font(.subheadline)
                    }
                }
                .listRowSeparator(.hidden)
            }
        }
        .toolbar {
            ToolbarItem(placement: .principal) {
                Text("SETTINGS")
                    .font(.title)
                    .fontWeight(.heavy)
                    .foregroundColor(.primary)
            }
        }
    }
}

struct SettingsView_Previews: PreviewProvider {
    static var previews: some View {
        SettingsView()
    }
}
