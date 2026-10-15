//
//  MapView.swift
//  CarMate1
//
//  Created by CIA3003-B on 20/11/2025.
//

import SwiftUI
import MapKit
import CoreLocation

let serviceCenterAbuDhabi = CLLocationCoordinate2D(latitude: 24.4539, longitude: 54.3773)
let serviceCenterDubai = CLLocationCoordinate2D(latitude: 25.2048, longitude: 55.2708)
let serviceCenterSharjah = CLLocationCoordinate2D(latitude: 25.3463, longitude: 55.4209)

struct MapView: View {
    
    @State private var position = MapCameraPosition.region(MKCoordinateRegion(center: serviceCenterAbuDhabi, span: MKCoordinateSpan(latitudeDelta: 0.01, longitudeDelta: 0.01)))
    
    @State private var locationManager = LocationManager()
    
    var body: some View {
        Map(position: $position,
            interactionModes: [.pan, .zoom, .pitch, .rotate]) {

            UserAnnotation()

            Annotation("Abu Dhabi Branch", coordinate: serviceCenterAbuDhabi){

                VStack {
                    Image("logo")
                        .resizable()
                        .scaledToFit()
                        .frame(width: 60, height: 60)
                        .background(.black)
                    
                    Text("Service Center - Abu Dhabi")
                        .font(.system(size:12))
                        .bold()
                        .padding()
                        .background(.gray)
                        .clipShape(Capsule())
                }
            }
            .annotationTitles(.hidden)
            
            Annotation("Service Center Dubai", coordinate: serviceCenterDubai){
                VStack {
                    Image("logo")
                        .resizable()
                        .scaledToFit()
                        .frame(width: 60, height: 60)
                        .background(.black)
                    Text("Service Center - Dubai")
                        .font(.system(size:12))
                        .bold()
                        .padding()
                        .background(.gray)
                        .clipShape(Capsule())
                }
            }
            .annotationTitles(.hidden)

            Annotation("Service Center Sharjah", coordinate: serviceCenterSharjah){
                VStack {
                    Image("logo")
                        .resizable()
                        .scaledToFit()
                        .frame(width: 60, height: 60)
                        .background(.black)
                    Text("Service Center - Sharjah")
                        .font(.system(size:12))
                        .bold()
                        .padding()
                        .background(.gray)
                        .clipShape(Capsule())
                }
            }
        }
        .mapStyle(.hybrid(elevation: .realistic, pointsOfInterest: [.gasStation, .carRental], showsTraffic: true))
        .mapControls {
            MapPitchToggle()
            MapCompass()
            MapUserLocationButton()
        }
        HStack {
            Button("Abu Dhabi") {
                position = MapCameraPosition.region(MKCoordinateRegion(
                    center: serviceCenterAbuDhabi, span: MKCoordinateSpan(latitudeDelta: 0.1, longitudeDelta: 0.1)))
            }
            .buttonBorderShape(.capsule)
            .padding(.horizontal)
            Button("Dubai") {
                position = MapCameraPosition.region(MKCoordinateRegion(
                    center: serviceCenterDubai, span: MKCoordinateSpan(latitudeDelta: 0.1, longitudeDelta: 0.1)))
            }
            .buttonBorderShape(.capsule)
            .padding(.horizontal)
            Button("Sharjah") {
                position = MapCameraPosition.region(MKCoordinateRegion(
                    center: serviceCenterSharjah, span: MKCoordinateSpan(latitudeDelta: 0.1, longitudeDelta: 0.1)))
            }
            .buttonBorderShape(.capsule)
        }
        .padding()
    }
}

#Preview {
    MapView()
}
