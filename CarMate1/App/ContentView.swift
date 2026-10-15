//
//  ContentView.swift
//  CarMate1
//
//  Created by Abdulrahmanb on 18/11/2025.
//

import SwiftUI
import SwiftData

struct ContentView: View {
    
    // To get all users acounts from teh database
    @Query var users: [UserAccount]
    
    @AppStorage("isLoggedIn") private var isLoggedIn: Bool = false
    
    var body: some View {
        if isLoggedIn {
            // User is logged in Show main app
            TabView {
                VehiclesView()
                    .tabItem {
                        Label("Vehicles", systemImage: "car.fill")
                    }
                MaintenanceView()
                    .tabItem {
                        Label("Maintenance", systemImage: "wrench.fill")
                    }
                MapView()
                    .tabItem {
                        Label("Map", systemImage: "map.fill")
                    }
                SettingsView()
                    .tabItem {
                        Label("Settings", systemImage: "gearshape.fill")
                    }
            }
        } else {
            HomeView()
        }
    }
}

#Preview {
    ContentView()
        .modelContainer(for: [UserAccount.self, Vehicle.self, MaintenanceRecord.self])
}
