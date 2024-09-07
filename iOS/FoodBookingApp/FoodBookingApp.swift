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
    
    @StateObject var vmUser = UserViewModel()
    @StateObject var vmMap = MapViewModel()
    @StateObject var vmCart = CartViewModel()
    @StateObject var vmItems = ItemsViewModel()
    @StateObject var vmBooking = BookingViewModel()
    
    @StateObject var router = Router()
    
    
    var body: some Scene {
        WindowGroup {
            
            switch vmUser.authenticationStatus {
                
            case .valid:
                MainView()
                    .environmentObject(vmUser)
                    .environmentObject(vmMap)
                    .environmentObject(vmCart)
                    .environmentObject(vmItems)
                    .environmentObject(vmBooking)
                    .environmentObject(router)
                    .fontDesign(.monospaced)
                    .tint(Color.button)
                    .onAppear {
                        // MARK: Asking user location
                        CLLocationManager().requestWhenInUseAuthorization()
                    }
                    
            default:
                LoginView()
                    .environmentObject(vmUser)
                    .fontDesign(.monospaced)
                    .tint(Color.button)
            }
        }
        
    }
    
}
