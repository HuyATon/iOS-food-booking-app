//
//  ContentView.swift
//  TicketBookingApp
//
//  Created by HUY TON on 12/8/24.
//

import SwiftUI
import MapKit

struct ContentView: View {
    
    @EnvironmentObject var vmUser: ViewModel
    @EnvironmentObject var vmMap: MapViewModel
    @EnvironmentObject var vmCart : CartViewModel
    @EnvironmentObject var vmItems: ItemsViewModel
    @EnvironmentObject var vmBooking: BookingViewModel
    
    
    
    var body: some View {
        
        NavigationStack {
            
            switch vmUser.authenticationStatus {

                case .valid:
                        MainView()
                            .environmentObject(vmCart)

                            .onAppear {
                                // MARK: Asking user location
                                CLLocationManager().requestWhenInUseAuthorization()
                            }
                            .task {
                                await vmItems.fetchRestaurantsAndMenuItems()
                            }
                default:
                        LoginView()
                            .environmentObject(vmUser)
            }
        }
        .ignoresSafeArea()
    }
    
}

#Preview {
    ContentView()
        .environmentObject(ViewModel())
        .environmentObject(MapViewModel())
        .environmentObject(CartViewModel())
        .environmentObject(ItemsViewModel())
        .environmentObject(BookingViewModel())
        
}
