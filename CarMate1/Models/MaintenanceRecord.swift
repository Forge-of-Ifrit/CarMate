//
//  MaintenanceRecord.swift
//  CarMate1
//
//  Created by Abdulrahmanb on 18/11/2025.
//

import Foundation
import SwiftData

@Model
class MaintenanceRecord {
    
    var vehiclePlate: String
    var serviceType: String
    var date: Date
    var mileage: Double
    var cost: Double
    var notes: String
    
    init(vehiclePlate: String = "", serviceType: String = "", date: Date = Date(), mileage: Double = 0.0, cost: Double = 0.0, notes: String = "") {
        
        self.vehiclePlate = vehiclePlate
        self.serviceType = serviceType
        self.date = date
        self.mileage = mileage
        self.cost = cost
        self.notes = notes
    }
}
