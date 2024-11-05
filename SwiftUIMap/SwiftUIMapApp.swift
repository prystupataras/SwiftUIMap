//
//  SwiftUIMapApp.swift
//  SwiftUIMap
//
//  Created by Taras Prystupa on 05.11.2024.
//

import SwiftUI

@main
struct MapAppApp: App {
    
    @StateObject private var locationsViewModel = LocationsViewModel()
    
    var body: some Scene {
        WindowGroup {
            LocationsView()
                .environmentObject(locationsViewModel)
        }
    }
}
