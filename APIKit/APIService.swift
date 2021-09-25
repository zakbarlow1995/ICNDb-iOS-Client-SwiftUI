//
//  APIService.swift
//  APIKit
//
//  Created by Zak Barlow on 21/09/2021.
//

import Combine

public class APIService {
    
    private init() {}
    
    private var cancellable: AnyCancellable?
    
    public static let shared = APIService()
    
    private enum APIServiceError: Error, LocalizedError {
        case invalidURL
        
        var errorDescription: String? {
            switch self {
            case .invalidURL: return "Invalid URL."
            }
        }
    }
    
    private struct APIComponents {
        static let scheme = "https"
        static let host = "api.icndb.com"
        static let path = "/jokes/random"
    }
    
    private func makeRequestUrl(
        jokeCount: Int = 1,
        excludeCategories: [String] = ["explicit"],
        names: (firstName: String, lastName: String)? = nil
    ) -> URL? {
        var components = URLComponents()
        components.scheme = APIComponents.scheme
        components.host = APIComponents.host
        components.path = jokeCount > 1 ? APIComponents.path + "/\(jokeCount)" : APIComponents.path
        
        var queryItems = [URLQueryItem(name: "escape", value: "javascript")]
        if !excludeCategories.isEmpty {
            queryItems.append(URLQueryItem(name: "exclude", value: "[\(excludeCategories.joined(separator: ","))]"))
        }
        if let names = names {
            queryItems.append(URLQueryItem(name: "firstName", value: names.firstName))
            queryItems.append(URLQueryItem(name: "lastName", value: names.lastName))
        }
        components.queryItems = queryItems
        
        return components.url
    }
    
    public func fetchJoke(
        explicitEnabled: Bool = false,
        customCharacter: (firstName: String, lastName: String)? = nil,
        completion: @escaping (String?, Error?) -> Void)
    {
        guard let url = makeRequestUrl(excludeCategories: explicitEnabled ? [] : ["explicit"], names: customCharacter) else { completion(nil, APIServiceError.invalidURL); return }
        cancellable?.cancel()
        cancellable = URLSession.shared.dataTaskPublisher(for: url)
            .map { $0.data }
            .decode(type: JokeResponse.self, decoder: JSONDecoder())
            .eraseToAnyPublisher()
            .receive(on: DispatchQueue.main)
            .sink(receiveCompletion: { ended in
                switch ended {
                case .finished:
                    break
                case let .failure(error):
                    completion(nil, error)
                }
            }, receiveValue: { result in
                completion(result.value.joke, nil)
            })
    }
    
    public func fetchJokes(
        count: Int = 20,
        explicitEnabled: Bool = false,
        customCharacter: (firstName: String, lastName: String)? = nil,
        completion: @escaping ([String]?, Error?) -> Void)
    {
        guard let url = makeRequestUrl(jokeCount: count, excludeCategories: explicitEnabled ? [] : ["explicit"], names: customCharacter) else { completion(nil, APIServiceError.invalidURL); return }
        cancellable?.cancel()
        cancellable = URLSession.shared.dataTaskPublisher(for: url)
            .map { $0.data }
            .decode(type: JokesResponse.self, decoder: JSONDecoder())
            .eraseToAnyPublisher()
            .receive(on: DispatchQueue.main)
            .sink(receiveCompletion: { ended in
                switch ended {
                case .finished:
                    break
                case let .failure(error):
                    completion(nil, error)
                }
            }, receiveValue: { result in
                completion(result.value.map { $0.joke }, nil)
            })
    }
}
