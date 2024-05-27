//
//  HideScrollIndicator.swift
//
//
//  Created by Arturo Murillo on 27/5/24.
//

import SwiftUI

public struct HideScrollIndicatorViewModifier: ViewModifier {
    public func body(content: Content) -> some View {
        if #available(iOS 16.0, *) {
            content
                .scrollIndicators(.hidden)
        } else {
            content
        }
    }
}

public extension View {
    func hideScrollIndicator() -> some View {
        modifier(HideScrollIndicatorViewModifier())
    }
}
