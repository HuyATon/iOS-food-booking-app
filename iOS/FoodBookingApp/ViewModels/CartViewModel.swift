//
//  CartViewModel.swift
//  TicketBookingApp
//
//  Created by HUY TON on 17/8/24.
//

import Foundation


@MainActor
class CartViewModel: ObservableObject {
    
    @Published var cartItems: [CartItem] = []
    
    @Published var showAlert = false
    @Published var alertMessage: String?
    
    
    var totalPrice: Int {
        cartItems.reduce(0) {$0 + $1.totalPrice}
    }
    
    func removeItem(at offsets: IndexSet) {
        
        cartItems.remove(atOffsets: offsets)
    }
    
    func addItem(_ item: CartItem) {
        
        if let index = cartItems.firstIndex(where: { $0.id == item.id}) {
            
            cartItems[index].increaseQuantity()
        }
        else {
            cartItems.append(item)
        }
        
        
        alertMessage = "\(item.menuItem.name) has been added to your Cart"
        showAlert = true
    }
    
    func placeOrder() async {
        
        let bookingService = BookingService()
        
        do {
            
            let message = try await bookingService.book(cartItems: self.cartItems)
            self.alertMessage = message
            self.showAlert = true
            self.cartItems = []
            
        }
        catch  {
            
            self.alertMessage = error.localizedDescription
            self.showAlert = true
        }
    }
}
