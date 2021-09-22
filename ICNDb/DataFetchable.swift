//
//  DataFetchable.swift
//  ICNDb
//
//  Created by Zak Barlow on 21/09/2021.
//

import APIKit

public protocol DataFetchable {
    func fetchJoke(customCharacter: (firstName: String, lastName: String)?, completion: @escaping (Joke?) -> Void)
    func fetchJokes(count: Int, completion: @escaping ([Joke]?) -> Void)
}

extension APIService: DataFetchable {}
