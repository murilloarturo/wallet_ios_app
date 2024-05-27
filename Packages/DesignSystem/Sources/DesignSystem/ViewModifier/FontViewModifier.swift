//
//  FontViewModifier.swift
//  
//
//  Created by Arturo Murillo on 27/5/24.
//

import SwiftUI

public struct FontViewModifier: ViewModifier {
    let font: FontType
    let color: Color
    
    public func body(content: Content) -> some View {
        content
            .font(font.font)
            .foregroundColor(color)
    }
}

public extension View {
    func designSystemFontAndColor(font: FontType, color: Color) -> some View {
        modifier(FontViewModifier(font: font, color: color))
    }
}
