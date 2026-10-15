//
//  EditMaintenanceView.swift
//  CarMate1
//
//  Created by Abdulrahmanb on 20/11/2025.
//

import SwiftUI
import SwiftData

struct EditMaintenanceView: View {
    
    @Bindable var record: MaintenanceRecord
    @Environment(\.modelContext) private var modelContext
    @Environment(\.dismiss) private var dismiss
    
    let serviceTypes = ["Minor Service", "Major Service", "Brake Service", "Other"]
    
    var body: some View {
        NavigationStack {
            Form {
                Section("Service Details") {
                    TextField("Vehicle Plate", text: $record.vehiclePlate)
                        .textFieldStyle(.roundedBorder)
                        .disabled(true)

                    Picker("Service Type", selection: $record.serviceType) {
                        ForEach(serviceTypes, id: \.self) { type in
                            Text(type)
                        }
                    }
                    .padding()

                    DatePicker("Service Date", selection: $record.date, displayedComponents: .date)
                        .padding()
                     
                    Text("Mileage: \(record.mileage, specifier: "%.0f") km")
                    Slider(value: $record.mileage, in: 0.0...500000.0, step: 1000.0) {
                        Text("Mileage")
                    } minimumValueLabel: {
                        Text("0")
                    } maximumValueLabel: {
                        Text("500k")
                    }

                    TextField("Enter Cost (AED)", value: $record.cost, format: .number)
                        .textFieldStyle(.roundedBorder)
                        .keyboardType(.decimalPad)
                }

                Section("Notes") {
                    TextField("Enter notes", text: $record.notes)
                        .textFieldStyle(.roundedBorder)
                }
            }
            .navigationTitle("Edit Maintenance")
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
 EditMaintenanceView()
 }
 */
