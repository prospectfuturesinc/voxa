//
//  RootView.swift
//  voxa
//
//  Root view that handles authentication state
//

import SwiftUI

struct RootView: View {
    @StateObject private var authManager = AuthenticationManager()

    var body: some View {
        Group {
            if authManager.isAuthenticated {
                MainView(authManager: authManager)
            } else {
                AuthenticationView(authManager: authManager)
            }
        }
    }
}

struct MainView: View {
    @ObservedObject var authManager: AuthenticationManager

    var body: some View {
        NavigationStack {
            ContentView()
                .toolbar {
                    ToolbarItem(placement: .navigationBarTrailing) {
                        Menu {
                            if let user = authManager.currentUser {
                                Text("User: \(user.email ?? "Unknown")")
                                    .font(.caption)
                            }

                            Divider()

                            Button(role: .destructive, action: {
                                Task {
                                    await authManager.signOut()
                                }
                            }) {
                                Label("Sign Out", systemImage: "arrow.right.square")
                            }
                        } label: {
                            Image(systemName: "person.circle")
                        }
                    }
                }
        }
    }
}

#Preview {
    RootView()
}
