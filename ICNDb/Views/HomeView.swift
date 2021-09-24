//
//  HomeView.swift
//  ICNDb
//
//  Created by Zak Barlow on 21/09/2021.
//

import SwiftUI

struct HomeView: View {
    
    @StateObject private var viewModel = HomeViewModel()
    @ObservedObject private var sharedStorage = StorageService.shared
    // ^iOS 14+ can use @AppStorage instead of @ObservedObject dance
    
    var body: some View {
        NavigationView {
            VStack {
                Toggle(isOn: $sharedStorage.isExplicitEnabled) {
                    Text("Enable Explicit Jokes")
                }
                .padding()
                Spacer()
                Button("Random Joke") {
                    viewModel.fetchJoke()
                }
                .buttonStyle()
                .padding()
                NavigationLink(destination: CharacterInputView()) {
                    Text("Text Input")
                        .buttonStyle()
                        .padding()
                }
                NavigationLink(destination: JokesListView()) {
                    Text("Never-Ending Jokes")
                        .buttonStyle()
                        .padding()
                }
                Spacer()
            }
            .alert(item: $viewModel.alertItem) { alertItem -> Alert in
                Alert(title: alertItem.title,
                      message: alertItem.message,
                      dismissButton: .default(alertItem.buttonTitle))
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
