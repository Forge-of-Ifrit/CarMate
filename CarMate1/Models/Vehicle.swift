//
//  Vehicle.swift
//  CarMate1
//
//  Created by Abdulrahmanb on 18/11/2025.
//

import Foundation
import SwiftData

@Model
class Vehicle {
    
    var plate: String
    var make: String
    var model: String
    var year: Int
    var mileage: Double
    var reminderEnabled: Bool
    
    init(plate: String = "", make: String = "", model: String = "", year: Int = 2024, mileage: Double = 0.0, reminderEnabled: Bool = false) {
        
        self.plate = plate
        self.make = make
        self.model = model
        self.year = year
        self.mileage = mileage
        self.reminderEnabled = reminderEnabled
    }
}
