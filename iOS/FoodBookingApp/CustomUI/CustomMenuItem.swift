//
//  CustomFood.swift
//  TicketBookingApp
//
//  Created by HUY TON on 17/8/24.
//

import SwiftUI

struct CustomMenuItem: View {
    
    let menuItem: MenuItem
    
    var body: some View {
        
        VStack {
            Image(menuItem.image)
            
                .resizable()
                .scaledToFit()
                .frame(width: 80, height: 80)
                .shadow(color: .black, radius: 2)
                .padding()
                .background(.ultraThinMaterial)
                .clipShape(.rect(cornerRadius: 20))
                
                
            Text(menuItem.name)
                .font(.headline)
                .lineLimit(1)
                .minimumScaleFactor(0.7)
                
            Text("$\(menuItem.price)")
                .font(.subheadline)
                .fontWeight(.light)

        }
        .foregroundStyle(.black)
    }
}

