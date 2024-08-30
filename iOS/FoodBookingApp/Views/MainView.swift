//
//  HomeScreen.swift
//  TicketBookingApp
//
//  Created by HUY TON on 15/8/24.
//

import SwiftUI
import MapKit

struct MainView: View {
        
    @EnvironmentObject var vmCart: CartViewModel
    
    @State var currentTab: Tab = .home
    

    // disable default tab bar
    init() {
        UITabBar.appearance().isHidden = true
    }
    
    
    var body: some View {
        
            TabView(selection: $currentTab) {
                HomeView()
                    .tag(Tab.home)
                
                CartView()
                    .tag(Tab.cart)
                
                BookingsView()
                    .tag(Tab.booking)
       
                ProfileView()
                    .tag(Tab.profile)
            }
            .overlay(alignment: .bottom) {
                CustomTabBar(currentTab: $currentTab, numberOfCartItems: vmCart.cartItems.count)
                    .frame(alignment: .bottom)
            }
            .ignoresSafeArea()
    }
    
}
