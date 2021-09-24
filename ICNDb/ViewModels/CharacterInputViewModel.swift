//
//  CharacterInputViewModel.swift
//  ICNDb
//
//  Created by Zak Barlow on 22/09/2021.
//

import APIKit
import SwiftUI

final class CharacterInputViewModel: ObservableObject {
    
    public init(dataFetchable: DataFetchable = APIService.shared) {
        self.dataFetchable = dataFetchable
    }
    
    private let dataFetchable: DataFetchable
    
    @Published var alertItem: AlertItem?
    @Published var firstName = ""
    @Published var lastName = ""
    
    func fetchJoke() {
        if let sanitisedFirstName = sanitisedInput(firstName),
           let sanitisedLastName = sanitisedInput(lastName) {
            dataFetchable.fetchJoke(explicitEnabled: StorageService.shared.isExplicitEnabled, customCharacter: (sanitisedFirstName, sanitisedLastName)) { [weak self] joke, error in
                if let joke = joke {
                    self?.alertItem = AlertItem.forJoke(joke)
                } else {
                    self?.alertItem = AlertItem.forError(error)
                }
            }
        } else {
            alertItem = AlertItem(title: Text("Invalid Character Name"), message: Text("Please only enter alphanumerics in both fields & try again"), buttonTitle: Text("Ok"))
        }
    }
    
    private func sanitisedInput(_ input: String) -> String? {
        let strippedInput = input.trimmingCharacters(in: .whitespacesAndNewlines)
        guard !strippedInput.isEmpty && strippedInput.trimmingCharacters(in: .alphanumerics).isEmpty else { return nil }
        return strippedInput
    }
}
