//
//  CartItem.swift
//  TicketBookingApp
//
//  Created by HUY TON on 17/8/24.
//

import Foundation





struct CartItem: Identifiable {
    

    
    let menuItem: MenuItem
    var quantity: Int = 1
    
    
    var id: Int {
        menuItem.id
    }
    
    
    init(food: MenuItem) {
        
        self.menuItem = food
    }
    
    
    
    var totalPrice: Int {
        Int(menuItem.price)! * quantity
    }
    
    
    mutating func decreaseQuantity() {
        quantity -= 1
    }
    
    mutating func increaseQuantity() {
        quantity += 1
    }
        
}
