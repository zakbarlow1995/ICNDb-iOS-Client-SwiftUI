//
//  JokesListViewModel.swift
//  ICNDb
//
//  Created by Zak Barlow on 22/09/2021.
//

import SwiftUI
import APIKit

final class JokesListViewModel: ObservableObject {
    
    public init(dataFetchable: DataFetchable = APIService.shared) {
        self.dataFetchable = dataFetchable
    }
    
    private let dataFetchable: DataFetchable
    
    @Published var jokes: [Joke] = []
    @Published var isFetchingMore: Bool = true
    
    func fetchMoreJokes() {
        isFetchingMore = true
        DispatchQueue.main.asyncAfter(deadline: .now().advanced(by: .milliseconds(300))) { [weak self] in
            self?.dataFetchable.fetchJokes(count: 20) { [weak self] result in
                if let result = result {
                    self?.jokes.append(contentsOf: result)
                }
                self?.isFetchingMore = false
            }
        }
//        dataFetchable.fetchJokes(count: 20) { [weak self] result in
//            if let result = result {
//                self?.jokes.append(contentsOf: result)
//            }
//            self?.isFetchingMore = false
//        }
    }
}
