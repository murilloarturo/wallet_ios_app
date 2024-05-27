//
//  ListClearBackgroundViewModifier.swift
//  
//
//  Created by Arturo Murillo on 27/5/24.
//

import SwiftUI

public struct ListClearBackgroundModifier: ViewModifier {
    public func body(content: Content) -> some View {
        if #available(iOS 16.0, *) {
            content
                .scrollContentBackground(.hidden)
        } else {
            content
                .onAppear {
                    UITableView.appearance().backgroundColor = .clear
                }
        }
    }
}

public extension View {
    func clearBackground() -> some View {
        modifier(ListClearBackgroundModifier())
    }
}
