//
//  ContentView.swift
//  MovieMatch
//
//  Created by Omar Regalado Mendoza on 25/06/25.
//

import SwiftUI
import AuthenticationServices

struct ContentView: View {
    @EnvironmentObject var viewModel: AuthenticationViewModel
    
    var body: some View {
        if viewModel.userSession != nil {
            MainView()
        } else {
            LoginView()
        }
    }
}

struct LoginView: View {

    @EnvironmentObject var viewModel: AuthenticationViewModel
    @State private var email = ""
    @State private var password = ""

    var body: some View {
        NavigationStack {
            VStack(spacing: 15) {
                
                Spacer()
                
                Text("MovieMatch")
                    .font(.system(size: 40, weight: .bold))
                    .foregroundColor(.blue)
                
                TextField("Email", text: $email)
                    .keyboardType(.emailAddress)
                    .autocapitalization(.none)
                    .padding()
                    .background(Color(.secondarySystemBackground))
                    .cornerRadius(10)

                SecureField("Password", text: $password)
                    .padding()
                    .background(Color(.secondarySystemBackground))
                    .cornerRadius(10)
                
                Button(action: {
                    print("Botón de Iniciar Sesión presionado.")
                }) {
                    Text("Login")
                        .font(.headline)
                        .foregroundColor(.white)
                        .padding()
                        .frame(maxWidth: .infinity)
                        .background(Color.blue)
                        .cornerRadius(10)
                }
                
                Divider()
                    .overlay(Text("O").padding(.horizontal, 10).background(Color(.systemBackground)))

                Button(action: {
                    print("Botón de Registrarse presionado.")
                }) {
                    Text("Register with Email")
                        .font(.headline)
                        .foregroundColor(.white)
                        .padding()
                        .frame(maxWidth: .infinity)
                        .background(Color.green)
                        .cornerRadius(10)
                }
                
                SignInWithAppleButton(
                    onRequest: { request in
                        request.requestedScopes = [.fullName, .email]
                    },
                    onCompletion: { result in
                        switch result {
                        case .success(let authResults):
                            print("Autorización exitosa.")
                        case .failure(let error):
                            print("Autorización fallida: \(error.localizedDescription)")
                        }
                    }
                )
                .signInWithAppleButtonStyle(.black)
                .frame(height: 60)
                .cornerRadius(10)
                
                Button(action: {
                    viewModel.signInWithGoogle()
                }) {
                    HStack {
                        Image("google-logo")
                            .resizable()
                            .aspectRatio(contentMode: .fit)
                            .frame(width: 25, height: 25)
                        
                        Text("Sign in with Google")
                            .font(.headline)
                            .foregroundColor(.black.opacity(0.8))
                    }
                    .padding()
                    .frame(maxWidth: .infinity)
                    .background(
                        RoundedRectangle(cornerRadius: 10)
                            .stroke(Color.gray.opacity(0.5), lineWidth: 1)
                    )
                }
                .frame(height: 50)

                Spacer()
            }
            .padding()
            .navigationTitle("Bienvenido")
        }
    }
}

#Preview {
    ContentView()
        .environmentObject(AuthenticationViewModel())
}
