//
//  ItemViewModel.swift
//  TicketBookingApp
//
//  Created by HUY TON on 17/8/24.
//

import Foundation


@MainActor
class ItemsViewModel: ObservableObject {
    
    @Published var items: [MenuItem] = []
    @Published var restaurants: [Restaurant] = []
    
    @Published var userFeedbacks: [UserFeedback] = []
    
    @Published var searchText: String = ""
    @Published var currentCategory: MenuItemCategory = .All
    
    @Published var isLoading = false
    @Published var alertMessage: String?
    @Published var showAlert = false
    
    
    
    var filteredItems: [MenuItem] {
        
        if searchText.isEmpty {
            
            if currentCategory == .All {
                return items
            }
            else {
                return items.filter { $0.category == currentCategory}
            }
            
        }
        else {
            
            if currentCategory == .All {
                return items.filter { $0.name.lowercased().localizedCaseInsensitiveContains(searchText)}
            }
            else {
                return items
                    .filter { $0.category == currentCategory && $0.name.lowercased().localizedCaseInsensitiveContains(searchText)}
            }
        }
    }
    
    func fetchRestaurantsAndMenuItems() async {
        
        let fetchRestaurantsService = FetchService(fetchURL: Constants.API.baseURL + "/restaurants")
        let fetchItemsService = FetchService(fetchURL: Constants.API.baseURL + "/menu-items")
                                                  
        self.isLoading.toggle()
        
        defer {
            self.isLoading.toggle()
        }
        
        do {
            async let fetchedRestaurant: [Restaurant] = fetchRestaurantsService.getJSON(keyDecodingStrategy: .convertFromSnakeCase)
            async let fetchedItems: [MenuItem] = fetchItemsService.getJSON(keyDecodingStrategy: .convertFromSnakeCase)
                        
            self.restaurants = try await fetchedRestaurant
            self.items = try await fetchedItems
        }
        
        catch {
            print(error.localizedDescription)
            self.alertMessage = error.localizedDescription
            self.showAlert = true
        }
    }
    
    func fetchFeedbacksOfItem(_ item: MenuItem) async  {
        
        isLoading.toggle()
        
        defer {
            isLoading.toggle()
        }
        
        let fetcher = FetchService(fetchURL: Constants.API.baseURL + "/menu-items/\(item.id)/feedbacks")
        print(fetcher.fetchURL)
        
        do {
            
            let dateDecodingStrategy: JSONDecoder.DateDecodingStrategy = .custom({ decoder in
                let container = try decoder.singleValueContainer()
                let dateString = try container.decode(String.self)
                let formatter = ISO8601DateFormatter()
                formatter.formatOptions = [.withInternetDateTime, .withFractionalSeconds]
                return formatter.date(from: dateString)!
            })

            
            var fetchedFeedbacks: [UserFeedback] = try await fetcher.getJSON(keyDecodingStrategy: .convertFromSnakeCase, dateDecodingStrategy: dateDecodingStrategy)
            fetchedFeedbacks.sort { $0.createdAt > $1.createdAt}
            self.userFeedbacks = fetchedFeedbacks
        }
        catch {
            print(error.localizedDescription)
            self.alertMessage = error.localizedDescription
            self.showAlert = true
        }
    }
}
