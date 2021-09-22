//
//  AlertItem.swift
//  ICNDb
//
//  Created by Zak Barlow on 21/09/2021.
//

import SwiftUI

struct AlertItem: Identifiable {
    let id = UUID()
    var title: Text
    var message: Text
    var buttonTitle: Text
    
    static func forJoke(_ joke: String) -> AlertItem {
        AlertItem(title: Text("Random Joke"),
                  message: Text(joke),
                  buttonTitle: Text("OK"))
    }
    
    static func forError(_ error: Error?) -> AlertItem {
        AlertItem(title: Text("Whoops, Something Went Wrong!"),
                  message: Text("An error occured: \(error?.localizedDescription ?? "[Unknown Description].") Please try again"),
                                 buttonTitle: Text("OK"))
    }
}
