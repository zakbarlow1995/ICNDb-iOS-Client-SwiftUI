//
//  MockDataService.swift
//  ICNDbTests
//
//  Created by Zak Barlow on 25/09/2021.
//

@testable import ICNDb
import Foundation

final class MockDataService: DataFetchable {
    
    private let fallbackError = NSError(domain: "Both joke & error = nil", code: -1, userInfo: nil)
    
    public var joke: String? = "Test Joke" {
        didSet {
            if joke != nil {
                error = nil
            } else if joke == nil && error == nil {
                error = fallbackError
            }
        }
    }
    
    public var error: Error? {
        didSet {
            if error != nil {
                joke = nil
            } else if joke == nil && error == nil {
                error = fallbackError
            }
        }
    }
    
    func fetchJoke(explicitEnabled: Bool, customCharacter: (firstName: String, lastName: String)?, completion: @escaping (String?, Error?) -> Void) {
        if let joke = joke {
            completion(joke, nil)
        } else {
            let resultantError = error ?? fallbackError
            completion(nil, resultantError)
        }
    }
    
    func fetchJokes(count: Int, explicitEnabled: Bool, customCharacter: (firstName: String, lastName: String)?, completion: @escaping ([String]?, Error?) -> Void) {
        if let joke = joke {
            completion([joke], nil)
        } else {
            let resultantError = error ?? fallbackError
            completion(nil, resultantError)
        }
    }
}
