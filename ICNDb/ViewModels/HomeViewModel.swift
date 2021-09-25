//
//  HomeViewModel.swift
//  ICNDb
//
//  Created by Zak Barlow on 21/09/2021.
//

import APIKit
import SwiftUI

final class HomeViewModel: ObservableObject {
    
    private var _joke: String?
    private var _error: Error?
    private let dataFetchable: DataFetchable
    
    @Published var alertItem: AlertItem?
    
    public init(dataFetchable: DataFetchable = APIService.shared) {
        self.dataFetchable = dataFetchable
    }
    
    func fetchJoke() {
        dataFetchable.fetchJoke(explicitEnabled: StorageService.shared.isExplicitEnabled, customCharacter: nil) { [weak self] joke, error in
            if let joke = joke {
                self?.update(joke)
                self?.alertItem = AlertItem.forJoke(joke)
            } else {
                self?.update(error: error)
                self?.alertItem = AlertItem.forError(error)
            }
        }
    }
    
    private func update(_ joke: String? = nil, error: Error? = nil) {
        _joke = joke
        _error = error
    }
}

extension HomeViewModel {
    var joke: String? {
        _joke
    }
    
    var error: Error? {
        _error
    }
}
