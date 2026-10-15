//
//  AddMaintenanceView.swift
//  CarMate1
//
//  Created by Abdulrahmanb on 20/11/2025.
//

import SwiftUI
import SwiftData
import UserNotifications

struct AddMaintenanceView: View {
    
    @State private var selectedPlate: String = ""
    @State private var serviceType: String = "Minor Service"
    @State private var date: Date = Date()
    @State private var mileage: Double = 0.0
    @State private var cost: String = ""
    @State private var notes: String = ""
    
    @Environment(\.modelContext) private var modelContext
    @Environment(\.dismiss) private var dismiss
    @Query private var vehicles: [Vehicle]
    
    let serviceTypes = ["Minor Service", "Major Service", "Brake Service", "Other"]
    
    var body: some View {
        NavigationStack {
            Form {
                Section("Service Details") {
                    Picker("Select Vehicle", selection: $selectedPlate) {
                        ForEach(vehicles) { vehicle in
                            Text(vehicle.plate).tag(vehicle.plate)
                        }
                    }
                    .padding()
                      
                    Picker("Service Type", selection: $serviceType) {
                        ForEach(serviceTypes, id: \.self) { type in
                            Text(type)
                        }
                    }
                    .padding()
                      
                    DatePicker("Service Date", selection: $date, displayedComponents: .date)
                        .padding()
                      
                    Text("Mileage: \(mileage, specifier: "%.0f") km")
                    Slider(value: $mileage, in: 0.0...500000.0, step: 1000.0) {
                        Text("Mileage")
                    } minimumValueLabel: {
                        Text("0")
                    } maximumValueLabel: {
                        Text("500k")
                    }
                      
                    TextField("Enter Cost (AED)", text: $cost)
                        .textFieldStyle(.roundedBorder)
                        .keyboardType(.decimalPad)
                }
                  
                Section("Notes") {
                    TextField("Enter notes (optional)", text: $notes)
                        .textFieldStyle(.roundedBorder)
                }
            }
            .navigationTitle("Add Maintenance")
            .toolbar {
                ToolbarItem {
                    Button("Save") {
                        let costValue = Double(cost) ?? 0.0
                          
                        let newRecord = MaintenanceRecord(vehiclePlate: selectedPlate, serviceType: serviceType, date: date, mileage: mileage, cost: costValue, notes: notes)
                        modelContext.insert(newRecord)
                          
                        // Check if vehicle has reminder enabled
                        if let vehicle = vehicles.first(where: { $0.plate == selectedPlate }) {
                            if vehicle.reminderEnabled {
                                scheduleMaintenanceReminder(vehiclePlate: selectedPlate, serviceType: serviceType)
                            }
                        }
                          
                        dismiss()
                    }
                }
                ToolbarItem(placement: .topBarLeading) {
                    Button("Cancel") {
                        dismiss()
                    }
                }
            }
            .onAppear {
                if selectedPlate.isEmpty, let firstVehicle = vehicles.first {
                    selectedPlate = firstVehicle.plate
                }
            }
        }
     }
      
     // Schedule Notification Function
     func scheduleMaintenanceReminder(vehiclePlate: String, serviceType: String) {
        let content = UNMutableNotificationContent()
        content.title = "Maintenance Reminder"
        content.body = "It's been 6 months since \(serviceType) for vehicle \(vehiclePlate). Time for a checkup!"
        content.sound = .default
          
        let sixMonthsInSeconds: TimeInterval = 6 * 30 * 24 * 60 * 60
          
        let trigger = UNTimeIntervalNotificationTrigger(timeInterval: sixMonthsInSeconds, repeats: false)
         
        let request = UNNotificationRequest(
            identifier: "\(vehiclePlate)_\(Date().timeIntervalSince1970)",
            content: content,
            trigger: trigger
        )
         
        UNUserNotificationCenter.current().add(request)
        print("Reminder scheduled for 6 months")
     }
      

     }
#Preview {
    AddMaintenanceView()
}
