//
//  MapViewModel.swift
//  TicketBookingApp
//
//  Created by HUY TON on 18/8/24.
//

import Foundation
import SwiftUI
import MapKit


class MapViewModel: NSObject, ObservableObject, CLLocationManagerDelegate  {
    
    
    var locationManager: CLLocationManager?
    
    @Published var camera: MapCameraPosition = .region(.init(center: .defaultLocation, span: .initialSpan))
    @Published var coordinate: CLLocationCoordinate2D = .defaultLocation
    @Published var mapSpan: MKCoordinateSpan = .initialSpan
    

    
    func isLocationServiceEnable()  {
        
        if CLLocationManager.locationServicesEnabled(){
            
            locationManager = CLLocationManager() // call locationManagerDidChangeAuthorization() when create CLLocationManager automatically
            locationManager!.delegate = self
            
            print("Create location manager instance")
            
        } else {
            
            print("Location service off... turn it on :))")
        }
    }
    
    private func checkLocationAuthorization() {
        
    
        
        guard let locationManager = locationManager else { return }
        
        switch locationManager.authorizationStatus {
            
            case .notDetermined:
                locationManager.requestWhenInUseAuthorization()
            case .restricted:
                print("Location is restricted")
            case .denied:
                print("Location is denied")
            case .authorizedAlways, .authorizedWhenInUse:
                // access and set to user location
                print("Location is allowed")
                
                camera = .region(MKCoordinateRegion(center: locationManager.location!.coordinate,
                                                            span: .initialSpan))
                coordinate = locationManager.location!.coordinate
                            
            @unknown default:
                break
        }
    }
    
    func locationManagerDidChangeAuthorization(_ manager: CLLocationManager) {
        checkLocationAuthorization()
    }
    

    func updateCamera(region: MKCoordinateRegion) {
        
        camera = .region(region)
    }
    
    func updateMapSpan(_ newMapSpan: MKCoordinateSpan) {
        
        self.mapSpan = newMapSpan
    }
    
    func updateCoordinate (_ newCoordinate: CLLocationCoordinate2D) {
        self.coordinate = newCoordinate
    }
}
