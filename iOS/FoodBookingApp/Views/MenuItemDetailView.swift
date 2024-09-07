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
    @EnvironmentObject var vmItems: ItemsViewModel
    
    
    var body: some View {
        
        VStack  {
            itemImage
                
            VStack {
                ScrollView {
                    VStack(alignment: .leading, spacing: 25) {
                        
                        title
                        description
                        restaurantDetail
                        detail
                        feedbacks
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
        .task {
            await vmItems.fetchFeedbacksOfItem(menuItem)
        }
    }
        
    
    
    var title: some View {
        VStack (spacing: 0) {
            HStack {
                Text(menuItem.name)
                    .font(.title)
                    .fontWeight(.bold)
                    .foregroundStyle(.button)
                
                Spacer()
                
                Text("$\(menuItem.price)")
                    .font(.title2)
            }
            Divider()
        }
    }
    
    var itemImage: some View {
        Image(menuItem.image)
            .resizable()
            .scaledToFit()
            .frame(height: 200)
            .padding(.vertical, 20)
            .shadow(color: .black, radius: 7, x:4, y:4)
    }
    
    var description: some View {
        HStack {
            
            HStack {
                Image(systemName: "star.fill")
                    .foregroundStyle(.yellow)
                
                if let averageRating = menuItem.averageRating {
                    Text(averageRating, format: .number.precision(.fractionLength(1)))
                }
                else {
                    Text("has no reviews")
                        .foregroundStyle(.secondary)
                        .fontWeight(.ultraLight)
                }
                
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
    
    var feedbacks: some View {
        
        DisclosureGroup {
         
            if vmItems.isLoading {
                ProgressView("Loading feedbacks")
                    .padding()
            }
            else {
                if vmItems.userFeedbacks.isEmpty {
                    Text("Item has no feedbacks or error in retrieve feedbacks from server")
                        .font(.caption)
                        .fontWeight(.ultraLight)
                }
                else {
                    ForEach(vmItems.userFeedbacks, id: \.self) { fb in
                        FeedbackUI(feedback: fb)
                    }
                }
            }
        } label: {
            Label("View Feedbacks", systemImage: "person.3.sequence")
                .font(.headline)
                .fontWeight(.semibold)
                .foregroundStyle(.black)
        }
        .tint(.black)
       
    }
    
    
    var addToCartButton: some View {
        Button {
            vmCart.addItem(CartItem(menuItem: self.menuItem))
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

#Preview {
    let food = MenuItem(id: 1, restaurantId: 1, name: "Coffee", image: "coffee", category: .Drinks, description: "Full of cafein", price: 15, restaurantName: "Highland", address: "123 Street", averageRating: 4.5)
    
    return MenuItemDetailView(menuItem: food)
        .environmentObject(CartViewModel())
        .environmentObject(ItemsViewModel())

}
