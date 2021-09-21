//
//  Joke.swift
//  APIKit
//
//  Created by Zak Barlow on 21/09/2021.
//

import Foundation

struct JokeResponse: Codable {
    let type: String
    let value: Joke
}

struct JokesResponse: Codable {
    let type: String
    let value: [Joke]
}

public struct Joke: Codable {
    public let id: Int
    public let joke: String
    public let categories: [String]
    
    public init(id: Int, joke: String, categories: [String]) {
        self.id = id
        self.joke = joke
        self.categories = categories
    }
}
