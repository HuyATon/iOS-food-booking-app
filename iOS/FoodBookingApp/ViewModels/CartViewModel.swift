//
//  CartViewModel.swift
//  TicketBookingApp
//
//  Created by HUY TON on 17/8/24.
//

import Foundation


@MainActor
class CartViewModel: ObservableObject {
    
    @Published var cartItems = [CartItem]()
    
    @Published var showAlert = false
    @Published var alertMessage: String?
    
    
    @Published var showCheckOutAlert = false
    @Published var checkOutMessage: String?
    
    
    
    var totalPrice: Int {
        cartItems.reduce(0) {$0 + $1.totalPrice}
    }
    
    func removeItem(at offsets: IndexSet) {
        
        cartItems.remove(atOffsets: offsets)
    }
    
    func addItem(_ item: CartItem) {
        
        defer {
            alertMessage = "\(item.menuItem.name) has been added to your Cart"
            showAlert = true
        }
        
        if let index = cartItems.firstIndex(where: { $0.id == item.id}) {
            
            cartItems[index].increaseQuantity()
        }
        else {
            cartItems.append(item)
        }
        
        
        
    }
    
    func placeOrder() async {
        
        let bookingService = BookingService()
        
        defer {
            self.showCheckOutAlert = true
        }
        
        do {
            
            let message = try await bookingService.book(cartItems: self.cartItems)
            self.checkOutMessage = message
            self.cartItems.removeAll()
        }
        catch  {
            self.checkOutMessage = error.localizedDescription
        }
    }
}
