//
//  AppButtonStyle.swift
//  ICNDb
//
//  Created by Zak Barlow on 21/09/2021.
//

import SwiftUI

struct AppButtonStyle: ViewModifier {
    func body(content: Content) -> some View {
        content
            .font(.title)
            .foregroundColor(.white)
            .padding([.leading, .trailing], 10)
            .padding([.top, .bottom], 5)
            .frame(maxWidth: .infinity)
            .background(LinearGradient(colors: [Colors.appBlue, Colors.appLightBlue], startPoint: .leading, endPoint: .trailing))
            .cornerRadius(10)
    }
}

extension View {
    func appButtonStyle() -> some View {
        modifier(AppButtonStyle())
    }
}
