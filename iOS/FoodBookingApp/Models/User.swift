//
//  User.swift
//  TicketBookingApp
//
//  Created by HUY TON on 14/8/24.
//

import Foundation


struct User: Codable {
    
    let username: String
    var fullname: String?
    var phoneNumber: String?
    var address: String?
    let email: String
    
    var latitude : Double?
    var longitude : Double?
    var token: String

    
    // MARK: Intents
    
    mutating func updateProfile(fullname: String, phoneNumber: String, address: String, latitude: Double, longitude: Double) {
        
        self.fullname = fullname
        self.phoneNumber = phoneNumber
        self.address = address
        self.latitude = latitude
        self.longitude = longitude
    }
    
    mutating func setToken(_ newToken: String) {
        self.token = newToken
    }
    
}
