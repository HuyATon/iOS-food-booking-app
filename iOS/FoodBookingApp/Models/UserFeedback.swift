//
//  UserFeedback.swift
//  FoodBookingApp
//
//  Created by HUY TON on 7/9/24.
//

import Foundation

struct UserFeedback: Codable, Hashable {

    let username: String
    let rating: Int
    let review: String
    let createdAt: Date
    

}
