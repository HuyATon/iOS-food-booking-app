//
//  RegisterViewModel.swift
//  TicketBookingApp
//
//  Created by HUY TON on 14/8/24.
//

import Foundation

@MainActor
class RegisterViewModel: ObservableObject {
    
    @Published var isLoading = false
    
    @Published var showAlert = false
    @Published var alertMessage: String?
    
    
    func register(username: String, password: String, email: String) async  {
        
        let authService = AuthenticationService.shared
        
        self.isLoading.toggle()
        
        defer {
            self.isLoading.toggle()
        }
        do {
            let successMessage = try await authService.register(username: username, password: password, email: email)
            self.showAlert = true
            self.alertMessage = successMessage
        }
        catch {
            self.showAlert = true
            self.alertMessage = error.localizedDescription
            
        }
    }
}
