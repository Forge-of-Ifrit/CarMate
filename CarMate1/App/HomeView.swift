//
//  HomeView.swift
//  CarMate1
//
//  Created by Abdulrahmanb on 21/11/2025.
//

import SwiftUI

struct HomeView: View {
    var body: some View {
        NavigationStack {
            ZStack {
                // Background gradient
                LinearGradient(
                    colors: [.green.opacity(0.6), .black.opacity(0.6)],
                        startPoint: .topLeading,
                        endPoint: .bottomTrailing)
                    .ignoresSafeArea()
                
                VStack(spacing: 40) {
                    Spacer()
                        // App Logo
                    Image("logo")
                        .resizable()
                        .scaledToFit()
                        .frame(width: 200, height: 200)
                        .shadow(radius: 10)

                    // App Title
                    VStack(spacing: 10) {
                        Text("CarMate")
                            .font(.system(size: 48, weight: .bold))
                            .foregroundStyle(.white)

                        Text("Your Vehicle Management Companion")
                            .font(.title3)
                            .foregroundStyle(.white.opacity(0.9))
                            .multilineTextAlignment(.center)
                            .padding(.horizontal)
                        }
                    
                    Spacer()
                        // Buttons
                    VStack(spacing: 20) {

                        // Login Button
                        NavigationLink {
                            LoginView()
                        } label: {
                            Text("Login")
                                .font(.title2)
                                .bold()
                                .foregroundStyle(.cyan)
                                .frame(width: 280, height: 55)
                                .background(.white)
                                .cornerRadius(15)
                                .shadow(radius: 5)
                        }

                        // Register Button
                        NavigationLink {
                            RegisterView()
                        } label: {
                            Text("Register")
                                .font(.title2)
                                .bold()
                                .foregroundStyle(.white)
                                .frame(width: 280, height: 55)
                                .background(.white.opacity(0.3))
                                .cornerRadius(15)
                                .overlay(RoundedRectangle(cornerRadius: 15)
                                    .stroke(.white, lineWidth: 2))
                        }
                    }
                    .padding(.bottom, 60)
                }
            }
        }
    }
}
      
#Preview {
    HomeView()
}
