//
//  LoginViewModel.swift
//  TicketBookingApp
//
//  Created by HUY TON on 14/8/24.
//

import Foundation


enum AuthenticationStatus {
    
    case valid
    case invalid
}



@MainActor
class UserViewModel: ObservableObject {
    
    @Published var user: User?
    @Published var isLoading = false
    
    
    @Published var errorLogInMessage: String?
    @Published var showLoginAlert = false
    
    @Published var authenticationStatus = AuthenticationStatus.invalid
    
    
    @Published var showUpdateAlert = false
    @Published var errorUpdateMessage: String?

    
    func login(username: String, password: String) async  {
        
        let authService = AuthenticationService.shared
        
        isLoading.toggle()
        
        defer {
            isLoading.toggle()
        }
        
        do {
            
            let user = try await authService.login(username: username, password: password)
            self.user = user
            self.authenticationStatus = .valid
        }
        catch {
            showLoginAlert = true
            errorLogInMessage = error.localizedDescription
        }
    }
    
    func updateProfile(
        fullname: String,
        phoneNumber: String,
        address: String,
        birthday: Date,
        latitude: Double,
        longitude: Double
                       
    ) async {
        
        let updateProfileService = UserProfileService.shared
        
        self.isLoading.toggle()
        
        defer {
            self.isLoading.toggle()
        }
        
        do {
            
            
            let successMessage = try await updateProfileService.updateProfile(
                token: user!.token,
                username: user!.username,
                fullname: fullname,
                phoneNumber: phoneNumber,
                address: address,
                birthday: birthday,
                latitude: latitude,
                longitude: longitude)
            
            
            self.user!.updateProfile(fullname: fullname, phoneNumber: phoneNumber, address: address, latitude: latitude, longitude: longitude)
            
            self.showUpdateAlert = true
            self.errorUpdateMessage = successMessage
            
        }
        catch {
            
            switch error {
                
            case NetworkError.invalidToken:
                self.authenticationStatus = .invalid
            default:
                break
            }
            self.showUpdateAlert = true
            self.errorUpdateMessage = error.localizedDescription
        }
    }

    
}
