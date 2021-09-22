//
//  APIService.swift
//  APIKit
//
//  Created by Zak Barlow on 21/09/2021.
//

import Combine
//import Foundation

public class APIService {
    public static let shared = APIService()
    
    private init() {}
    
    private var cancellable: AnyCancellable?
    
//    public enum Endpoint: String {
//        case joke
//        case jokes
//    }
    
    private let path = "https://api.icndb.com/jokes/random"
    
    private func randomJokeUrl(names: (firstName: String, lastName: String)? = nil, exclude: [String] = ["explicit"]) -> URL? {
        guard !exclude.isEmpty else { return URL(string: path) }
        guard let url = URL(string: path) else { return nil}
        var urlComponents = URLComponents(url: url, resolvingAgainstBaseURL: false)
        var queryItems = urlComponents?.queryItems ?? []
        queryItems.append(URLQueryItem(name: "exclude", value: "[\(exclude.joined(separator: ","))]"))
        if let names = names {
            queryItems.append(URLQueryItem(name: "firstName", value: names.firstName))
            queryItems.append(URLQueryItem(name: "lastName", value: names.lastName))
        }
        urlComponents?.queryItems = queryItems
        return urlComponents?.url
    }
    
    private func randomJokesUrl(count: Int = 20) -> URL? {
        guard count > 1 else { return URL(string: path) }
        return URL(string: path + "/\(count)")
    }
    
    public func fetchJoke(
        customCharacter: (firstName: String, lastName: String)? = nil,
        completion: @escaping (Joke?) -> Void)
    {
        guard let url = randomJokeUrl(names: customCharacter) else { return }
        cancellable?.cancel()
        cancellable = URLSession.shared.dataTaskPublisher(for: url)
            .map { $0.data }
            .decode(type: JokeResponse.self, decoder: JSONDecoder())
//            .replaceError(with: [])
            .eraseToAnyPublisher()
            .receive(on: DispatchQueue.main)
            .sink(receiveCompletion: { error in
                print(error)
                completion(nil)
            }, receiveValue: { result in
                print(result.value)
                completion(result.value)
            })
    }
      
    public func fetchJokes(count: Int = 20, completion: @escaping ([Joke]?) -> Void) {
        guard let url = randomJokesUrl(count: count) else { return }
        cancellable?.cancel()
        cancellable = URLSession.shared.dataTaskPublisher(for: url)
            .map { $0.data }
            .decode(type: JokesResponse.self, decoder: JSONDecoder())
//            .replaceError(with: [])
            .eraseToAnyPublisher()
            .receive(on: DispatchQueue.main)
            .sink(receiveCompletion: { error in
                print(error)
                completion(nil)
            }, receiveValue: { result in
                print(result.value)
                completion(result.value)
            })
    }
}
