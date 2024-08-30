//
//  PaymentView.swift
//  FoodBookingApp
//
//  Created by HUY TON on 26/8/24.
//

import SwiftUI

struct BookingsView: View {
    
    @State var animateGradient = false
    @EnvironmentObject var vmBooking: BookingViewModel


    
    var body: some View {
        VStack {
            Text("Bookings")
                .font(.title)
                .fontWeight(.bold)
                .frame(maxWidth: .infinity)
            
            ScrollView {
                ForEach(vmBooking.bookings) { booking in
                    DisclosureGroup {
                        VStack (alignment: .leading, spacing: 15) {
                            HStack {
                                Label("Restaurant:", systemImage: "mappin").bold()
                                Text(booking.restaurantName)
                                    .lineLimit(1)
                                    .minimumScaleFactor(0.7)
                            }
                            HStack {
                                Label("Time:", systemImage: "clock").bold()
                                Text("21h30")
                            }
                            Text("Items").bold()
                            
                            ForEach(booking.orders, id: \.self) { order in
                                CustomOrder(order: order)
                            }
                            
                            Divider()
                            HStack {
                                Text("Sub Total:").bold()
                                Spacer()
                                Text("$\(booking.getTotalPrice())").bold()
                            }
                            .font(.title2)
                        
                        }
                        
                    } label: {
                        Label("Booking ID: \(booking.id)", systemImage: "basket")
                            .font(.title2)
                            .fontWeight(.semibold)
                            .foregroundStyle(Color.button)
                        
                    }
                    Divider()
                }
            }
            .frame(maxWidth: .infinity)
            .overlay {
                if vmBooking.isLoading {
                    ProgressView()
                }
            }
            .overlay (alignment: .center) {
                if vmBooking.bookings.isEmpty {
                    Text("You have no bookings before...")
                        .fontWeight(.light)
                        .foregroundStyle(.secondary)
                }
            }
            .padding()
            .background(.ultraThinMaterial)
            .clipShape(.rect(cornerRadius: 20))
            
            Spacer(minLength: 100)
            
        }
        .task {
            await vmBooking.getAllBookings()
        }
        
        .alert(
            "Booking Message",
            isPresented: $vmBooking.showAlert,
            actions: { Button("OK") { } },
            message: {
                if let message = vmBooking.alertMessage {
                    Text(message)
                }
            }
        )
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
    }
    

   
}

#Preview {
    @StateObject var vmBooking = BookingViewModel()

    return NavigationStack {
        BookingsView()
            .environmentObject(vmBooking)

    }
}
