//
//  BookingViewModel.swift
//  FoodBookingApp
//
//  Created by HUY TON on 28/8/24.
//

import Foundation


@MainActor
class BookingViewModel: ObservableObject {
    
    @Published var bookings: [Booking] = []
    @Published var showAlert = false
    @Published var alertMessage: String?
    @Published var isLoading = false
    
    
    
    func getAllBookings() async {
        
        self.isLoading.toggle()
        defer {
            self.isLoading.toggle()
        }
        
        let bookingService = BookingService()
        
        do {
            let fetchedBooking = try await bookingService.getAllBooking()
            self.bookings = fetchedBooking
        }
        catch {
            
            alertMessage = error.localizedDescription
            showAlert = true
        }
    }
}
