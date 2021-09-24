//
//  StorageService.swift
//  ICNDb
//
//  Created by Zak Barlow on 24/09/2021.
//

import Combine

final class StorageService: ObservableObject {

    static let shared = StorageService()
    private init() {}

    private enum UserDefaultsKeys: String {
        case isExplicitEnabled
    }
    
    let objectWillChange = PassthroughSubject<Void, Never>()
    
    @UserDefault(UserDefaultsKeys.isExplicitEnabled.rawValue, defaultValue: false)
    var isExplicitEnabled: Bool {
        willSet {
            objectWillChange.send()
        }
    }
}
