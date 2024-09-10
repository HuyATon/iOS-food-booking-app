//
//  CustomOrder.swift
//  FoodBookingApp
//
//  Created by HUY TON on 28/8/24.
//

import SwiftUI

struct CustomOrder: View {
    
    let order: Order
    var body: some View {
        HStack (spacing: 30) {
//        MARK: this is used in deployment
//            AsyncImage(url: URL(string: order.image)!) { image in
//            
//                image
//                    .resizable()
//                    .scaledToFit()
//                    .frame(width: 70, height: 70)
//                    .shadow(color: .black, radius: 4)
//                    .padding()
//                    .background(.ultraThickMaterial)
//                    .clipShape(.rect(cornerRadius: 10))
//            } placeholder: {
//                ProgressView()
//            }
            
            Image(order.image)
                .resizable()
                .scaledToFit()
                .frame(width: 70, height: 70)
                .shadow(color: .black, radius: 4)
                .padding()
                .background(.ultraThickMaterial)
                .clipShape(.rect(cornerRadius: 10))
                
            VStack (alignment: .leading, spacing: 15) {
                Text(order.itemName)
                    .fontWeight(.semibold)
                Text("Quantity: x\(order.quantity)")
                    .font(.caption)
                Text("Unit Price: $\(order.price)")
                    .font(.caption)
            }
            .foregroundStyle(.black)
            Spacer()
            
        }
    }
}

