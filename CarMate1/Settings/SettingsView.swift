//
//  SettingsView.swift
//  CarMate1
//
//  Created by Abdulrahmanb on 22/11/2025.
//

import SwiftUI
import SwiftData
import UserNotifications

struct SettingsView: View {

    // Session state shared with LoginView / ContentView
    @AppStorage("isLoggedIn") private var isLoggedIn: Bool = false
    @AppStorage("savedUsername") private var savedUsername: String = ""

    // Counts shown in the summary section
    @Query var vehicles: [Vehicle]
    @Query var records: [MaintenanceRecord]

    // Logout confirmation
    @State private var showLogoutConfirm: Bool = false

    var body: some View {
        NavigationStack {
            Form {
                // App header
                Section {
                    HStack(spacing: 15) {
                        Image("logo")
                            .resizable()
                            .scaledToFit()
                            .frame(width: 60, height: 60)
                            .clipShape(RoundedRectangle(cornerRadius: 12))

                        VStack(alignment: .leading, spacing: 4) {
                            Text("CarMate")
                                .font(.title2)
                                .bold()
                            Text(savedUsername.isEmpty ? "Signed in" : "Signed in as \(savedUsername)")
                                .font(.subheadline)
                                .foregroundStyle(.gray)
                        }
                    }
                    .padding(.vertical, 5)
                }

                // Summary of saved data
                Section("My Garage") {
                    LabeledContent("Vehicles", value: "\(vehicles.count)")
                    LabeledContent("Maintenance Records", value: "\(records.count)")
                }

                // Notifications
                Section("Notifications") {
                    Button("Clear Pending Reminders") {
                        UNUserNotificationCenter.current().removeAllPendingNotificationRequests()
                        print("All pending reminders cleared")
                    }
                }

                // Logout
                Section {
                    Button("Logout", role: .destructive) {
                        showLogoutConfirm = true
                    }
                    .frame(maxWidth: .infinity)
                }
            }
            .navigationTitle("Settings")
            .alert("Logout", isPresented: $showLogoutConfirm) {
                Button("Cancel", role: .cancel) { }
                Button("Logout", role: .destructive) {
                    logoutUser()
                }
            } message: {
                Text("Are you sure you want to logout?")
            }
        }
    }

    // Ends the session and returns the user to HomeView
    func logoutUser() {
        isLoggedIn = false
        print("User logged out")
    }
}

#Preview {
    SettingsView()
        .modelContainer(for: [UserAccount.self, Vehicle.self, MaintenanceRecord.self])
}
