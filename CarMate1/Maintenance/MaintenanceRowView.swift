//
//  MaintenanceRowView.swift
//  CarMate1
//
//  Created by Abdulrahmanb on 20/11/2025.
//

import SwiftUI

struct MaintenanceRowView: View {
    
    let record: MaintenanceRecord
    
    var body: some View {
        HStack(spacing: 15) {
             
            // Service icon with background
            ZStack {
                Circle()
                    .fill(Color.orange.opacity(0.15))
                    .frame(width: 60, height: 60)
                 
                Image(systemName: "wrench.fill")
                    .font(.system(size: 28))
                    .foregroundStyle(.orange)
            }
             
            // Service details (left side)
            VStack(alignment: .leading, spacing: 6) {
                Text(record.serviceType)
                    .font(.headline)
                    .foregroundStyle(.primary)
                 
                // Vehicle plate with icon
                HStack(spacing: 4) {
                    Image(systemName: "car.fill")
                        .font(.caption2)
                        .foregroundStyle(.gray)
                     
                    Text(record.vehiclePlate)
                        .font(.subheadline)
                        .foregroundStyle(.secondary)
                }
            }
      
            Spacer()
      
            // Date and cost (right side)
            VStack(alignment: .trailing, spacing: 6) {
                // Date badge
                Text(record.date, style: .date)
                    .font(.caption)
                    .fontWeight(.semibold)
                    .foregroundStyle(.white)
                    .padding(.horizontal, 8)
                    .padding(.vertical, 3)
                    .background(Color.blue)
                    .clipShape(Capsule())
                 
                // Cost with icon
                HStack(spacing: 3) {
                    Text("\(Int(record.cost)) AED")
                        .font(.headline)
                }
                .foregroundStyle(.green)
                 
                // Mileage info
                HStack(spacing: 3) {
                    Image(systemName: "gauge.medium")
                        .font(.caption2)
                    Text("\(Int(record.mileage / 1000))K km")
                        .font(.headline)
                }
                .foregroundStyle(.secondary)
            }
        }
        .padding(.vertical, 8)
     }
      

     }

     #Preview { let records = [ MaintenanceRecord(vehiclePlate: "ABC123", serviceType: "Minor Service", date: Date(), mileage: 45000, cost: 350, notes: ""), MaintenanceRecord(vehiclePlate: "XYZ789", serviceType: "Major Service", date: Date().addingTimeInterval(-8640030), mileage: 78000, cost: 850, notes: ""), MaintenanceRecord(vehiclePlate: "DEF456", serviceType: "Brake Service", date: Date().addingTimeInterval(-8640060), mileage: 32000, cost: 550, notes: "") ]

     return List {
        ForEach(records) { record in
            MaintenanceRowView(record: record)
        }
     }
}
