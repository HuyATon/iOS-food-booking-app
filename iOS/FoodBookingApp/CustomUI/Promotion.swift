//
//  PromotionItem.swift
//  TicketBookingApp
//
//  Created by HUY TON on 16/8/24.
//

import SwiftUI


struct PromotionItem: Identifiable {
    
    let id = UUID()
    
    let title: String
    let description: String
    let image: String
}

struct Promotion: View {
    
    let promotion: PromotionItem
    
    
    var body: some View {
        
        GeometryReader { geo in
            
            HStack {
                VStack(alignment: .leading) {
                    
                    Text(promotion.title.capitalized)
                        .font(.title2)
                        .fontWeight(.semibold)
                        .lineLimit(1)
                    Text(promotion.description.localizedCapitalized)
                        .lineLimit(2)
                }
                .minimumScaleFactor(0.7)
                
                
                Spacer(minLength: 150)
            }
            .frame(width: geo.size.width / 1.2, height: 60)
            .padding()
            .background(.ultraThickMaterial)
            .clipShape(.rect(cornerRadius: 25))
            .overlay(alignment: .topTrailing) {
                Image(promotion.image)
                    .resizable()
                    .scaledToFit()
                    .offset(x: -5, y: -20 )
                    .shadow(color: .black, radius: 8, x: -5, y: 5)
                    
            }
            .padding()
            .padding(.top, 20)
            
        }
    }
}

#Preview {
    @State var pmt = PromotionItem(title: "Free Donut!", description: "for orders over $20", image: "dessert")
    
    return Promotion(promotion: pmt)
}
