//
//  Order.swift
//  FoodBookingApp
//
//  Created by HUY TON on 28/8/24.
//

import Foundation

// FIXME: Change price to Int

struct Order: Codable, Hashable {
    
    let itemName: String
    let image: String
    let price: String
    let quantity: Int
}
