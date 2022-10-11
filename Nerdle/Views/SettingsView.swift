//
//  SettingsView.swift
//  Nerdle
//
//  Created by Daniel Taylor English on 9/26/22.
//

import SwiftUI

struct SettingsView: View {
    @EnvironmentObject var schemeManager: ColorSchemeManager
    
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
}

struct SettingsView_Previews: PreviewProvider {
    static var previews: some View {
        SettingsView()
    }
}
