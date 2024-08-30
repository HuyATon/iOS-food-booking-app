//
//  AuthServices.swift
//  TicketBookingApp
//
//  Created by HUY TON on 14/8/24.
//

import Foundation


// MARK: - Error

enum NetworkError: Error, LocalizedError {
    
    case invalidURL
    case invalidResponse
    case invalidToken
    case failedDecoding
    case serverError(String)
    case dataTaskError(String)
    case failedEncoding
    
    var errorDescription: String? {
        switch self {
        case .invalidURL:
            NSLocalizedString("The url is invalid", comment: "")
            
        case .invalidResponse:
            NSLocalizedString("The server returned invalid response", comment: "")
            
        case .invalidToken:
            NSLocalizedString("The token is expired", comment: "")
            
        case .failedDecoding:
            NSLocalizedString( "Failed to decoding the data", comment: "")
        case .failedEncoding:
            NSLocalizedString( "Failed to encoding the data", comment: "")
           
        case .serverError(let string):
            NSLocalizedString(string, comment: "")
            
        case .dataTaskError(let string):
            NSLocalizedString(string, comment: "")
            
        }
    }
}


// MARK: - Resquest, Response
struct LoginRequestBody: Codable {
    let username: String
    let password: String
}

struct LoginResponse: Codable {
    let message: String
    let success: Bool
}

struct RegisterRequestBody: Codable {
    let username: String
    let password: String
    let email: String
}

struct RegisterResponse: Codable {
    let message: String
}


class AuthenticationService {
    
    static let shared = AuthenticationService()
    static var token = ""
    
    private init() { }
    
    func login(username: String, password: String) async throws -> User {
        
        guard let url = URL(string: Constants.API.baseURL + "/auth/login") else {
            throw NetworkError.invalidURL
        }
        
        let body = LoginRequestBody(username: username, password: password)
        
        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        request.httpBody = try? JSONEncoder().encode(body)
        
        
  
        let (data, response) = try await URLSession.shared.data(for: request)
        
        guard let response = response as? HTTPURLResponse, response.statusCode == 200 else {
            throw NetworkError.invalidResponse
        }
        let decoder = JSONDecoder()
        
        guard let user = try? decoder.decode(User.self, from: data) else {
            
            guard let decodedData = try? decoder.decode(LoginResponse.self, from: data) else {
                
                throw NetworkError.failedDecoding
            }
            
            throw NetworkError.serverError(decodedData.message)
        }
        
        
        AuthenticationService.token = user.token
        return user
    }
    
  
    
    
    func register(username: String, password: String, email: String) async throws -> String {
        
        guard let url = URL(string: Constants.API.baseURL + "/auth/register") else {
            throw NetworkError.invalidURL
        }
        
        let body = RegisterRequestBody(username: username, password: password, email: email)
        
        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        request.httpBody = try? JSONEncoder().encode(body)
        
        let (data, response) = try await URLSession.shared.data(for: request)
        
       
        guard let response = response as? HTTPURLResponse else {
            throw NetworkError.invalidResponse
        }
        
        let decoder = JSONDecoder()
        
        guard let decodedData = try? decoder.decode(RegisterResponse.self, from: data) else {
            throw NetworkError.failedDecoding
        }
        
        switch response.statusCode {
            
        case 201:
            return decodedData.message
            
        default:
            throw NetworkError.serverError(decodedData.message)
        }
       
    }
}



