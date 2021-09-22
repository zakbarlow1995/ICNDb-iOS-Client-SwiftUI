//
//  HomeView.swift
//  ICNDb
//
//  Created by Zak Barlow on 21/09/2021.
//

import SwiftUI

struct HomeView: View {
    
    @StateObject private var viewModel = HomeViewModel()
    
    var body: some View {
        NavigationView {
            VStack {
                Button("Random Joke") {
                    print("Random Joke")
                    viewModel.fetchJoke()
                }.buttonStyle()
                Button("Text Input") {
                    print("Text Input")
                }.buttonStyle()
                NavigationLink(destination: JokesListView()) {
                    Text("Never-Ending Jokes")
                        .buttonStyle()
                }
            }
            .alert(item: $viewModel.alertItem) { alertItem -> Alert in
                Alert(title: alertItem.title,
                      message: alertItem.message,
                      dismissButton: .default(alertItem.buttonTitle, action: {
                        print("Joke Fetched")
                      }))
            }
            .navigationBarTitle(Text("ICNDb"), displayMode: .large)
        }
        .accentColor(Colors.appBlue)
    }
}

struct HomeView_Previews: PreviewProvider {
    static var previews: some View {
        HomeView()
    }
}
