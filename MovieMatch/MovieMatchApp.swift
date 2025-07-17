//
//  MovieMatchApp.swift
//  MovieMatch
//
//  Created by Omar Regalado Mendoza on 25/06/25.
//

import SwiftUI
import FirebaseCore

@main
struct MovieMatchApp: App {
    @StateObject private var authViewModel: AuthenticationViewModel
    
    init() {
        FirebaseApp.configure()
        _authViewModel = StateObject(wrappedValue: AuthenticationViewModel())
    }
    
    var body: some Scene {
        WindowGroup {
            ContentView()
                .environmentObject(authViewModel)
        }
    }
}
