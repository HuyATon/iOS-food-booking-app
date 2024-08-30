//
//  CartView.swift
//  TicketBookingApp
//
//  Created by HUY TON on 17/8/24.
//

import SwiftUI

struct CartView: View {
    
    @EnvironmentObject var vmCart: CartViewModel
    @State var animateGradient = false
    
    var body: some View {
        
        NavigationStack {
            VStack {
                Text("Cart")
                    .font(.title)
                    .fontWeight(.bold)
                
                if vmCart.cartItems.isEmpty {
                    Spacer(minLength: 300)
                    Text("Cart is now empty...")
                        .font(.title3)
                        .foregroundStyle(.secondary)
                    
                }
                
                List {
                    ForEach($vmCart.cartItems) { $cartItem in
                        
                        VStack (alignment: .leading) {
                            CartSection(cartItem: $cartItem)
                            
                        }
                        .listRowInsets(EdgeInsets())
                        .scrollContentBackground(.hidden)
                        
                    }
                    
                    .onDelete { indexSet in
                        
                        Task {
                            vmCart.removeItem(at: indexSet)
                        }
  
                    }
                }
                .scrollContentBackground(.hidden)
                .clipShape(.rect(cornerRadius: 20))
                .padding(.bottom, 20)
                
                
                checkOutButton
                
            }
            .fontDesign(.rounded)
            .padding()
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
            .alert("Cart",
                   isPresented: $vmCart.showAlert,
                   actions: { Button("OK") { } },
                   message: { if let message = vmCart.alertMessage {
                       
                       Text(message)
                   }
            }
            )
            
        }
    }
    var checkOutButton: some View {
        
        NavigationLink {
           PaymentView()
        } label: {
                VStack {
                    Text("Total Bill:")
                        .font(.title2)
                        .fontWeight(.light)

                }
                Spacer()
                
                Text("$\(vmCart.totalPrice)")
                    .font(.title)
                    .fontWeight(.semibold)
                
                Image(systemName: "chevron.right")
                    .symbolEffect(.pulse)
                    .font(.title)
        }
        .disabled(vmCart.cartItems.isEmpty)
        .foregroundStyle(.white)
        .padding()
        .background(Color.button)
        .clipShape(.rect(cornerRadius: 20))
        .padding(.bottom, 40) // above tab bar
    }
       
    
    
}

//#Preview {
//    
//    
//    @StateObject var vmCart = CartViewModel()
//    
//    let food1 = MenuItem(
//        id: 5,
//        name: "Bread",
//        price: 3,
//        rating: 4.0,
//        image: "bread",
//        description: "Freshly baked bread with a crisp crust and soft interior.",
//        time: "15 min",
//        calories: 180,
//        category: .food
//    )
//    let food2 = MenuItem(
//        id: 6,
//        name: "Pizza",
//        price: 10,
//        rating: 4.6,
//        image: "pizza",
//        description: "Classic pizza with a variety of toppings and a crispy crust.",
//        time: "30 min",
//        calories: 400,
//        category: .food
//    )
//    
//    let item1 = CartItem(food: food1)
//    let item2 = CartItem(food: food2)
//    
//    vmCart.addItem(item1)
//    vmCart.addItem(item2)
//    
//    return CartView()
//        .environmentObject(vmCart)
//}
