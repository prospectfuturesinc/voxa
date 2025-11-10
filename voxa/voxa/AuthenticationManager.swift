//
//  AuthenticationManager.swift
//  voxa
//
//  Authentication Manager with Sign in with Apple
//

import Foundation
import SwiftUI
import AuthenticationServices
import Supabase

@MainActor
class AuthenticationManager: ObservableObject {
    @Published var isAuthenticated = false
    @Published var currentUser: User?
    @Published var errorMessage: String?
    @Published var isLoading = false

    private let supabase = SupabaseManager.shared.client

    init() {
        Task {
            await checkAuthStatus()
        }
    }

    // Check if user is already authenticated
    func checkAuthStatus() async {
        do {
            let session = try await supabase.auth.session
            self.currentUser = session.user
            self.isAuthenticated = true
        } catch {
            self.isAuthenticated = false
            self.currentUser = nil
        }
    }

    // Sign in with Apple
    func signInWithApple(credential: ASAuthorizationAppleIDCredential) async {
        isLoading = true
        errorMessage = nil

        do {
            guard let identityToken = credential.identityToken,
                  let tokenString = String(data: identityToken, encoding: .utf8) else {
                throw NSError(domain: "AuthError", code: -1, userInfo: [NSLocalizedDescriptionKey: "Failed to get identity token"])
            }

            // Sign in with Supabase using Apple ID token
            let session = try await supabase.auth.signInWithIdToken(
                credentials: .init(
                    provider: .apple,
                    idToken: tokenString
                )
            )

            self.currentUser = session.user
            self.isAuthenticated = true
        } catch {
            self.errorMessage = error.localizedDescription
            print("Sign in with Apple error: \(error)")
        }

        isLoading = false
    }

    // Sign out
    func signOut() async {
        do {
            try await supabase.auth.signOut()
            self.isAuthenticated = false
            self.currentUser = nil
        } catch {
            self.errorMessage = error.localizedDescription
            print("Sign out error: \(error)")
        }
    }

    // Email/Password Sign In (optional)
    func signInWithEmail(email: String, password: String) async {
        isLoading = true
        errorMessage = nil

        do {
            let session = try await supabase.auth.signIn(
                email: email,
                password: password
            )

            self.currentUser = session.user
            self.isAuthenticated = true
        } catch {
            self.errorMessage = error.localizedDescription
            print("Sign in error: \(error)")
        }

        isLoading = false
    }

    // Email/Password Sign Up (optional)
    func signUpWithEmail(email: String, password: String) async {
        isLoading = true
        errorMessage = nil

        do {
            let session = try await supabase.auth.signUp(
                email: email,
                password: password
            )

            self.currentUser = session.user
            self.isAuthenticated = true
        } catch {
            self.errorMessage = error.localizedDescription
            print("Sign up error: \(error)")
        }

        isLoading = false
    }
}
