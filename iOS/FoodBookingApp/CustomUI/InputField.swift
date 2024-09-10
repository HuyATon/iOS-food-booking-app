//
//  InputField.swift
//  FoodBookingApp
//
//  Created by HUY TON on 9/9/24.
//

import SwiftUI

struct InputField: View {
    
    @Binding var text: String
    let systemIcon: String
    let placeholder: String
    
    var body: some View {
        VStack(alignment: .leading) {
            
            if !text.isEmpty {
                Label(placeholder, systemImage: systemIcon)
                    .fontWeight(.semibold)
                    .transition(.slide)
            }
            
            TextField(placeholder, text: $text)
                .padding()
                .background(.ultraThinMaterial)
                .clipShape(.capsule)
                .textInputAutocapitalization(.never)
                .autocorrectionDisabled()
        }
        .animation(.snappy, value: text)
    }
}

struct SecuredInputField: View {
    
    @Binding var text: String
    let systemIcon: String
    let placeholder: String
    
    var body: some View {
        VStack(alignment: .leading) {
            
            if !text.isEmpty {
                Label(placeholder, systemImage: systemIcon)
                    .fontWeight(.semibold)
                    .transition(.slide)
            }
            
            SecureField(placeholder, text: $text)
                .padding()
                .background(.ultraThinMaterial)
                .clipShape(.capsule)
                
        }
        .animation(.snappy, value: text)
    }
}
