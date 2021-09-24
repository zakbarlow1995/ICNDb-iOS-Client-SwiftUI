//
//  DataFetchable.swift
//  ICNDb
//
//  Created by Zak Barlow on 21/09/2021.
//

import APIKit

public protocol DataFetchable {
    func fetchJoke(explicitEnabled: Bool, customCharacter: (firstName: String, lastName: String)?, completion: @escaping (String?, Error?) -> Void)
    func fetchJokes(count: Int, explicitEnabled: Bool, customCharacter: (firstName: String, lastName: String)?, completion: @escaping ([String]?, Error?) -> Void)
}

extension APIService: DataFetchable {}
