//
//  TicketBookingAppApp.swift
//  TicketBookingApp
//
//  Created by HUY TON on 12/8/24.
//

import SwiftUI
import MapKit

@main
struct FoodBookingApp: App {
    
    @StateObject private var vm = ViewModel()
    @StateObject private var vmMap = MapViewModel()
    @StateObject private var vmCart = CartViewModel()
    @StateObject private var vmItems = ItemsViewModel()
    @StateObject private var vmBooking = BookingViewModel()
    
    
    
    var body: some Scene {
        WindowGroup {
            
            switch vm.authenticationStatus {
                
            case .valid:
                MainView()
                    .environmentObject(vm)
                    .environmentObject(vmMap)
                    .environmentObject(vmCart)
                    .environmentObject(vmItems)
                    .environmentObject(vmBooking)
                    .fontDesign(.rounded)
                    .tint(Color.button)
                    .onAppear {
                        // MARK: Asking user location
                        CLLocationManager().requestWhenInUseAuthorization()
                    }
                    
            default:
                LoginView()
                    .environmentObject(vm)
                    .fontDesign(.rounded)
                    .tint(Color.button)
            }
        }
    
        
    }
    
}
