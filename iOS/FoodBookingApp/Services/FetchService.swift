//
//  FetchService.swift
//  FoodBookingApp
//
//  Created by HUY TON on 27/8/24.
//

import Foundation


class FetchService {
    
    let fetchURL: String
    
    init(fetchURL: String) {
        self.fetchURL = fetchURL
    }
    
    
    
    func getJSON<T: Decodable> (
        keyDecodingStrategy: JSONDecoder.KeyDecodingStrategy = .useDefaultKeys) async throws -> T {
                    
            guard let url = URL(string: self.fetchURL) else {
                throw NetworkError.invalidURL
            }
            do {
                let (data, res) = try await URLSession.shared.data(from: url)
                
                guard let res = res as? HTTPURLResponse, res.statusCode == 200 else {
                    throw NetworkError.invalidResponse
                }
                
                let decoder = JSONDecoder()
                decoder.keyDecodingStrategy = keyDecodingStrategy
                
                do {
                    let decodedData = try decoder.decode(T.self, from: data)
                    
                    return decodedData
                }
                catch {
                    throw NetworkError.failedDecoding
                }
            }
            catch {
                throw NetworkError.dataTaskError("Failed at data task")
            }
        
    }
    
}
