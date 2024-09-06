//
//  FeedbackUI.swift
//  FoodBookingApp
//
//  Created by HUY TON on 6/9/24.
//

import SwiftUI



struct FeedbackUI: View {
    
    let feedback: UserFeedback

    var body: some View {
        VStack(alignment: .leading, spacing: 10) {
            
            
            HStack {
                Label(feedback.username, systemImage: "person.circle")
                Spacer()
                HStack (alignment: .top,spacing: 5) {
                    Text("\(feedback.rating)")
                    Image(systemName: "star.fill")
                        .foregroundStyle(.yellow)
                }
                .padding(5)
                .background(.ultraThickMaterial)
                .clipShape(.rect(cornerRadius: 5))

            }
            .font(.subheadline)
            
            
            
            Text(feedback.review)
                .fontWeight(.light)
                .font(.caption)
            
            HStack {
                Spacer()
                Text("at \(DateFormatConverter.getFormattedDate(date: feedback.createdAt, format: "HH:mm dd/MM/yyyy"))")
                    .font(.caption)
                    .fontWeight(.ultraLight)
            }
        }
        .padding()
        .background(.ultraThinMaterial)
        .overlay {
            RoundedRectangle(cornerRadius: 10)
               
                .strokeBorder(style: .init())
        }
        .padding(.vertical)
    }
}

