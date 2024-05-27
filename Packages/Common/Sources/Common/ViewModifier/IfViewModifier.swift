//
//  IfViewModifier.swift
//  
//
//  Created by Arturo Murillo on 27/5/24.
//

import SwiftUI

public extension View {
    @ViewBuilder func `if`<Content: View>(_ condition: Bool,
                                          transform: (Self) -> Content) -> some View {
        if condition {
            transform(self)
        } else {
            self
        }
    }
}
