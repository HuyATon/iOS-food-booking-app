//
//  CustomTabBar.swift
//  TicketBookingApp
//
//  Created by HUY TON on 15/8/24.
//

import SwiftUI

enum Tab: String, CaseIterable {
    
    case home
    case cart
    case booking
    case profile
    
    var icon: String {
        switch self {
        case .home:
            "house"
        case .cart:
            "cart"
        case .booking:
            "shippingbox"
        case .profile:
            "person"
        }
    }
    
    var filledIcon: String {
        switch self {
        case .home:
            "house.fill"
        case .cart:
            "cart.fill"
        case .booking:
            "shippingbox.fill"
        case .profile:
            "person.fill"
        }
    }
}


struct CustomTabBar: View {
    
    @Binding var currentTab: Tab
    
//    let numberOfCartItems: Int
    
    var body: some View {
        VStack {
            HStack(spacing: 0) {            
                ForEach(Tab.allCases, id: \.self) { tab in
                    
                    Button {
                        withAnimation {
                            currentTab = tab
                        }
                    } label: {
                        VStack {
                            Image(systemName: currentTab == tab ? tab.filledIcon : tab.icon)
                                .frame(maxWidth: .infinity)
                                .font(.title)
//                                .overlay (alignment: .topTrailing){
//                                    if tab == .cart {
//                                        Text(numberOfCartItems, format: .number)
//                                            .font(.caption2)
//                                            .foregroundStyle(.white)
//                                            .padding(5)
//                                            .background(Circle().fill(.red))
//                                            .offset(x: -32, y: -12)
//                                           
//                                    }
//                                }
                            Text(tab.rawValue.capitalized)
                                .font(.caption)
                                .fontWeight(.semibold)
                                .fontDesign(.monospaced)
                        }
                        .offset(y: (tab == currentTab) ? -10 : 0)
                        .foregroundStyle( (tab == currentTab) ? Color.button : .gray)
                    }
                }
            }
        }
        .frame(height: 80)
        .background(.ultraThickMaterial)
        .clipShape(.capsule)

    }
    
}

//#Preview {
//    MainView()
//}
