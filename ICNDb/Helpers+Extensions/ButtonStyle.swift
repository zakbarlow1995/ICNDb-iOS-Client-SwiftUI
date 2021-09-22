//
//  ButtonStyle.swift
//  ICNDb
//
//  Created by Zak Barlow on 21/09/2021.
//

import SwiftUI

struct ButtonStyle: ViewModifier {
    func body(content: Content) -> some View {
        content
            .font(.largeTitle)
            .foregroundColor(.white)
            .padding()
            .background(Colors.appBlue)
            .cornerRadius(10)
    }
}

extension View {
    func buttonStyle() -> some View {
        modifier(ButtonStyle())
    }
}