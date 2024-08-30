//
//  CustomSearchBar.swift
//  TicketBookingApp
//
//  Created by HUY TON on 16/8/24.
//

import SwiftUI

struct CustomSearchBar: View {
    
    @Binding var searchText: String
    
    var body: some View {
        HStack {
            
            Image(systemName: "magnifyingglass")
                .fontWeight(.semibold)
            
            TextField("Search", text: $searchText)
                .fontWeight(.light)
                .fontDesign(.monospaced)
                .autocorrectionDisabled()
                .textInputAutocapitalization(.never)
            
        }
        .padding()
        .background(.ultraThickMaterial)
        .font(.subheadline)
        
        .clipShape(.rect(cornerRadius: 25))
    }
}

#Preview {
    EmptyView()
}
