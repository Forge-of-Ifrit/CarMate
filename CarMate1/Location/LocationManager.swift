//
//  LocationManager.swift
//  CarMate1
//
//  Created by Abdulrahmanb on 20/11/2025.
//
import Foundation
import CoreLocation
import MapKit
import Combine

class LocationManager: NSObject, ObservableObject,
        CLLocationManagerDelegate {
    private let locationManager = CLLocationManager()
    
    @Published var region = MKCoordinateRegion(
        center: CLLocationCoordinate2D(latitude: 25.197447685562704, longitude: 55.27974465908459), span: MKCoordinateSpan(latitudeDelta: 0.01, longitudeDelta: 0.01))
    
    @Published var userLocation : CLLocationCoordinate2D = CLLocationCoordinate2D(latitude: 25.197447685562704, longitude: 55.27974465908459)
    
    
    override init() {
        super.init()
        locationManager.delegate = self
        locationManager.desiredAccuracy = kCLLocationAccuracyBest
        locationManager.requestWhenInUseAuthorization()
        locationManager.startUpdatingLocation()
    }
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        guard let lastLocation = locations.last else {return}
        let coordinate = lastLocation.coordinate
        self.userLocation = coordinate
        self.region.center = coordinate
        locationManager.stopUpdatingLocation()
    }
    
    func updateUserLocation() {
        locationManager.startUpdatingLocation()
    }
    
    func locationManager(_ manager: CLLocationManager, didChangeAuthorization status: CLAuthorizationStatus) {
        switch status {
        case .notDetermined:
            print("Not determined")
        case .restricted, .denied:
            print("Permission Denied")
        case .authorizedAlways, .authorizedWhenInUse:
            print("Permission granted")
        @unknown default:
            print("status not known")
        }
    }
}
