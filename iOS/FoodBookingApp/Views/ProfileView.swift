//
//  ProfileView.swift
//  FoodBookingApp
//
//  Created by HUY TON on 21/8/24.
//

import SwiftUI
import MapKit

struct ProfileView: View {
    
    @EnvironmentObject var vmUser : UserViewModel
    @EnvironmentObject var vmMap: MapViewModel
    @State var animateGradient = false
    
    var body: some View {
        NavigationStack {
            GeometryReader { geo in
                VStack(spacing: 25) {
                    
                    Text("Profile")
                        .font(.title)
                        .fontWeight(.bold)
                    
                    Image("avatar")
                        .resizable()
                        .scaledToFit()
                        .frame(width: geo.size.width / 3, height:  geo.size.width / 3)
                        .shadow(color: .black, radius: 5)
                    
                    Text(vmUser.user?.username ?? "...")
                        .font(.title3)
                        .fontWeight(.semibold)
                    
                    
                    HStack {
                        VStack (alignment: .leading, spacing: 15) {
                            Label("Username:", systemImage: "person")
                            Label("Phone:", systemImage: "phone")
                            Label("Address:", systemImage: "house")
                            Label("Email:", systemImage: "envelope")
                            
                        }
                        .fontWeight(.semibold)
                        
                        Spacer()
                        
                        VStack (alignment: .leading, spacing: 15) {
                            
                            
                            Text(vmUser.user?.fullname ?? "...")
                            Text(vmUser.user?.phoneNumber ?? "...")
                            Text(vmUser.user?.address ?? "...")
                            Text(vmUser.user?.email ?? "...")
                            
                        }
                        
                        Spacer(minLength: 70)
                    }
                    .padding()
                    .background(.ultraThinMaterial)
                    .clipShape(.rect(cornerRadius: 25))
                    
                    
                    map
                    
                    Spacer()
                    
                }
                .overlay(alignment: .topTrailing) {
                    
                    NavigationLink {
                        UpdateUserInfoView()
                            .environmentObject(vmUser)
                            .environmentObject(vmMap)
                    } label: {
                        Image(systemName: "square.and.pencil")
                            .fontWeight(.semibold)
                            .font(.title2)
                            .foregroundStyle(.black)
                            .symbolEffect(.pulse)
                    }
                    
                    
                }
                .padding()
                .frame(maxWidth: .infinity, maxHeight: .infinity)
                .fontDesign(.rounded)
                
            }
            
            .background(
                LinearGradient(gradient: Gradient(colors: [.gradientColor1, .gradientColor2]), startPoint: .topLeading, endPoint: .bottomTrailing)
                    .hueRotation(.degrees(animateGradient ? 30 : 0))
                    .onAppear {
                        withAnimation(.easeInOut(duration: 3).repeatForever(autoreverses: true)) {
                            animateGradient.toggle()
                        }
                    }
                    .ignoresSafeArea()
            )
        }
    }
    
    var map: some View {
        Map (position: $vmMap.camera ) {
            
            Annotation("You are here!", coordinate: vmMap.coordinate) {
                Image(systemName: "mappin")
                    .foregroundStyle(Color.red.gradient)
                    .symbolEffect(.pulse)
                    .font(.title)
            }
        }
        .overlay(alignment: .topLeading) {
            Text("Current Address")
                .padding(.bottom, 5)
                .padding(.leading, 5)
                .padding(.trailing, 8)
                .background(.ultraThinMaterial)
                .clipShape(.rect(bottomTrailingRadius: 15))
                .fontDesign(.monospaced)
                .font(.subheadline)
                .foregroundStyle(.black)
        }
        .frame(height: 200)
        .clipShape(.rect(cornerRadius: 15))
        .mapStyle(.standard)
    }
}

#Preview {
    
    @StateObject var vmUser = UserViewModel()
    @State var vmMap = MapViewModel()
    return ProfileView()
        .environmentObject(vmUser)
        .environmentObject(vmMap)
}
