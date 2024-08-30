//
//  FoodDetailView.swift
//  TicketBookingApp
//
//  Created by HUY TON on 17/8/24.
//

import SwiftUI

struct MenuItemDetailView: View {
    
    
    var menuItem: MenuItem
    
    @State var animateGradient = false
    
    @EnvironmentObject var vmCart: CartViewModel
    
    var body: some View {
        ZStack {
            VStack  {
                Image(menuItem.image)
                    .resizable()
                    .scaledToFit()
                    .frame(height: 200)
                    .padding(.vertical, 20)
                    .shadow(color: .black, radius: 7, x:4, y:4)
                   
                    
                VStack {
                    ScrollView {
                        VStack(alignment: .leading, spacing: 25) {
                            
                            title
                            description
                            restaurantDetail
                            detail
                        }
                    }
                    Divider()
      
                    addToCartButton
    
              
                    
                    Spacer(minLength: 70)
                    
                }
                .padding(25)
                .background(.ultraThickMaterial)
                .clipShape(.rect(cornerRadius: 50))
                .ignoresSafeArea()
            }
        }
        .alert(
            "Cart Message",
            isPresented: $vmCart.showAlert,
            actions: { Button("OK") { } },
            message: {
                if let message = vmCart.alertMessage {
                    Text(message)
                }
            }
        )
        .fontDesign(.rounded)
        .background(.gray.opacity(0.3))
    }
    
    
    var title: some View {
        VStack (spacing: 0) {
            HStack {
                Text(menuItem.name)
                    .font(.title)
                    .fontWeight(.bold)
                    .foregroundStyle(.button)
                
                Spacer()
                
                HStack {
                    Image(systemName: "dollarsign")
                    Text(menuItem.price)
                }
                .font(.title2)
            }
            Divider()
        }
    }
    
    var description: some View {
        HStack {
            
            HStack {
                Image(systemName: "star.fill")
                    .foregroundStyle(.yellow)
                
                Text(String(menuItem.rating))
            }
            Spacer()
            
            
            
           
        }
        .font(.headline)
    }
    
    
    var restaurantDetail: some View {
        VStack(alignment: .leading) {
            Label(menuItem.restaurantName, systemImage: "mappin")
                .font(.headline)
                .fontWeight(.semibold)
                .padding(.bottom, 5)
            
            Text(menuItem.address)
                .font(.caption)
                .foregroundStyle(.secondary)
        }
    }
    
    
    var detail: some View {
        VStack(alignment: .leading) {
            Label("Detail", systemImage: "square.and.pencil")
                .font(.headline)
                .fontWeight(.semibold)
                .padding(.bottom, 5)
                
            Text(menuItem.description)
                .font(.caption)
                .foregroundStyle(.secondary)
        }
    }
    
    
    var addToCartButton: some View {
        Button {
            Task {
                vmCart.addItem(CartItem(food: self.menuItem))
            }
            
        } label: {
            Label("Add to Cart", systemImage: "plus")
                .frame(maxWidth: .infinity)
        }
        .foregroundStyle(.white)
        .font(.headline)
        .padding()
        .background(.button)
        .clipShape(.rect(cornerRadius: 20))
        
    }
}

//#Preview {
//    @State var food = MenuItem(id: 1, restaurantId: 1,  name: "Vegetarian Soup", image: "vegetarian_soup", category: .Food, rating: 4.3 , description: "A hearty vegetarian soup filled wihh vegetarian soup filled with fresh vegetables, tender beans, and aromatic herbs in a rich, flavorful broth. Perfect for a cozy, nourishing meal.", price: "100"
//    )
//    
//    return MenuItemDetailView(menuItem: food)
//        .environmentObject(CartViewModel())
//
//}
