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
                
                Button {
                    viewModel.fetchJoke()
                } label: {
                    HStack {
                        Text("Random Joke")
                        Image(systemName: "dice")
                    }
                }
                .appButtonStyle()
                .padding()

                
                NavigationLink(destination: CharacterInputView()) {
                    HStack{
                        Text("Text Input")
                        Image(systemName: "keyboard")
                    }
                    .appButtonStyle()
                    .padding()
                }
                .buttonStyle(PlainButtonStyle())
                
                NavigationLink(destination: JokesListView()) {
                    HStack{
                        Text("Never-Ending Jokes")
                        Image(systemName: "list.bullet")
                    }
                    .appButtonStyle()
                    .padding()
                }
                .buttonStyle(PlainButtonStyle())
                
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
