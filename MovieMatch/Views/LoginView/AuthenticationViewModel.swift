//
//  ContentViewViewModel.swift
//  MovieMatch
//
//  Created by Omar Regalado Mendoza on 04/07/25.
//

import Foundation
import GoogleSignIn
import GoogleSignInSwift
import FirebaseAuth

@MainActor
class AuthenticationViewModel: ObservableObject {
    
    @Published var userSession: FirebaseAuth.User?
    
    init() {
        self.userSession = Auth.auth().currentUser
    }

    
    func signInWithGoogle() {
        guard let windowScene = UIApplication.shared.connectedScenes.first as? UIWindowScene,
              let window = windowScene.windows.first,
              let rootViewController = window.rootViewController else {
            print("Error: Could not get the main view for Google Sign-In.")
            return
        }

        GIDSignIn.sharedInstance.signIn(withPresenting: rootViewController) { gidResult, error in
            if let error = error {
                print("Error in Google Sign-In: \(error.localizedDescription)")
                return
            }

            guard let user = gidResult?.user,
                  let idToken = user.idToken?.tokenString else {
                print("Error: Google user or ID Token not found.")
                return
            }
            
            let credential = GoogleAuthProvider.credential(withIDToken: idToken,
                                                         accessToken: user.accessToken.tokenString)

            Auth.auth().signIn(with: credential) { authResult, error in
                if let error = error {
                    print("Error authenticating with Firebase: \(error.localizedDescription)")
                    return
                }
                
                guard let firebaseUser = authResult?.user else { return }
                print("✅ Success! User signed in to Firebase.")
                print("User: \(firebaseUser.displayName ?? "N/A"), Email: \(firebaseUser.email ?? "N/A")")
                self.userSession = firebaseUser
            }
        }
    }
    
    func signOut() {
            do {
                try Auth.auth().signOut()
                self.userSession = nil 
            } catch let signOutError as NSError {
                print("Error signing out: %@", signOutError)
            }
        }
    
}
