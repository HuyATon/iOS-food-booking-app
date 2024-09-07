//
//  Order.swift
//  FoodBookingApp
//
//  Created by HUY TON on 28/8/24.
//

import Foundation

// FIXME: Change price to Int

struct Order: Codable, Hashable {
    
    let menuItemId: Int
    let itemName: String
    let image: String
    let price: Int
    let quantity: Int
}
