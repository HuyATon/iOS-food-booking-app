//
//  Food.swift
//  TicketBookingApp
//
//  Created by HUY TON on 17/8/24.
//

import Foundation



enum MenuItemCategory: String, CaseIterable, Decodable  {
    
    case All = "All"
    case Food = "Food"
    case Drinks = "Drinks"
    case Dessert = "Dessert"
    
}

struct MenuItem: Identifiable, Equatable, Hashable, Decodable {
    
    let id: Int
    let restaurantId: Int
    let name: String
    let image: String
    let category: MenuItemCategory
    let rating: Double
    let description: String
    let price: String
    
    let restaurantName: String
    let address: String
}
