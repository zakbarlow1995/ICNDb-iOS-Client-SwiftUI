//
//  JokesListView.swift
//  ICNDb
//
//  Created by Zak Barlow on 22/09/2021.
//

import SwiftUI

struct JokesListView: View {
    
    @StateObject private var viewModel = HomeViewModel()
    
    var body: some View {
        List {
            ForEach(1..<100) { item in
                Text("\(item)")
            }
            Rectangle()
                .onAppear { print("Reached end of scroll view")  }
        }
    }
}

struct JokesListView_Previews: PreviewProvider {
    static var previews: some View {
        JokesListView()
    }
}

