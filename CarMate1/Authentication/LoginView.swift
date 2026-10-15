//
//  LoginView.swift
//  CarMate1
//
//  Created by Abdulrahmanb on 18/11/2025.
//

import SwiftUI
import SwiftData

struct LoginView: View {
    
    // Access to database
    @Query var users: [UserAccount]
    
    @State private var username: String = ""
    @State private var password: String = ""
    @State private var rememberMe: Bool = false

    // Alert control
    @State private var alertMessage: String = ""
    @State private var showAlert: Bool = false

    // AppStorage for persistence
    @AppStorage("isLoggedIn") private var isLoggedIn: Bool = false
    @AppStorage("savedUsername") private var savedUsername: String = ""

    var body: some View {
        NavigationStack{
            VStack(spacing: 20) {
                // App Logo
                Image("logo")
                    .resizable()
                    .scaledToFit()
                    .frame(width: 120, height: 120)
                    .padding(.top, 50)
                
                Text("CarMate Login")
                    .font(.largeTitle)
                    .bold()
                
                // Login Form
                Form {
                    Section("Login Information") {
                        TextField("Username", text: $username)
                            .textFieldStyle(.roundedBorder)
                            .autocorrectionDisabled()
                            .autocapitalization(.none)
                        
                        SecureField("Password", text: $password)
                            .textFieldStyle(.roundedBorder)
                        
                        Toggle("Remember Me", isOn: $rememberMe)
                    }
                    
                    Section {
                        Button("Login") {
                            loginUser()
                        }
                        .frame(maxWidth: .infinity)
                        .buttonStyle(.borderedProminent)
                        .disabled(username.isEmpty || password.isEmpty)
                        
                    }
                }
            }
            .navigationTitle("Login")
            .alert("Login", isPresented: $showAlert) {
                Button("OK", role: .cancel) { }
            } message: {
                Text(alertMessage)
            }
            // Load saved username when view appears
            .onAppear {
                if !savedUsername.isEmpty {
                    username = savedUsername
                    rememberMe = true
                }
            }
        
        // Handle Remember Me toggle changes
        .onChange(of: rememberMe) { oldValue, newValue in
            if !rememberMe {
                savedUsername = ""
                print("Saved username cleared")
            }
        }
    }
    }

    // Checks credentials and logs user in
    func loginUser() {
        // Find user in database
        if let user = users.first(where: { $0.username == username }) {
            // Check password
            if user.password == password {
                // Login successful
                isLoggedIn = true
                 
                // Save username if Remember Me is on
                if rememberMe {
                    savedUsername = username
                    print("Username saved")
                } else {
                    savedUsername = ""
                }
                
                print("Login successful")
                 
            } else {
                // Wrong password
                alertMessage = "Incorrect password!"
                showAlert = true
            }
        } else {
            // User not found
            alertMessage = "User not found! Please register first."
            showAlert = true
        }
    }
}

#Preview {
    LoginView()
        .modelContainer(for: UserAccount.self)
}
