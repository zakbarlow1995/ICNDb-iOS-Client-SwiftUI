//
//  CharacterInputView.swift
//  ICNDb
//
//  Created by Zak Barlow on 22/09/2021.
//

import SwiftUI

struct CharacterInputView: View {
    
    @StateObject private var viewModel = CharacterInputViewModel()
    
    var body: some View {
        Form {
            Section(header: Text("Custom Character Information")) {
                TextField("First Name", text: $viewModel.firstName)
                TextField("Last Name", text: $viewModel.lastName)
            }
            Button {
                viewModel.fetchJoke()
                hideKeyboard()
            } label: {
                HStack {
                    Text("Search")
                    Image(systemName: "magnifyingglass")
                }
            }
            .appButtonStyle()
        }
        .alert(item: $viewModel.alertItem) { alertItem -> Alert in
            Alert(title: alertItem.title,
                  message: alertItem.message,
                  dismissButton: .default(alertItem.buttonTitle))
        }
        .navigationBarTitle(Text("Text Input"), displayMode: .inline)
        .navigationBarItems(trailing: Button {
            hideKeyboard()
        } label: {
            Image(systemName: "keyboard.chevron.compact.down")
        })
//        .onTapGesture { // <--- this method can block fields, so have to use the canImport(UIKit method), similarly adding custom swipe-to-dismiss keyboard gesture combinations does not play nice with TextFields inside Forms.
//            hideKeyboard()
//        }
    }
}

struct CharacterInputView_Previews: PreviewProvider {
    static var previews: some View {
        CharacterInputView()
    }
}

#if canImport(UIKit)
extension View {
    func hideKeyboard() {
        UIApplication.shared.sendAction(#selector(UIResponder.resignFirstResponder), to: nil, from: nil, for: nil)
    }
}
#endif
