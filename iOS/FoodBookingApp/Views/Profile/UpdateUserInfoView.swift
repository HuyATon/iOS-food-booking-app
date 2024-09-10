//
//  UpdateUserInfoView.swift
//  TicketBookingApp
//
//  Created by HUY TON on 12/8/24.
//

import SwiftUI
import MapKit




struct UpdateUserInfoView: View {
    
    @EnvironmentObject var vm: ViewModel
    @EnvironmentObject var vmMap: MapViewModel
    
    @State private var fullNameInput = ""
    @State private var phoneNumberInput = ""
    @State private var addressInput = ""
    @State private var animateGradient = false
    
    
    
    var body: some View {
        VStack (alignment: .leading, spacing: 20) {
            
            InputField(text: $fullNameInput, systemIcon: "person", placeholder: "Fullname")
            
            InputField(text: $addressInput, systemIcon: "map", placeholder: "Address")
            
            InputField(text: $phoneNumberInput, systemIcon: "phone", placeholder: "Phone Number")
            
            
            Divider()
            
            Text("Update your location").fontWeight(.semibold)
            
            NavigationLink {
                ChangeLocationView()
                    .environmentObject(vmMap)
                    .toolbarBackground(.automatic)
            } label: {
                map
            }
            
            
            Spacer()
            
            updateButton
            
        }
        .padding()
        .background {
            LinearGradient(colors: [.gradientColor1, .gradientColor2], startPoint: .topLeading, endPoint: .bottomTrailing)
                .hueRotation(.degrees(animateGradient ? 30 : 0))
                .onAppear {
                    withAnimation(.easeInOut(duration: 3).repeatForever(autoreverses: true)) {
                        animateGradient.toggle()
                    }
                }
                .ignoresSafeArea()
        }
        .onAppear {
                vm.hideTabBar()
        }

        
        // add ProgressView
        .overlay {
            if vm.isLoading {
                ProgressView()
                    .padding()
                    .background(.thickMaterial)
                    .clipShape(.rect(cornerRadius: 5))
            }
        }
        .disabled( vm.isLoading)
        .alert("Update",
               isPresented: $vm.showUpdateAlert,
               actions: {
            Button("OK")  { }
        },
               message: {
            if let message = vm.errorUpdateMessage {
                Text(message)
            }
        })
        .navigationTitle("Edit Profile")
        .navigationBarTitleDisplayMode(.inline)
        .toolbarBackground(.automatic) // MARK: fix when adding the map
    }
    
    var isValidInput: Bool {
        
        if (fullNameInput.isEmpty ||
            phoneNumberInput.isEmpty ||
            addressInput.isEmpty
        ) {
            return false
        }
        return true
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
        .frame(height: 180)
        .clipShape(.rect(cornerRadius: 15))
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
        .overlay (alignment: .trailing){
            Image(systemName: "chevron.right")
                .font(.title2)
                .fontWeight(.bold)
                .shadow(color:.black, radius: 2)
                .foregroundStyle(.white)
                .padding(5)
                
        }
    }
    
    
    
    var updateButton: some View {
        Button {
            // MARK: - Update user information
            
            Task {
                await vm.updateProfile(
                    fullname: fullNameInput,
                    phoneNumber: phoneNumberInput,
                    address: addressInput,
                    latitude: vmMap.coordinate.latitude.magnitude,
                    longitude: vmMap.coordinate.longitude.magnitude)
            }
            
        } label: {
            Text("Update")
                .padding()
                .frame(maxWidth: .infinity)
                .font(.title2)
                .foregroundStyle(.white)
                .fontWeight(.bold)
                .background(isValidInput ? .button : .secondary)
                .clipShape(.rect(cornerRadius: 15))
                .disabled(!isValidInput)
                .opacity(isValidInput ? 1 : 0.5)
        }
        
        
    }

}

#Preview {
    
    @StateObject var vmUser = ViewModel()
    @StateObject var vmMap = MapViewModel()
    return NavigationStack {
        UpdateUserInfoView()
            .environmentObject(vmUser)
            .environmentObject(vmMap)
    }
        
}
