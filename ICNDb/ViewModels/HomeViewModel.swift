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
        dataFetchable.fetchJoke(customCharacter: nil) { [weak self] result in
            if let result = result {
                self?.alertItem = AlertItem.forJoke(result.joke)
            }
        }
    }
}
