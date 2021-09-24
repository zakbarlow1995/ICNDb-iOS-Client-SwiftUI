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

struct Joke: Codable {
    let id: Int
    let joke: String
    let categories: [String]
    
    init(id: Int, joke: String, categories: [String]) {
        self.id = id
        self.joke = joke
        self.categories = categories
    }
}
