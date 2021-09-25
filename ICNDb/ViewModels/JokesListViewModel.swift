//
//  JokesListViewModel.swift
//  ICNDb
//
//  Created by Zak Barlow on 22/09/2021.
//

import APIKit
import SwiftUI

final class JokesListViewModel: ObservableObject {
    
    private let dataFetchable: DataFetchable
    private var _error: Error?
    
    @Published var jokes: [String] = []
    @Published var isFetchingMore: Bool = false
    @Published var alertItem: AlertItem?
    
    public init(dataFetchable: DataFetchable = APIService.shared) {
        self.dataFetchable = dataFetchable
    }
    
    // Note - Uncomment the following DispatchQueue block to artificially inducing delay here, or else with half-decent internet connection you'll never see more than the briefest of flashes of the batch-fetch loading state
    func fetchMoreJokes() {
        guard !isFetchingMore else { return }
        isFetchingMore = true
//        DispatchQueue.main.asyncAfter(deadline: .now().advanced(by: .milliseconds(500))) { [weak self] in
        dataFetchable.fetchJokes(count: 20, explicitEnabled: StorageService.shared.isExplicitEnabled, customCharacter: nil) { [weak self] result, error in
                if let result = result {
                    self?.jokes.append(contentsOf: result)
                } else {
                    self?._error = error
                    self?.alertItem = AlertItem.forError(error)
                }
                self?.isFetchingMore = false
            }
//        }
    }
}

extension JokesListViewModel {
    var error: Error? {
        _error
    }
}
