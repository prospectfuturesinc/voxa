//
//  AuthenticationView.swift
//  voxa
//
//  Authentication Views
//

import SwiftUI
import AuthenticationServices

struct AuthenticationView: View {
    @ObservedObject var authManager: AuthenticationManager
    @State private var email = ""
    @State private var password = ""
    @State private var isSignUp = false

    var body: some View {
        VStack(spacing: 20) {
            // App Logo/Title
            Text("Voxa")
                .font(.largeTitle)
                .fontWeight(.bold)
                .padding(.bottom, 40)

            if authManager.isLoading {
                ProgressView()
                    .scaleEffect(1.5)
                    .padding()
            } else {
                // Sign in with Apple Button
                SignInWithAppleButton(
                    .signIn,
                    onRequest: { request in
                        request.requestedScopes = [.fullName, .email]
                    },
                    onCompletion: { result in
                        switch result {
                        case .success(let authorization):
                            if let appleIDCredential = authorization.credential as? ASAuthorizationAppleIDCredential {
                                Task {
                                    await authManager.signInWithApple(credential: appleIDCredential)
                                }
                            }
                        case .failure(let error):
                            authManager.errorMessage = error.localizedDescription
                        }
                    }
                )
                .signInWithAppleButtonStyle(.black)
                .frame(height: 50)
                .padding(.horizontal)

                // Divider
                HStack {
                    Rectangle()
                        .frame(height: 1)
                        .foregroundColor(.gray.opacity(0.3))
                    Text("OR")
                        .foregroundColor(.gray)
                        .padding(.horizontal, 10)
                    Rectangle()
                        .frame(height: 1)
                        .foregroundColor(.gray.opacity(0.3))
                }
                .padding(.horizontal)
                .padding(.vertical, 10)

                // Email/Password Sign In
                VStack(spacing: 15) {
                    TextField("Email", text: $email)
                        .textFieldStyle(RoundedBorderTextFieldStyle())
                        .autocapitalization(.none)
                        .keyboardType(.emailAddress)
                        .padding(.horizontal)

                    SecureField("Password", text: $password)
                        .textFieldStyle(RoundedBorderTextFieldStyle())
                        .padding(.horizontal)

                    Button(action: {
                        Task {
                            if isSignUp {
                                await authManager.signUpWithEmail(email: email, password: password)
                            } else {
                                await authManager.signInWithEmail(email: email, password: password)
                            }
                        }
                    }) {
                        Text(isSignUp ? "Sign Up" : "Sign In")
                            .fontWeight(.semibold)
                            .foregroundColor(.white)
                            .frame(maxWidth: .infinity)
                            .padding()
                            .background(Color.blue)
                            .cornerRadius(10)
                    }
                    .padding(.horizontal)
                    .disabled(email.isEmpty || password.isEmpty)

                    // Toggle between Sign In and Sign Up
                    Button(action: {
                        isSignUp.toggle()
                    }) {
                        Text(isSignUp ? "Already have an account? Sign In" : "Don't have an account? Sign Up")
                            .foregroundColor(.blue)
                            .font(.footnote)
                    }
                }
            }

            // Error Message
            if let errorMessage = authManager.errorMessage {
                Text(errorMessage)
                    .foregroundColor(.red)
                    .font(.caption)
                    .padding()
                    .multilineTextAlignment(.center)
            }

            Spacer()
        }
        .padding(.top, 60)
    }
}

#Preview {
    AuthenticationView(authManager: AuthenticationManager())
}
