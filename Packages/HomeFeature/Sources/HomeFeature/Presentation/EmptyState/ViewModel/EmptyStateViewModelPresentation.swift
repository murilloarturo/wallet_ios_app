//
//  EmptyStateViewModelPresentation.swift
//
//
//  Created by Arturo Murillo on 27/5/24.
//

import DesignSystem

struct EmptyStateViewModelPresentation: Equatable {
    let backgroundImage: ImageAsset
    let title: String
    let subtitle: String
    
    static func == (lhs: EmptyStateViewModelPresentation, 
                    rhs: EmptyStateViewModelPresentation) -> Bool {
        lhs.title == rhs.title && lhs.subtitle == rhs.subtitle
    }
}
