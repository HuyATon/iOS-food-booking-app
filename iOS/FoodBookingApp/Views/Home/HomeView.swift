//
//  HomeView.swift
//  TicketBookingApp
//
//  Created by HUY TON on 15/8/24.
//

import SwiftUI

struct HomeView: View {
    
    @State private var animateGradient = false
    
    @EnvironmentObject var vm: ViewModel
    @EnvironmentObject var vmItems: ItemsViewModel
    
    var body: some View {

        NavigationStack {
            ScrollView {
                VStack (alignment: .leading) {
                    
                    welcomeText
                    
                    Promotions()

                    CustomSearchBar(searchText: $vmItems.searchText)
                    
                    OptionalCategories(currentCategory: $vmItems.currentCategory)
                    
                    Text("Order Now!").font(.title).bold()
                       
                    if vmItems.isLoading {
                        ProgressView()
                    }
                    else {
                        LazyVGrid(columns: [GridItem() , GridItem()]) {
                            
                            ForEach( vmItems.filteredItems ) { item in
                                
                                NavigationLink {
                                    MenuItemDetailView(menuItem: item)
                                } label: {
                                    CustomMenuItem(menuItem: item)
                                }
                                
                            }
                        }
                    }
                    Spacer(minLength: 100)
                    
                }
                .padding()
            }
            .background(
                LinearGradient(gradient: Gradient(colors: [.gradientColor1, .gradientColor2]), startPoint: .topLeading, endPoint: .bottomTrailing)
                    .hueRotation(.degrees(animateGradient ? 30 : 0))
                    .onAppear {
                        withAnimation(.easeInOut(duration: 3).repeatForever(autoreverses: true)) {
                            animateGradient.toggle()
                        }
                    }
                    .ignoresSafeArea()
        )
        }
    }
    
    
    var welcomeText: some View {
        HStack {
            Image("cooker")
                .resizable()
                .scaledToFit()
                .frame(width: 70)
                .padding()
                .background {
                    Circle()
                        .fill(.ultraThickMaterial)
                }
                .padding(.trailing, 20)
            
            VStack(alignment: .leading) {
                Text("Welcome back, \(vm.user?.username ?? "invalid_user")!")
                Text("How hungry are you?")
            }
            .fontWeight(.light)
            .font(.subheadline)
            
            Spacer()
        }
        .padding()
        .background(.ultraThinMaterial)
        .clipShape(.capsule(style: .circular))
    }
}

#Preview {
//    HomeView(vmItems: ItemsViewModel(), vmCart: CartViewModel())
    
    @StateObject var vmItems = ItemsViewModel()
    @StateObject var vmCart = CartViewModel()
    
    
    return HomeView()
        .environmentObject(vmItems)
        .environmentObject(vmCart)
}
