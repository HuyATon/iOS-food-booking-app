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
                    .filter { $0.category == currentCategory}
                    .filter { $0.name.lowercased().localizedCaseInsensitiveContains(searchText)}
            }
        }
    }
    
    func fetchRestaurantsAndMenuItems() async {
        
        let fetchRestaurantsService = FetchService(fetchURL: Constants.API.baseURL + "/restaurants")
        let fetchItemsService = FetchService(fetchURL: Constants.API.baseURL + "/menuItems")
                                                  
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
            self.alertMessage = error.localizedDescription
            self.showAlert = true
        }
    }
}
