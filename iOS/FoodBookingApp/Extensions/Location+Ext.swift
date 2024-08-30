//
//  Location+DefaultLocation.swift
//  TicketBookingApp
//
//  Created by HUY TON on 19/8/24.
//

import Foundation
import MapKit


extension MKCoordinateSpan {
    
    static var initialSpan: MKCoordinateSpan {
        
        return .init(latitudeDelta: 0.0005, longitudeDelta: 0.0005)
    }
}

extension CLLocationCoordinate2D {
    static var defaultLocation: CLLocationCoordinate2D {
        
        // 10.028224, 105.773496
        .init(latitude: 10.028224, longitude: 105.773496)
    }
}
