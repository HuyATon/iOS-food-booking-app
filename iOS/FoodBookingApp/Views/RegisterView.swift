//
//  RegistrationView.swift
//  TicketBookingApp
//
//  Created by HUY TON on 12/8/24.
//

import SwiftUI

struct RegisterView: View {
    
    @StateObject var vmRegister =  RegisterViewModel()
    
    @State var inputUsername: String = ""
    @State var inputPassword: String = ""
    @State var inputRetypePassword: String = ""
    @State var inputEmail: String = ""
    @State var visible = false

    @State var animateGradient = false
   
    var body: some View {
            VStack {
                    Spacer()
                    welcomeTitle
                
                    askingTitle
                    
                    usernameField

                    if visible{
                        
                        visiblePasswordField
                    }
                    else {
                        
                        unvisiblePasswordField
                    }

                    emailField
                
                    Spacer()

                    submitButton
                
                    Spacer()
            }
            .padding()
            .background {
                LinearGradient(gradient: Gradient(colors: [.gradientColor1, .gradientColor2]), startPoint: .topLeading, endPoint: .bottomTrailing)
                    .hueRotation(.degrees(animateGradient ? 30 : 0))
                    .onAppear {
                        withAnimation(.easeInOut(duration: 3).repeatForever(autoreverses: true)) {
                            animateGradient.toggle()
                        }
                    }
                    .ignoresSafeArea()
            }
            .overlay {
                if vmRegister.isLoading  {
                    ProgressView()
                        .padding()
                        .background(.thickMaterial)
                        .clipShape(.rect(cornerRadius: 5))
                }
            }
            .disabled(vmRegister.isLoading)
            .alert("Register",
                   isPresented: $vmRegister.showAlert,
                   actions: {
                        Button("OK") { }
                   },
                   message: {
                        if let message = vmRegister.alertMessage {
                            Text(message)
                        }
                  }
            )
            
            .ignoresSafeArea()
    }
    
    private var welcomeTitle: some View {
        Text("Join Us Now!")
            .font(.largeTitle)
            .fontWeight(.bold)
            .foregroundStyle(.white)
    }
    
    private var askingTitle: some View {
        Text("Enter Your Information")
            .font(.subheadline)
            .padding(.bottom, 20)
            .foregroundStyle(.white)
    }
    
    private var usernameField: some View {
        HStack {
            Image(systemName: "person.fill")
            TextField("Username", text: $inputUsername)
        }
        .padding()
        .background(.ultraThinMaterial)
        .clipShape(.capsule)
        .textInputAutocapitalization(.never)
        .autocorrectionDisabled()
        .foregroundStyle(.white)
    }
    
    private var visiblePasswordField: some View {
        VStack {
            HStack {
                Image(systemName: "lock.fill")
                TextField("Password", text: $inputPassword)
                showPasswordButton
                    .textInputAutocapitalization(.never)
                    .autocorrectionDisabled()
            }
                .padding()
                .background(.ultraThinMaterial)
                .foregroundStyle(.white)
                .clipShape(.capsule)
                
            HStack {
                Image(systemName: "lock.fill")
                TextField("Re-type Password", text: $inputRetypePassword)
                showPasswordButton
                    .textInputAutocapitalization(.never)
                    .autocorrectionDisabled()
                
            }
                .padding()
                .background(.ultraThinMaterial)
                .foregroundStyle(.white)
                .clipShape(.capsule)
        }
    }
    
    private var unvisiblePasswordField: some View {
        VStack {
            HStack {
                Image(systemName: "lock.fill")
                SecureField("Password", text: $inputPassword)
                showPasswordButton
            }
            
                .padding()
                .background(.ultraThinMaterial)
                .foregroundStyle(.white)
                .clipShape(.capsule)
            
            HStack {
                Image(systemName: "lock.fill")
                SecureField("Re-type assword", text: $inputRetypePassword)
                showPasswordButton
            }
                .padding()
                .background(.ultraThinMaterial)
                .foregroundStyle(.white)
                .clipShape(.capsule)
        }
    }
    
    private var showPasswordButton: some View {
        Button {
            withAnimation (.smooth(duration: 0.1)) {
                visible.toggle()
            }
        } label: {
            Image(systemName: "eye.fill")
                .foregroundStyle(.white)
            
        }
    }
    
    private var emailField: some View {
        HStack {
            Image(systemName: "envelope.fill")
            TextField("Email", text: $inputEmail)
        }
            .padding()
            .background(.ultraThinMaterial)
            .foregroundStyle(.white)
            .clipShape(.capsule)
            .textInputAutocapitalization(.never)
            .autocorrectionDisabled()
    }
    
    private var submitButton: some View {
        Button {
            
            if (inputUsername.isEmpty || inputEmail.isEmpty || inputPassword.isEmpty || inputRetypePassword.isEmpty) {
                
                vmRegister.alertMessage = "All fields must be filled"
                vmRegister.showAlert = true
            }
            else if (inputPassword != inputRetypePassword) {
                vmRegister.alertMessage = "The retype password is unmatched"
                vmRegister.showAlert = true
            }
            else {
                Task {
                    await vmRegister.register(username: inputUsername,
                                              password: inputPassword,
                                              email: inputEmail)
                }
            }
            
        } label: {
            Text("Register")
                .frame(maxWidth: .infinity)
                .font(.title2)
                .foregroundStyle(.white)
                .fontWeight(.semibold)
                .padding()
                .background(Color.button)
                .foregroundStyle(.white)
                .clipShape(.rect(cornerRadius: 10))
                
        }
    }
}

#Preview {
    RegisterView()
        .environmentObject(UserViewModel())
}
