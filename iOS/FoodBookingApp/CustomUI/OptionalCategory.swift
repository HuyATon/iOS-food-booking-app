//
//  FoodCategory.swift
//  TicketBookingApp
//
//  Created by HUY TON on 16/8/24.
//

import SwiftUI





struct OptionalCategory: View {
    
    let category: MenuItemCategory
    
    
    var body: some View {
        
        VStack(spacing: 40) {
            Text(category.rawValue.capitalized)
                .font(.subheadline)
                .fontDesign(.serif)
                .fontWeight(.semibold)
            Image(category.rawValue.lowercased())
                .resizable()
                .scaledToFit()
                .frame(width: 70, height: 70)
                .shadow(radius: 5)
        }

        .padding()
        .background(.ultraThinMaterial)
        .clipShape(RoundedRectangle(cornerRadius: 25))
        
        
    }
}

#Preview {
    OptionalCategory(category: .Drinks)
}
