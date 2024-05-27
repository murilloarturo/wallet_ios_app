//
//  DefaultAnimationViewModifier.swift
//  
//
//  Created by Arturo Murillo on 27/5/24.
//

import SwiftUI

public struct BounceAnimationViewModifier<Key>: ViewModifier where Key: Equatable {
    let key: Key
    
    public func body(content: Content) -> some View {
        content
            .animation(.spring(duration: 0.8, bounce: 0.2),
                       value: key)
    }
}

public extension View {
    func bounceAnimation<Key>(key: Key) -> some View where Key: Equatable {
        modifier(BounceAnimationViewModifier(key: key))
    }
}
