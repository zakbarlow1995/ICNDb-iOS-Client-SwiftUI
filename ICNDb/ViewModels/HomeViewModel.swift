//
//  HomeViewModel.swift
//  ICNDb
//
//  Created by Zak Barlow on 21/09/2021.
//

import APIKit
import SwiftUI

final class HomeViewModel: ObservableObject {
    
    public init(dataFetchable: DataFetchable = APIService.shared) {
        self.dataFetchable = dataFetchable
    }
    
    private let dataFetchable: DataFetchable
    
    @Published var alertItem: AlertItem?
    
    func fetchJoke() {
        dataFetchable.fetchJoke(explicitEnabled: StorageService.shared.isExplicitEnabled, customCharacter: nil) { [weak self] joke, error in
            if let joke = joke {
                self?.alertItem = AlertItem.forJoke(joke)
            } else {
                self?.alertItem = AlertItem.forError(error)
            }
        }
    }
}
