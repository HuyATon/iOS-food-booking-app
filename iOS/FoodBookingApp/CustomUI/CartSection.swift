//
//  CartSection.swift
//  TicketBookingApp
//
//  Created by HUY TON on 17/8/24.
//

import SwiftUI

struct CartSection: View {
    
    @Binding var cartItem: CartItem
    
    var body: some View {
        

        VStack (alignment: .leading, spacing: 0) {
            HStack {
//              MARK: This is used for deployment
//                AsyncImage(url: URL(string: cartItem.menuItem.image)!) { image in
//                
//                    image
//                        .resizable()
//                        .scaledToFit()
//                        .frame(width: 60, height: 60)
//                        .shadow(color: .black, radius: 5)
//                        .padding(.bottom, 20)
//                        .padding(.leading, 10)
//                } placeholder: {
//                    ProgressView()
//                }
                Image(cartItem.menuItem.image)
                    .resizable()
                    .scaledToFit()
                    .frame(width: 60, height: 60)
                    .shadow(color: .black, radius: 5)
                    .padding(.bottom, 20)
                    .padding(.leading, 10)
                    
                        Spacer(minLength: 20)
                
                        VStack(alignment: .leading, spacing: 10) {
                            
                            Text(cartItem.menuItem.name)
                                .font(.headline)
                                .lineLimit(1)
                                .minimumScaleFactor(0.7)
                            
                            Stepper {
                                Text("Quantity: x\(cartItem.quantity)")
                                    
                            } onIncrement: {
                                cartItem.increaseQuantity()
                            } onDecrement: {
                                
                                if cartItem.quantity != 1 {
                                    cartItem.decreaseQuantity()
                                }
                            }
                            .font(.caption)
 
                            Divider()
                            
                            Text("$\(cartItem.menuItem.price)")
                                .font(.subheadline)
                                .fontWeight(.semibold)
                        }
                }
            }
        .frame(width: 300, height: 150)
        .padding(.leading, 10)

    }
}

//#Preview {
//    let food = MenuItem(id: 1, name: "Vegetarian Soup", price: 20, rating: 4.7, image: "vegetarian_soup", description: "A hearty vegetarian soup filled wihh vegetarian soup filled with fresh vegetables, tender beans, and aromatic herbs in a rich, flavorful broth. Perfect for a cozy, nourishing meal.", time: "10-15 mins", calories: 80, category: .food
//    )
//    
//    @State var cartItem = CartItem(food: food)
//    
//    return CartSection(cartItem: $cartItem)
//}
