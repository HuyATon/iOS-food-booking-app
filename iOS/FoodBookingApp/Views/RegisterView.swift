//
//  RegistrationView.swift
//  TicketBookingApp
//
//  Created by HUY TON on 12/8/24.
//

import SwiftUI

struct RegisterView: View {
    
    @StateObject var vmRegister =  RegisterViewModel()
    
    @State private var inputUsername: String = ""
    @State private var inputPassword: String = ""
    @State private var inputRetypePassword: String = ""
    @State private var inputEmail: String = ""

    @State private var animateGradient = false
   
    var body: some View {
        VStack {
                    welcomeTitle
                
                    askingTitle
                    
                    VStack(alignment: .leading) {
                        InputField(text: $inputUsername, systemIcon: "person.fill", placeholder: "Username")
                            .foregroundStyle(.white)


                            
                        SecuredInputField(text: $inputPassword, systemIcon: "lock.fill", placeholder: "Password")
                        SecuredInputField(text: $inputRetypePassword, systemIcon: "lock.fill", placeholder: "Confirm Password")
                        

                        InputField(text: $inputEmail, systemIcon: "envelope.fill", placeholder: "Email")
                    }
                    .foregroundStyle(.white)

                    Spacer()

                    submitButton
            }
        .ignoresSafeArea(.keyboard, edges: .all)
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
        .environmentObject(ViewModel())
}
