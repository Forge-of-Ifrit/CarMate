//
//  MaintenanceView.swift
//  CarMate1
//
//  Created by Abdulrahmanb on 18/11/2025.
//

import SwiftUI
import SwiftData

struct MaintenanceView: View {
    
    @Environment(\.modelContext) private var modelContext
    
    @Query private var maintenanceRecords: [MaintenanceRecord]
    
    @Query private var vehicles: [Vehicle]
    
    // State variables
    @State private var showAddSheet = false
    // selected vehicle plate for filtering
    @State private var selectedPlate: String = ""
    
    // Filter maintenance records by selected vehicle
    var filteredRecords: [MaintenanceRecord] {
        if selectedPlate.isEmpty {
            return maintenanceRecords
        } else {
            return maintenanceRecords.filter {$0.vehiclePlate == selectedPlate }
        }
    }
    var body: some View {
        NavigationStack {
            VStack {
                // Vehicle Picker for Filtering (CLO3: Data Retrieval/Search)
                if !vehicles.isEmpty {
                    Picker("Select Vehicle", selection: $selectedPlate) {
                        ForEach(vehicles) { vehicle in
                            Text(vehicle.plate).tag(vehicle.plate)
                        }
                    }
                    .pickerStyle(SegmentedPickerStyle())
                    .padding()
                }

                // List of filtered maintenance records
                List {
                    ForEach(filteredRecords) { record in
                        NavigationLink {
                            EditMaintenanceView(record: record)
                        } label: {
                            MaintenanceRowView(record: record)
                        }
                    }
                    // Swipe to delete (CLO3: CRUD - Delete operation)
                    .onDelete(perform: deleteRecord)
                }
            }
            .navigationTitle("Maintenance")
            .toolbar {
                ToolbarItem {
                    Button {
                        showAddSheet = true
                    } label: {
                        Image(systemName: "plus")
                    }
                }
                ToolbarItem(placement: .topBarLeading) {
                    EditButton()
                }
            }
            // Show add form as sheet
            .sheet(isPresented: $showAddSheet) {
                AddMaintenanceView()
            }
            // Set default vehicle selection when view appears
            .onAppear {
                if selectedPlate.isEmpty, let firstVehicle = vehicles.first {
                    selectedPlate = firstVehicle.plate
                }
            }
        }
    }

    // Delete maintenance record from database (CLO3: CRUD - Delete)
    func deleteRecord(at offsets: IndexSet) {
        for offset in offsets {
            let record = filteredRecords[offset]
            modelContext.delete(record)
        }
    }
}

#Preview {
    MaintenanceView()
}
