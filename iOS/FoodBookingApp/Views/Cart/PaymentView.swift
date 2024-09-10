//
//  PaymentView.swift
//  FoodBookingApp
//
//  Created by HUY TON on 26/8/24.
//

import SwiftUI

struct PaymentView: View {
    
    @State private var animateGradient = false
    
    @EnvironmentObject var vm: ViewModel
    @EnvironmentObject var vmCart: CartViewModel
    
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
                
                Text("Total:")
                    .font(.title2)
                Spacer()
                Text("$\(vmCart.totalPrice)")
                    .font(.title)
                    .fontWeight(.bold)
                    .monospaced()
            }
            
            
            
            Button("Place Order") {
                Task {
                    await vmCart.placeOrder()
                }
            }
            .frame(maxWidth: .infinity)
            .foregroundStyle(.white)
            .font(.title2)
            .fontWeight(.semibold)
            .padding()
            .background(vm.isValidProfile ? Color.button : .secondary)
            .clipShape(.rect(cornerRadius: 15))
            .disabled(!vm.isValidProfile)
            .opacity(vm.isValidProfile ? 1 : 0.7)
            
        }
        .alert(
            "Booking Message", 
            isPresented: $vmCart.showCheckOutAlert,
            actions: { Button("OK") { } },
            message: {
                if let message = vmCart.checkOutMessage {
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
        .onAppear {
            withAnimation(.snappy) {
                vm.hideTabBar()
            }
        }
        .onDisappear {
            vm.displayTabBar()
        }
    }
    
    
    var userProfile: some View {
        VStack(alignment: .leading, spacing: 15) {
            HStack {
                Label("Full-name:", systemImage: "person")
                    .fontWeight(.semibold)
                Text(vm.user?.username ?? "...")
                Spacer()
            }
            HStack {
                Label("Address:", systemImage: "map")
                    .fontWeight(.semibold)
                Text(vm.user?.address ?? "...")
                Spacer()
            }
            HStack {
                Label("Phone:", systemImage: "phone")
                    .fontWeight(.semibold)
                Text(vm.user?.phoneNumber ?? "...")
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
    @StateObject var vmUser = ViewModel()

    return NavigationStack {
        PaymentView()
            .environmentObject(vmCart)
            .environmentObject(vmUser)
    }
}
