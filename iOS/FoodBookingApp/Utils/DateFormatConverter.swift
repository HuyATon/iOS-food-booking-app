//
//  DateFormatter.swift
//  FoodBookingApp
//
//  Created by HUY TON on 7/9/24.
//

import Foundation


class DateFormatConverter {
    
    
    private init() {}
    
    static var shared = DateFormatConverter()

    
    public static func getFormattedDate(date: Date, format: String) -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = format // Customize format as needed
        // 05 Sep
        return dateFormatter.string(from: date)
    }
}
