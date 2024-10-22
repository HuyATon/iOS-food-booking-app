//
//  HomeScreen.swift
//  TicketBookingApp
//
//  Created by HUY TON on 15/8/24.
//

import SwiftUI
import MapKit

struct MainView: View {
        
    @EnvironmentObject var vm: ViewModel
    @EnvironmentObject var vmCart: CartViewModel
    @EnvironmentObject var vmItems: ItemsViewModel
    
    @State var currentTab: Tab = .home
    

    // disable default tab bar
    init() {
        UITabBar.appearance().isHidden = true
    }
    
    
    var body: some View {
        
            TabView(selection: $currentTab) {
                HomeView()
                    .tag(Tab.home)
                    .task {
                        await vmItems.fetchRestaurantsAndMenuItems()
                    }
                
                CartView()
                    .tag(Tab.cart)
                
                BookingsView()
                    .tag(Tab.booking)
       
                ProfileView()
                    .tag(Tab.profile)
            }
            .overlay(alignment: .bottom) {
                if !vm.goInside {
                    CustomTabBar(currentTab: $currentTab)
                        .frame(alignment: .bottom)
                }
            }
            .ignoresSafeArea()
    }
    
}
