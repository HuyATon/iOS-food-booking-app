//
//  Bookings.swift
//  FoodBookingApp
//
//  Created by HUY TON on 28/8/24.
//

import Foundation

struct Booking: Codable, Identifiable {
    
    let id: Int
    let restaurantName: String
    let orders: [Order]
    
    
    func getTotalPrice() -> Int {
        return orders.reduce(0, { $0 + Int($1.price)! * $1.quantity})
    }
}
