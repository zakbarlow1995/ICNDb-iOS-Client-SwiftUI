//
//  DataFetchable.swift
//  ICNDb
//
//  Created by Zak Barlow on 21/09/2021.
//

import APIKit

public protocol DataFetchable {
    func fetchJoke(customCharacter: (firstName: String, lastName: String)?, completion: @escaping (String?, Error?) -> Void)
    func fetchJokes(count: Int, completion: @escaping ([String]?, Error?) -> Void)
}

extension APIService: DataFetchable {}
