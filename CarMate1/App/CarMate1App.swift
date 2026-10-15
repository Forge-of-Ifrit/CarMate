//
//  CarMate1App.swift
//  CarMate1
//
//  Created by Abdulrahmanb on 18/11/2025.
//

import SwiftUI
import SwiftData
import UserNotifications

@main
struct CarMate1App: App {
    // handles the notifications 
    class NotficationDelegate: NSObject, UNUserNotificationCenterDelegate {
        
        // Called when notification arrives while the app is open
        func userNotificationCenter(_ center: UNUserNotificationCenter, willPresent notification: UNNotification, withCompletionHandler completionHandler: @escaping (UNNotificationPresentationOptions) -> Void) {
            
            // Show Banner, sound, and update the badge
            completionHandler([.banner, .sound, .badge])
        }
    }
    let notificationDelegate = NotficationDelegate()
    
    // Called once when app launches.
    init() {
        // Set notification delegate
        UNUserNotificationCenter.current().delegate = notificationDelegate
        
        // Func for request for permission
        requestNotifactionPermission()
    }
    var body: some Scene {
        WindowGroup {
            ContentView()
        }
        .modelContainer(for: [UserAccount.self, Vehicle.self, MaintenanceRecord.self])
    }
    // Request for user permission notification to send notifications
    func requestNotifactionPermission() {
        UNUserNotificationCenter.current().requestAuthorization(options: [.alert, .sound, .badge]) { granted, error in
            if granted {
                print("Notifcation permission granted")
            } else {
                print("Notifcation permission denied")
            }
            if let error = error {
                print("Error requesting notifcation permission: \(error)")
            }
        }
    }
}
