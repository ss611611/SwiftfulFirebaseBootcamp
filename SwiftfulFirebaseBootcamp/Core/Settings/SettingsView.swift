//
//  SettingsView.swift
//  SwiftfulFirebaseBootcamp
//
//  Created by Jackie Lu on 2024/8/22.
//

import SwiftUI


struct SettingsView: View {
    
    @StateObject private var viewModel = SettingsViewModel()
    @Binding var showSignInView: Bool
    
    var body: some View {
        List {
            Button("Log out") {
                Task {
                    do {
                        try viewModel.signOut()
                        showSignInView = true
                    } catch {
                        print(error)
                    }
                }
            }
            
            Button(role: .destructive) {
                Task {
                    do {
                        try await viewModel.deleteAccout()
                        showSignInView = true
                    } catch {
                        print(error)
                    }
                }
            } label: {
                Text("Delete accout")
            }

            
            if viewModel.authProviders.contains(.email) {
                emailSection
            }
            
            if viewModel.authUser?.isAnonymous == true {
                anonymousSection
            }
        }
        .onAppear {
            viewModel.loadAuthProviders()
            viewModel.loadAuthUser()
        }
        .navigationTitle("Settings")
    }
}

#Preview {
    NavigationStack {
        SettingsView(showSignInView: .constant(false))
    }
}


extension SettingsView {
    private var emailSection: some View {
        Section {
            Button("Reset password") {
                Task {
                    do {
                        try await viewModel.resetPassword()
                        print("PASSWORD RESET")
                    } catch {
                        print(error)
                    }
                }
            }
            
            Button("Update password") {
                Task {
                    do {
                        try await viewModel.updatePassword()
                        print("PASSWORD UPDATE")
                    } catch {
                        print(error)
                    }
                }
            }
            
            Button("Update email") {
                Task {
                    do {
                        try await viewModel.updateEmail()
                        print("EMAIL UPDATE")
                    } catch {
                        print(error)
                    }
                }
            }
        } header: {
            Text("Email functions")
        }
    }
    
    private var anonymousSection: some View {
        Section {
            Button("Link Google Account") {
                Task {
                    do {
                        try await viewModel.linkGoogleAccount()
                        print("GOOGLE LINKED!")
                    } catch {
                        print(error)
                    }
                }
            }
            
            Button("Link Apple Account") {
                Task {
                    do {
                        try await viewModel.linkAppleAccount()
                        print("APPLE LINKED!")
                    } catch {
                        print(error)
                    }
                }
            }
            
            Button("Link Email Account") {
                Task {
                    do {
                        try await viewModel.linkEmailAccount()
                        print("EMAIL LINKED!")
                    } catch {
                        print(error)
                    }
                }
            }
        } header: {
            Text("Create account")
        }
    }
}
