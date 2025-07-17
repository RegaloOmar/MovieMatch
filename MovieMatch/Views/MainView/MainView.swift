//
//  MainView.swift
//  MovieMatch
//
//  Created by Omar Regalado Mendoza on 16/07/25.
//

import SwiftUI

struct MainView: View {
    //Viewmodel to handle firebase authentication
    @EnvironmentObject var authViewModel: AuthenticationViewModel
    @StateObject private var viewModel = MainViewModel()
    var body: some View {
        NavigationStack {
           List(viewModel.movies) { movie in
               Text(movie.title)
           }
           .navigationTitle("Popular Movies")
           .toolbar {
               ToolbarItem(placement: .navigationBarTrailing) {
                   Button(action: {
                       authViewModel.signOut()
                   }) {
                      Text("Sign Out")
                          .font(.headline)
                          .foregroundColor(.white)
                          .padding()
                          .background(Color.red)
                          .cornerRadius(10)
                  }
               }
           }
           .task {
               await viewModel.loadPopularMovies()
           }
       }
   }
}

#Preview {
    MainView()
        .environmentObject(AuthenticationViewModel())
}
