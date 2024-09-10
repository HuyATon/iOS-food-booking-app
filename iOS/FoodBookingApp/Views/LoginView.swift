//
//  LoginView.swift
//  TicketBookingApp
//
//  Created by HUY TON on 12/8/24.
//

import SwiftUI

struct LoginView: View {
    
    @EnvironmentObject var vmUser: ViewModel
    
    @State private var usernameInput = ""
    @State private var passwordInput = ""
    @State private var visible = false
    @State private var animateGradient = false
    
    
    var body: some View {
       
        NavigationStack {
            VStack {
                        Spacer()
                        VStack(alignment: .center) {
                            welcome
                           
                            Spacer()
                            usernameField
                                .fontWeight(.semibold)
                                .shadow(radius:1)
                                .padding()
                                .background(.ultraThinMaterial)
                                .clipShape(.capsule)
                                .textInputAutocapitalization(.never)
                                .autocorrectionDisabled()
                            
                            passwordField
                                .fontWeight(.semibold)
                                .shadow(radius:1)
                                .padding()
                                .background(.ultraThinMaterial)
                                .clipShape(.capsule)
                            
                            forgetPassButton
                            
                            Spacer()
                            
                            signInButton
                               
                        }

                        Spacer(minLength: 50)
                        
                        signUp
                        
                        Spacer(minLength: 50)
                    }
                    // add progress view
                    .padding()
                    .overlay {
                        if vmUser.isLoading {
                            ProgressView()
                                .padding()
                                .background(.thickMaterial)
                                .clipShape(.rect(cornerRadius: 5))
                        }
                    }
                    .disabled(vmUser.isLoading)
                    // add alert
                    .alert("Authentication Error", 
                           isPresented: $vmUser.showLoginAlert,
                           actions: {
                                Button("OK") { }
                            },
                           message: {
                            if let message = vmUser.errorLogInMessage {
                                Text(message)
                            }
                            }
                    )
            
                    .background(
                        LinearGradient(gradient: Gradient(colors: [.gradientColor1, .gradientColor2]), startPoint: .topLeading, endPoint: .bottomTrailing)
                            .ignoresSafeArea()
                            .hueRotation(.degrees(animateGradient ? 30 : 0))
                            .onAppear {
                                withAnimation(.easeInOut(duration: 3).repeatForever(autoreverses: true)) {
                                    animateGradient.toggle()
                                }
                            }
                )
        }
    }
    
    // MARK: - Sub views
    var welcome: some View {
        return VStack {
            Text("Welcome!")
                .font(.largeTitle)
                .fontWeight(.bold)
                .foregroundStyle(.white)
            Text("Please Log In")
                .font(.subheadline)
                .foregroundStyle(.white)
        }

       
    }
    
    private var usernameField: some View {
        HStack {
            Image(systemName: "person.fill")
            TextField("Username", text: $usernameInput)
        }
        .foregroundStyle(.white)
    }
    
    private var passwordField: some  View {
        HStack {
            Image(systemName: "lock.fill")
                .foregroundStyle(.white)
            
            if visible {
                TextField("Password", text: $passwordInput)
                    .foregroundStyle(.white)
            } else {
                SecureField("Password", text: $passwordInput)
                    .foregroundStyle(.white)
            }
            Spacer()
            Button {
                withAnimation(.smooth(duration: 0.1)) {
                    visible.toggle()
                }
            } label: {
                Image(systemName: "eye.fill")
                    .foregroundStyle(.white)
            }
        }
    }
    
    var forgetPassButton: some View {
        Button {
            
        } label: {
            HStack {
                Image(systemName: "person.fill.questionmark")
                Text("Forget Password?")
                    .fontWeight(.semibold)
            }
            .foregroundStyle(.white)
            .padding()
        }
    }
    
    var signInButton: some View {

        Button {
            
            if (usernameInput.isEmpty || passwordInput.isEmpty) {
                
                vmUser.errorLogInMessage = "Username and Password must be filled"
                vmUser.showLoginAlert = true
            }
            
            else {
                Task {
                    await vmUser.login(username: usernameInput, password: passwordInput)
                    self.resetInput()
                }
                
            }
        } label: {
            Text("Sign In")
                .frame(maxWidth: .infinity)
                .font(.title2)
                .foregroundStyle(.white)
                .fontWeight(.semibold)
                .padding()
        }
        .background(Color.button)
        .clipShape(.rect(cornerRadius: 10))
    }
    
    var signUp: some View {
        HStack {
            Text("New to the app?")
                .foregroundStyle(.white)
            
            NavigationLink("Create an account") {
                RegisterView()
            }
            .foregroundStyle(Color.button)
            .fontWeight(.semibold)
        }
    }
    
    private func resetInput() {
        usernameInput = ""
        passwordInput = ""
    }
}

#Preview {
    
    @StateObject var vmUser = ViewModel()
    return LoginView()
        .environmentObject(vmUser)
}
