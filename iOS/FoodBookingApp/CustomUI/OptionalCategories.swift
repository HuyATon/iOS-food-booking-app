//
//  ScrollCategory.swift
//  TicketBookingApp
//
//  Created by HUY TON on 16/8/24.
//

import SwiftUI

struct OptionalCategories: View {
    
    @Binding var currentCategory: MenuItemCategory
    
    var body: some View {
        
        VStack {
            ScrollView(.horizontal) {
                HStack(spacing: 20) {
                    ForEach(MenuItemCategory.allCases, id: \.self) { category in
                        
                        if category != .All {
                            OptionalCategory(category: category)
                                .padding(.vertical)
                                .onTapGesture {
                                    withAnimation {
                                        if currentCategory == category {
                                            currentCategory = .All
                                        } else {
                                            currentCategory = category
                                        }
                                    }
                                }
                                .shadow(color: .black.opacity( currentCategory == category ? 1 : 0), radius: 5)
                        }
                        
                    }
                    .padding(.horizontal, 2)
                }
            }
            .scrollIndicators(.hidden)
        }
        
    }
}

#Preview {
    @State var currentCategory = MenuItemCategory.Food
    
    return OptionalCategories(currentCategory: $currentCategory)
}
