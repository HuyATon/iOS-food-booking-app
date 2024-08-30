//
//  PaymentView.swift
//  FoodBookingApp
//
//  Created by HUY TON on 26/8/24.
//

import SwiftUI

struct PaymentView: View {
    
    @State var animateGradient = false
    @EnvironmentObject var vmCart: CartViewModel
    @EnvironmentObject var vmUser: UserViewModel
    
    var body: some View {
        VStack {
            userProfile
            ScrollView {
                ForEach($vmCart.cartItems){ $cartItem in
                    
                    CartSection(cartItem: $cartItem)
                }
            }
            Divider()
            HStack {
                
                Text("Sub Total:")
                    .font(.title2)
                Spacer()
                Text("$\(vmCart.totalPrice)")
                    .font(.title)
                    .fontWeight(.bold)
            }
            
            
            Button("Place Order") {
                Task {
                    await vmCart.placeOrder()
                }
            }
            .frame(maxWidth: .infinity)
            .foregroundStyle(.white)
            .font(.title)
            .fontWeight(.semibold)
            .padding()
            .background(Color.button)
            .clipShape(.rect(cornerRadius: 15))

            
            
        }
        .alert(
            "Booking Message", 
            isPresented: $vmCart.showAlert,
            actions: { Button("OK") { } },
            message: {
                if let message = vmCart.alertMessage {
                    Text(message)
                }
            }
        )
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
        .navigationTitle("Shopping Cart")
        .navigationBarTitleDisplayMode(.inline)
    }
    
    
    var userProfile: some View {
        VStack(alignment: .leading, spacing: 15) {
            HStack {
                Label("Full-name:", systemImage: "person")
                    .fontWeight(.semibold)
                Text(vmUser.user?.username ?? "...")
                Spacer()
            }
            HStack {
                Label("Address:", systemImage: "map")
                    .fontWeight(.semibold)
                Text(vmUser.user?.address ?? "...")
                Spacer()
            }
            HStack {
                Label("Phone:", systemImage: "phone")
                    .fontWeight(.semibold)
                Text(vmUser.user?.phoneNumber ?? "...")
                Spacer()
            }
        }
        .padding()
        .background(.ultraThinMaterial)
        .clipShape(.rect(cornerRadius: 20))
    }
}

#Preview {
    @StateObject var vmCart = CartViewModel()
    @StateObject var vmUser = UserViewModel()

    return NavigationStack {
        PaymentView()
            .environmentObject(vmCart)
            .environmentObject(vmUser)
    }
}
