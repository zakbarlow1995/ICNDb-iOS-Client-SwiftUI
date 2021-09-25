//
//  CharacterInputViewModel.swift
//  ICNDb
//
//  Created by Zak Barlow on 22/09/2021.
//

import APIKit
import SwiftUI

final class CharacterInputViewModel: ObservableObject {
    
    enum InputError: Error {
        case invalidCharacterName
    }
    
    private var _joke: String?
    private var _error: Error?
    private let dataFetchable: DataFetchable
    
    @Published var alertItem: AlertItem?
    @Published var firstName = ""
    @Published var lastName = ""
    
    public init(dataFetchable: DataFetchable = APIService.shared) {
        self.dataFetchable = dataFetchable
    }
    
    func fetchJoke() {
        if let sanitisedFirstName = sanitisedInput(firstName),
           let sanitisedLastName = sanitisedInput(lastName) {
            dataFetchable.fetchJoke(explicitEnabled: StorageService.shared.isExplicitEnabled, customCharacter: (sanitisedFirstName, sanitisedLastName)) { [weak self] joke, error in
                if let joke = joke {
                    self?.update(joke)
                    self?.alertItem = AlertItem.forJoke(joke)
                } else {
                    self?.update(error: error)
                    self?.alertItem = AlertItem.forError(error)
                }
            }
        } else {
            update(error: InputError.invalidCharacterName)
            alertItem = AlertItem(title: Text("Invalid Character Name"), message: Text("Please only enter alphanumerics in both fields & try again"), buttonTitle: Text("Ok"))
        }
    }
    
    private func sanitisedInput(_ input: String) -> String? {
        let strippedInput = input.trimmingCharacters(in: .whitespacesAndNewlines)
        guard !strippedInput.isEmpty && strippedInput.trimmingCharacters(in: .alphanumerics).isEmpty else { return nil }
        return strippedInput
    }
    
    private func update(_ joke: String? = nil, error: Error? = nil) {
        _joke = joke
        _error = error
    }
}

extension CharacterInputViewModel {
    var joke: String? {
        _joke
    }
    
    var error: Error? {
        _error
    }
}
