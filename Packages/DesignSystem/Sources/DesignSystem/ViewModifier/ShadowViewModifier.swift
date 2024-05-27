//
//  ListCardShadowModifier.swift
//  
//
//  Created by Arturo Murillo on 27/5/24.
//

import SwiftUI

public struct ListCardShadowModifier: ViewModifier {
    let opacity: CGFloat
    let radius: CGFloat
    let x: CGFloat
    let y: CGFloat
    
    public func body(content: Content) -> some View {
        content
            .shadow(color: .black.opacity(opacity),
                    radius: radius, 
                    x: x,
                    y: y)
    }
}

public extension View {
    func addCardShadow() -> some View {
        modifier(ListCardShadowModifier(opacity: 0.15, radius: 11, x: 0, y: 11))
    }
    
    func addContainerShadow() -> some View {
        modifier(ListCardShadowModifier(opacity: 0.25, radius: 10, x: 0, y: 5))
    }
    
    func addTopContainerShadow() -> some View {
        modifier(ListCardShadowModifier(opacity: 0.25, radius: 10, x: 0, y: -5))
    }
}
