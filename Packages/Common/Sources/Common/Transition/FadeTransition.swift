//
//  FadeTransition.swift
//  
//
//  Created by Arturo Murillo on 27/5/24.
//

import SwiftUI

public extension AnyTransition {
    static var fade: AnyTransition {
        AnyTransition.opacity
                    .combined(with: .scale(scale: 0, anchor: .center))
                    .animation(.default)
    }
}
