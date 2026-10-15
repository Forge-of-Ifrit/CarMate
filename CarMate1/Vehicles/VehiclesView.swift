//
//  VehiclesView.swift
//  CarMate1
//
//  Created by Abdulrahmanb on 18/11/2025.
//

import SwiftUI
import SwiftData

struct VehiclesView: View {
    
    @Environment(\.modelContext) private var modelContext
    @Query private var vehicles: [Vehicle]
    @State private var showAddSheet = false
    
    var body: some View {
        NavigationStack {
             List {
                 ForEach(vehicles) { vehicle in
                     NavigationLink {
                         EditVehicleView(vehicle: vehicle)
                     } label: {
                         VehicleRowView(vehicle: vehicle)
                     }
                 }
                 .onDelete(perform: deleteVehicle)
             }
             .navigationTitle("My Vehicles")
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
             .sheet(isPresented: $showAddSheet) {
                 AddVehicleView()
             }
         }
     }
      
     // delete vehicle function
     func deleteVehicle(at offsets: IndexSet) {
         for offset in offsets {
             let vehicle = vehicles[offset]
             modelContext.delete(vehicle)
         }
     }
}


#Preview {
    VehiclesView()
}
