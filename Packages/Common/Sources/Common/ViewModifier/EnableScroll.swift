//
//  EnableScroll.swift
//  
//
//  Created by Arturo Murillo on 27/5/24.
//

import SwiftUI

public struct EnableScrollViewModifier: ViewModifier {
    let isEnabled: Bool
    
    public func body(content: Content) -> some View {
        if #available(iOS 16.0, *) {
            content
                .scrollDisabled(!isEnabled)
        } else {
            content
        }
    }
}

public extension View {
    func enableScroll(isEnabled: Bool) -> some View {
        modifier(EnableScrollViewModifier(isEnabled: isEnabled))
    }
}
