//
//  Restaurant.swift
//  FoodBookingApp
//
//  Created by HUY TON on 27/8/24.
//

import Foundation


struct Restaurant: Decodable {
    
    let id: Int
    let name: String
    let address: String
    let phoneNumber: String
    let description: String
}
