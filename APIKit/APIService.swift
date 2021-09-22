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
    
    enum APIServiceError: Error, LocalizedError {
        case invalidURL
        
        var errorDescription: String? {
            switch self {
            case .invalidURL: return "Invalid URL."
            }
        }
    }
    
    private var cancellable: AnyCancellable?
    
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
        completion: @escaping (String?, Error?) -> Void)
    {
        guard let url = randomJokeUrl(names: customCharacter) else { completion(nil, APIServiceError.invalidURL); return }
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
                completion(result.value.formattedJoke(), nil)
            })
    }
    
    public func fetchJokes(
        count: Int = 20,
        completion: @escaping ([String]?, Error?) -> Void)
    {
        guard let url = randomJokesUrl(count: count) else { completion(nil, APIServiceError.invalidURL); return }
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
                completion(result.value.map { $0.formattedJoke() }, nil)
            })
    }
}
