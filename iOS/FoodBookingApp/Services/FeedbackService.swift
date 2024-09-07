//
//  FeedbackService.swift
//  FoodBookingApp
//
//  Created by HUY TON on 6/9/24.
//

import Foundation


struct Feedback: Encodable {
    
    let menuItemId: Int
    let rating: Int
    let review: String
}


struct FeedbackResponse: Decodable {
    
    let message: String
}

class FeedbackService {
    
    let feedbackURL = Constants.API.baseURL + "/booking/feedbacks"
    let token = AuthenticationService.token
    
    
    func sendFeedback(_ feedback: Feedback) async throws -> String {
        
        do {
            guard let url = URL(string: self.feedbackURL) else {
                throw NetworkError.invalidURL
            }
            do {
                var request = URLRequest(url: url)
                request.httpMethod = "POST"
                request.addValue("application/json", forHTTPHeaderField: "Content-Type")
                request.setValue("Bearer \(token)", forHTTPHeaderField: "Authorization")
                
                let body = try JSONEncoder().encode(feedback)
                
                request.httpBody = body
                
                let (data, response) = try await  URLSession.shared.data(for: request)
                
                guard let response = response as? HTTPURLResponse, response.statusCode == 200 else {
                    throw NetworkError.invalidResponse
                }
                
                guard let decodedData = try? JSONDecoder().decode(FeedbackResponse.self, from: data) else {
                    throw NetworkError.failedDecoding
                }
                return decodedData.message
            }
            catch {
                throw NetworkError.failedEncoding
            }
        }
        catch {
            throw NetworkError.dataTaskError(error.localizedDescription)
        }
    }
}
