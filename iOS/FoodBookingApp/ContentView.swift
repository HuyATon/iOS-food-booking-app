//
//  ContentView.swift
//  TicketBookingApp
//
//  Created by HUY TON on 12/8/24.
//

import SwiftUI
import MapKit

struct ContentView: View {
    
    @EnvironmentObject var vmUser: UserViewModel
    @EnvironmentObject var vmMap: MapViewModel
    @EnvironmentObject var vmCart : CartViewModel
    @EnvironmentObject var vmItems: ItemsViewModel
    @EnvironmentObject var vmBooking: BookingViewModel
    
    
    @EnvironmentObject var router: Router
    
    var body: some View {
        
        NavigationStack(path: $router.path) {
            
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
        .environmentObject(UserViewModel())
        .environmentObject(MapViewModel())
        .environmentObject(CartViewModel())
        .environmentObject(ItemsViewModel())
        .environmentObject(BookingViewModel())
        .environmentObject(Router()) 
        
}
