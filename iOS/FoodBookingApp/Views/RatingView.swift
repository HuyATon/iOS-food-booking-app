//
//  RatingView.swift
//  FoodBookingApp
//
//  Created by HUY TON on 6/9/24.
//

import SwiftUI

struct RatingView: View {
    
    @EnvironmentObject var vmBooking: BookingViewModel
    @State private var text = ""
    @State private var rating = 5
    
    
    let order: Order
    
    
    var body: some View {
        VStack (alignment: .leading, spacing: 30) {
            Text("Feedback").font(.title).bold()
            
            itemInformation
            
            Text("👋 How Was Your Experience?").font(.headline)
            
            ratingSelectionField
            
            reviewField
 
            Spacer()
            
            reviewButton
            
            Spacer(minLength: 70)
        }
        .padding()
        .background(.ultraThinMaterial)
        .overlay {
            if vmBooking.isLoading {
                ProgressView()
            }
        }
        .alert(
            "Feedback Message",
            isPresented: $vmBooking.showAlert,
            actions: { Button("OK") { } },
            message: {
                if let message = vmBooking.alertMessage {
                    Text(message)
                }
            }
        )
    }
    
    
    var itemInformation: some View {
        HStack (alignment: .top, spacing: 20) {
            
            Image(order.image)
                .resizable()
                .scaledToFit()
                .frame(width: 70, height: 70)
                .shadow(color: .black, radius: 4)
                .padding()
                .background(.ultraThickMaterial)
                .overlay {
                    RoundedRectangle(cornerRadius: 10).stroke()
                }
            
            Text(order.itemName).bold().font(.title3)
                .padding()
        }
    }
    
    var reviewButton: some View {
        Button {
            Task {
                await vmBooking.sendFeedBack(Feedback(menuItemId: order.menuItemId, rating: self.rating, review: self.text))
            }
            
        } label: {
            Text("Send Reviews")
                .frame(maxWidth: .infinity)
                .padding()
                .background(Color.button)
                .foregroundStyle(.white)
                .clipShape(.rect(cornerRadius: 20))
                .font(.title3)
                .bold()
        }
    }
    
    var ratingSelectionField: some View {
        HStack {
            Text("Your Rating")
            Spacer()
            HStack {
                ForEach(1...5, id: \.self) { star in
                
                    Button {
                        withAnimation(.spring(response: 0.3, dampingFraction: 0.5, blendDuration: 0)) {
                            rating = star
                        }
                    } label: {
                        Image(systemName: rating >= star ? "star.fill" : "star")
                            .foregroundStyle(.yellow)
                            .scaleEffect(rating == star ? 1.5 : 1.0)
                            .symbolEffect(.bounce, value: rating)
                            .font(.title3)
                    }
                }
            }
        }
    }
    
    var reviewField: some View {
        TextEditor(text: $text)
                        .frame(height: 200)
                        .overlay (alignment: .topLeading) {
                            if text.isEmpty {
                                Text("Share your experience...").fontWeight(.ultraLight)
                                    .offset(x: 7, y: 7)
                            
                            }
                        }
                        .padding()
                        .overlay {
                            RoundedRectangle(cornerRadius: 20).stroke()
                        }
                        .background(.white)
    }
}

#Preview {
    NavigationStack {
        RatingView(order: Order(menuItemId: 1, itemName: "Coffee", image: "coffee", price: 15, quantity: 1))
            .fontDesign(.monospaced)
    }
}
