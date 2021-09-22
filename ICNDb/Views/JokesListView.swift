//
//  JokesListView.swift
//  ICNDb
//
//  Created by Zak Barlow on 22/09/2021.
//

import SwiftUI

struct JokesListView: View {
    
    @StateObject private var viewModel = JokesListViewModel()
    
    var body: some View {
        List {
            ForEach(viewModel.jokes, id: \.id) { item in
                Text("\(item.joke)")
                    .padding()
            }
            if viewModel.isFetchingMore {
                Text("Fetching more jokes...")
                    .bold()
                    .foregroundColor(Colors.appBlue)
                    .multilineTextAlignment(.center)
                    .padding()
            }
            Color.clear
                .onAppear {
                    print("Reached end of scroll view")
                    viewModel.fetchMoreJokes()
                }
        }
        .navigationBarTitle(Text("Never-Ending Jokes"), displayMode: .inline)
    }
}

struct JokesListView_Previews: PreviewProvider {
    static var previews: some View {
        JokesListView()
    }
}

