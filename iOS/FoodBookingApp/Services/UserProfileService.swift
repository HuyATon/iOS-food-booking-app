//
//  UserProfileService.swift
//  TicketBookingApp
//
//  Created by HUY TON on 20/8/24.
//

import Foundation


// MARK: - Resquest, Response
struct UpdateRequestBody: Codable {

    let fullname: String
    let phoneNumber: String
    let latitude: Double
    let longitude: Double
    let address: String
}

struct UpdateResponse: Codable {
    
    let message: String
    let success: Bool
}




class UserProfileService {
    
    static let shared = UserProfileService()
    
    private init() {}
    
    

    func updateProfile(
        token: String,
        username: String,
        fullname: String,
        phoneNumber: String,
        address: String,
        latitude: Double,
        longitude: Double
                       
    ) async throws -> String {

        
        guard let url = URL(string: Constants.API.baseURL + "/profile/\(username)") else {
            throw NetworkError.invalidURL
        }
        let requestBody = UpdateRequestBody( fullname: fullname, phoneNumber: phoneNumber, latitude: latitude, longitude: longitude, address: address)
        
        var request = URLRequest(url: url)
        request.httpMethod = "PATCH"
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        request.setValue("Bearer \(token)", forHTTPHeaderField: "Authorization")
        request.httpBody = try? JSONEncoder().encode(requestBody)
        
     
        let (data, response) = try await URLSession.shared.data(for: request)
        
        guard let response = response as? HTTPURLResponse else {
            
            throw NetworkError.invalidResponse
        }
        
        let decoder = JSONDecoder()
    
        guard let decodedData = try? decoder.decode(UpdateResponse.self, from: data) else {
            throw NetworkError.failedDecoding
        }
        print("Status code:", response.statusCode)
        switch response.statusCode {
        case 200:
            return decodedData.message
            
        case 401:
            throw NetworkError.invalidToken
            
        case 500:
            throw NetworkError.serverError("Server is suffering from errors")
            
        default:
            throw NetworkError.serverError("Server is suffering from errors")
        }
     }
}
