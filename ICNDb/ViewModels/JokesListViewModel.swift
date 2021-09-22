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
    
    // Note - artificially inducing delay here, or else with half-decent internet connection you'll never see more than the briefest of flashes of the batch-fetch loading state
    func fetchMoreJokes() {
        isFetchingMore = true
        DispatchQueue.main.asyncAfter(deadline: .now().advanced(by: .milliseconds(500))) { [weak self] in
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
