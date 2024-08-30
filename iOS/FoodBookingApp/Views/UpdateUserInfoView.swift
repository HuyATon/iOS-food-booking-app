//
//  UpdateUserInfoView.swift
//  TicketBookingApp
//
//  Created by HUY TON on 12/8/24.
//

import SwiftUI
import MapKit

struct UpdateUserInfoView: View {
    
    @EnvironmentObject var vmUser: UserViewModel
    @EnvironmentObject var vmMap: MapViewModel
    @EnvironmentObject var router: Router
    
    @State var fullNameInput = ""
    @State var phoneNumberInput = ""
    @State var birthdayInput = Date.now
    @State var addressInput = ""
    @State var animateGradient = false
    
    var body: some View {
        VStack (alignment: .leading) {
            Text("Type in your new information")
                .fontWeight(.semibold)
            
            nameField
            
            addressField
            
            phoneField
            
            birthdayField
            
            Divider()
            
            
            NavigationLink {
                ChangeLocationView()
                    .environmentObject(vmMap)
                    .toolbarBackground(.automatic)
            } label: {
                map
            }
            
            
            Spacer()
            
            updateButton
            
            Spacer(minLength: 70)
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
        
        // add ProgressView
        .overlay {
            if vmUser.isLoading {
                ProgressView()
                    .padding()
                    .background(.thickMaterial)
                    .clipShape(.rect(cornerRadius: 5))
            }
        }
        .disabled( vmUser.isLoading)
        .alert("Update",
               isPresented: $vmUser.showUpdateAlert,
               actions: {
            Button("OK")  { }
        },
               message: {
            if let message = vmUser.errorUpdateMessage {
                Text(message)
            }
        })
        .navigationTitle("Edit Profile")
        .navigationBarTitleDisplayMode(.inline)
        .toolbarBackground(.automatic) // MARK: fix when adding the map
    }
        
        
        
    var nameField: some View {
        
        TextField("Full-name", text: $fullNameInput)
            .padding()
            .background(.ultraThinMaterial)
            .clipShape(.capsule)
        
            .textInputAutocapitalization(.never)
            .autocorrectionDisabled()
    }
    
    var addressField: some View {
        TextField("Address", text: $addressInput)
            .padding()
            .background(.ultraThinMaterial)
            .clipShape(.capsule)
        
            .textInputAutocapitalization(.never)
            .autocorrectionDisabled()
    }
    
    var phoneField: some View {
        TextField("Phone Number", text: $phoneNumberInput)
            .padding()
            .background(.ultraThinMaterial)
            .clipShape(.capsule)
            .textInputAutocapitalization(.never)
            .keyboardType(.numberPad)
    }
    
    var birthdayField: some View {
        DatePicker(selection: $birthdayInput, in: ...Date.now, displayedComponents: .date) {
            Text("Birthday")
                .fontWeight(.semibold)
        }
        .tint(.button)
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
                await vmUser.updateProfile(
                    fullname: fullNameInput,
                    phoneNumber: phoneNumberInput,
                    address: addressInput,
                    birthday: birthdayInput,
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
                .background(.button)
                .clipShape(.rect(cornerRadius: 15))
                
        }
        .padding(.vertical, 20)
    }

}

#Preview {
    
    @StateObject var vmUser = UserViewModel()
    @StateObject var vmMap = MapViewModel()
    return NavigationStack {
        UpdateUserInfoView()
            .environmentObject(vmUser)
            .environmentObject(vmMap)
    }
        
}
