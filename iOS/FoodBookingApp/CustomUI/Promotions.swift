//
//  Promotion.swift
//  TicketBookingApp
//
//  Created by HUY TON on 16/8/24.
//

import SwiftUI




struct Promotions: View {
    
    @State var selectedIndex = 0
    
    var promotions = [PromotionItem(title: "Free Donut!", description: "for order over $20", image: "specialDonut"),
                       PromotionItem(title: "Free Upsizing", description: "for any coffee today", image: "specialCoffee"),
                       PromotionItem(title: "Free Delivery", description: "for pizza orders over $10", image: "specialPizza")]
    
    
    private let timer = Timer.publish(every: 3, on: .main, in: .common).autoconnect()
    
    var body: some View {
        VStack(alignment: .leading) {
            Text("Today Special!")
                .font(.largeTitle)
                .fontWeight(.bold)
                .offset(y: 30)
            
            TabView(selection: $selectedIndex) {
                
                ForEach(promotions.indices) { index in
                        
                    Promotion(promotion: promotions[index])
                        .tag(index)
                }
                
            }
            .tabViewStyle(.page(indexDisplayMode: .never))
            .frame(height: 150)
            .onReceive(timer, perform: { _ in
                withAnimation(.easeInOut) {
                    selectedIndex = (selectedIndex + 1) % promotions.count
                }
            })
        }        
    }
}

#Preview {

    
    return Promotions()
}
