//
//  MapAppApp.swift
//  MapApp
//
//  Created by Summer Crow on 2022-03-11.
//

import SwiftUI

@main
struct MapAppApp: App {
    
    @StateObject private var vm = LocationsViewModel()

    
    var body: some Scene {
        WindowGroup {
            LocationsView()
                .environmentObject(vm)
            //ContentView()
        }
    }
}
