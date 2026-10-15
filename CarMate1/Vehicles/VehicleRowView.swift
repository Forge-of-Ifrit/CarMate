//
//  VehicleRowView.swift
//  CarMate1
//
//  Created by Abdulrahmanb on 18/11/2025.
//

import SwiftUI
import SwiftData

struct VehicleRowView: View {
    
    let vehicle: Vehicle
    
    var body: some View {
        HStack(spacing: 15) {

            // Car icon with background
            ZStack {
                Circle()
                    .fill(Color.blue.opacity(0.15))
                    .frame(width: 60, height: 60)

                Image(systemName: "car.fill")
                    .font(.system(size: 28))
                    .foregroundStyle(.blue)
            }
            // Vehicle info
            VStack(alignment: .leading, spacing: 6) {
                // Make and Model on one line
                Text("\(vehicle.make) \(vehicle.model)")
                    .font(.headline)
                    .foregroundStyle(.primary)

                // License plate with icon
                HStack(spacing: 4) {
                    Image(systemName: "number.square.fill")
                        .font(.caption2)
                        .foregroundStyle(.gray)
                    
                    Text(vehicle.plate)
                        .font(.subheadline)
                        .foregroundStyle(.secondary)
                }
            }

            Spacer()

            // Right side info
            VStack(alignment: .trailing, spacing: 6) {
                Text(String(vehicle.year))
                    .font(.caption)
                    .fontWeight(.semibold)
                    .foregroundStyle(.white)
                    .padding(.horizontal, 8)
                    .padding(.vertical, 4)
                    .background(Color.blue)
                    .clipShape(Capsule())

                // Mileage with icon
                HStack(spacing: 3) {
                    Image(systemName: "gauge.medium")
                        .font(.caption2)
                    Text("\(Int(vehicle.mileage / 1000))K km")
                        .font(.caption)
                }
                .foregroundStyle(.secondary)
                
                // Reminder indicator
                if vehicle.reminderEnabled {
                    HStack(spacing: 3) {
                        Image(systemName: "bell.fill")
                            .font(.caption2)
                        Text("Reminder")
                            .font(.caption2)
                    }
                    .foregroundStyle(.orange)
                }
            }
        }
        .padding(.vertical, 8)
    }
    
}
/*
#Preview("Single Vehicle") {

    let vehicle = Vehicle(
        plate: "ABC123",
        make: "Toyota",
        model: "Camry",
        year: 2024,
        mileage: 45000,
        reminderEnabled: true
    )

    return VehicleRowView(vehicle: vehicle)
        .padding()
}
*/

#Preview("Multiple Vehicles") {

    let vehicles = [

        Vehicle(plate: "ABC123", make: "Toyota", model: "Camry", year: 2024, mileage: 45000, reminderEnabled: true),

        Vehicle(plate: "XYZ789", make: "Honda", model: "Accord", year: 2022, mileage: 78500, reminderEnabled: false),

        Vehicle(plate: "DEF456", make: "Nissan", model: "Altima", year: 2023, mileage: 32000, reminderEnabled: true)

    ]

     

    return List {
        ForEach(vehicles) { vehicle in
            VehicleRowView(vehicle: vehicle)
        }
    }
}
