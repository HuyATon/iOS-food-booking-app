//
//  Router.swift
//  FoodBookingApp
//
//  Created by HUY TON on 21/8/24.
//

import SwiftUI

class Router: ObservableObject {
    
    @Published var path = NavigationPath()
    
    
    func reset() {
        
        path = NavigationPath()
    }
    
}
