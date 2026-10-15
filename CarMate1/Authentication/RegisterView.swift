//
//  RegisterView.swift
//  CarMate1
//
//  Created by Abdulrahmanb on 18/11/2025.
//

import SwiftUI
import SwiftData

struct RegisterView: View {
    
    @Environment(\.modelContext) var modelContext
    @Environment(\.dismiss) private var dismiss
    
    @State private var username: String = ""
    @State private var password: String = ""
    @State private var confirmPassword: String = ""

    // Alert control
    @State private var alertMessage: String = ""
    @State private var showAlert: Bool = false
    @State private var registrationSuccess: Bool = false

    // Track if registration is successful
    @AppStorage("isLoggedIn") private var isLoggedIn: Bool = false

    var body: some View {
        NavigationStack{
            VStack(spacing: 20) {
                // App Logo
                Image("logo")
                    .resizable()
                    .scaledToFit()
                    .frame(width: 130, height: 130)
                    .padding(.top, 50)
                
                Text("Car Mate")
                    .font(.largeTitle)
                    .bold()
                    .foregroundStyle(.blue)
                
                Text("Create Your Account")
                    .font(.title2)
                    .foregroundStyle(.gray)
                
                // Registration Form
                Form {
                    Section("Account Information") {
                        TextField("Username", text: $username)
                            .textFieldStyle(.roundedBorder)
                            .autocorrectionDisabled()
                            .autocapitalization(.words)
                        
                        SecureField("Password", text: $password)
                            .textFieldStyle(.roundedBorder)
                            .keyboardType(.default)
                            .autocorrectionDisabled()
                            .autocapitalization(.none)

                        SecureField("Confirm Password", text: $confirmPassword)
                            .textFieldStyle(.roundedBorder)
                            .keyboardType(.default)
                            .autocorrectionDisabled()
                            .autocapitalization(.none)
                    }
                    
                    Section {
                        Button("Register") {
                            registerUser()
                        }
                        .frame(maxWidth: .infinity)
                        .buttonStyle(.borderedProminent)
                        .disabled(username.isEmpty || password.isEmpty || confirmPassword.isEmpty)
                    }
                }
            }
            
            .navigationTitle("Registration")
            .alert("Registration", isPresented: $showAlert) {
                Button("OK", role: .cancel) {
                    if registrationSuccess {
                        dismiss()
                    }
                }
            } message: {
                Text(alertMessage)
            }
        }
    }

    // Register User Function
    // Validates input and creates user account in database
    func registerUser() {
        // Validation 1: Check if fields are empty
        if username.isEmpty || password.isEmpty || confirmPassword.isEmpty {
            alertMessage = "All fields are required!"
            showAlert = true
            return
        }
        // Validation 2: Check password length
        if password.count < 4 {
            alertMessage = "Password must be at least 4 characters!"
            showAlert = true
            return
        }
        // Validation 3: Check if passwords match
        if password != confirmPassword {
            alertMessage = "Passwords do not match!"
            showAlert = true
            return
        }

        // All validations passed - Create user account
        let newUser = UserAccount(username: username, password: password)
        modelContext.insert(newUser)
        
        // Save to database
        do {
            try modelContext.save()
            print("User registered successfully")
            registrationSuccess = true
            alertMessage = "Registration successful! Please login with your credentials."
            showAlert = true

        } catch {
            alertMessage = "Error saving user: \(error.localizedDescription)"
            showAlert = true
        }
    }
}

#Preview {
    RegisterView()
        .modelContainer(for: [UserAccount.self, Vehicle.self, MaintenanceRecord.self])
}
