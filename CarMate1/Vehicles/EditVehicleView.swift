//
//  EditVehicleView.swift
//  CarMate1
//
//  Created by Abdulrahmanb on 18/11/2025.
//

import SwiftUI
import SwiftData

struct EditVehicleView: View {
    
   @Bindable var vehicle: Vehicle
   @Environment(\.modelContext) private var modelContext
   @Environment(\.dismiss) private var dismiss

   let years = Array(1990...2025)

    var body: some View {
        NavigationStack {
             Form {
                 Section("Vehicle Details") {
                     TextField("Enter License Plate", text: $vehicle.plate)
                         .textFieldStyle(.roundedBorder)

                     TextField("Enter Make", text: $vehicle.make)
                         .textFieldStyle(.roundedBorder)

                     TextField("Enter Model", text: $vehicle.model)
                         .textFieldStyle(.roundedBorder)

                     Picker("Select Year", selection: $vehicle.year) {
                         ForEach(years, id: \.self) { year in
                             Text(String(year))
                         }
                     }
                     .padding()

                     Text("Mileage: \(vehicle.mileage, specifier: "%.0f") km")
                     Slider(value: $vehicle.mileage, in: 0.0...500000.0, step: 1000.0) {
                         Text("Mileage")
                     } minimumValueLabel: {
                         Text("0")
                     } maximumValueLabel: {
                         Text("500k")
                     }

                     Toggle("Reminder Enabled?", isOn: $vehicle.reminderEnabled)
                 }
             }
             .navigationTitle("Edit Vehicle")
             .toolbar {
                 ToolbarItem {
                     Button("Save") {
                         dismiss()
                     }
                 }
             }
         }
     }
}
/*
 #Preview {
 EditVehicleView()
 }
 */
