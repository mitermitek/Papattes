//
//  ContentView.swift
//  Papattes
//
//  Created by Kevin MITERMITE on 09/06/2026.
//

import SwiftUI
import SwiftData

struct ContentView: View {
    var body: some View {
        TabView {
            Tab("Rappels", systemImage: "calendar.badge.clock") {
                RemindersView()
            }
            Tab("Animaux", systemImage: "pawprint") {
                PetsView()
            }
            Tab("Paramètres", systemImage: "gearshape") {
                SettingsView()
            }
        }
    }
}

#Preview {
    ContentView()
}
