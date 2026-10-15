//
//  AddVehicleView.swift
//  CarMate1
//
//  Created by Abdulrahmanb on 18/11/2025.
//

import SwiftUI
import SwiftData

struct AddVehicleView: View {
    
    @State private var plate: String = ""
    @State private var make: String = ""
    @State private var model: String = ""
    @State private var year: Int = 2024
    @State private var mileage: Double = 0.0
    @State private var reminderEnabled: Bool = false

    @Environment(\.modelContext) private var modelContext
    @Environment(\.dismiss) private var dismiss

    let years = Array(1990...2025)

     
    var body: some View {
        
        NavigationStack {
            Form {
                Section("Vehicle Details") {
                    TextField("Enter License Plate", text: $plate)
                        .textFieldStyle(.roundedBorder)

                    TextField("Enter Make", text: $make)
                        .textFieldStyle(.roundedBorder)

                    TextField("Enter Model", text: $model)
                        .textFieldStyle(.roundedBorder)

                    Picker("Select Year", selection: $year) {
                        ForEach(years, id: \.self) { year in
                            Text(String(year))
                        }
                    }
                    .padding()

                    Text("Mileage: \(mileage, specifier: "%.0f") km")
                    Slider(value: $mileage, in: 0.0...500000.0, step: 1000.0) {
                        Text("Mileage")
                    } minimumValueLabel: {
                        Text("0")
                    } maximumValueLabel: {
                        Text("500k")
                    }

                    Toggle("Reminder Enabled?", isOn: $reminderEnabled)
                }
            }
            .navigationTitle("Add Vehicle")
            .toolbar {
                ToolbarItem {
                    Button("Save") {
                        let newVehicle = Vehicle(plate: plate, make: make, model: model, year: year, mileage: mileage, reminderEnabled: reminderEnabled)
                        modelContext.insert(newVehicle)
                        dismiss()
                    }
                }
                
                ToolbarItem(placement: .topBarLeading) {
                    Button("Cancel") {
                        dismiss()
                    }
                }
            }
        }
    }
}


#Preview {
    AddVehicleView()
}
