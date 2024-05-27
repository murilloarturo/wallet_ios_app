//
//  HomeTabModel.swift
//  
//
//  Created by Arturo Murillo on 26/5/24.
//

import SwiftUI
import DesignSystem

public struct HomeViewModelPresentation: Equatable {
    struct Tab: Equatable {
        let title: String
        let asset: ImageAsset
        let type: HomeTab
        
        func hash(into hasher: inout Hasher) {
            hasher.combine(type)
        }
        
        static func == (lhs: Tab, rhs: Tab) -> Bool {
            lhs.type == rhs.type
        }
    }
    
    let isLoading: Bool
    let title: String
    let subtitle: String?
    let tabs: [Tab]
    let showHomeTab: Bool
    let showProductsTab: Bool
    let topSpace: CGFloat
    let showProfileButton: Bool
    let containerHeight: CGFloat
    let wallet: WalletViewModelPresentation
    let emptyState: EmptyStateViewModelPresentation?
}
