//
//  HomeViewModel.swift
//
//
//  Created by Arturo Murillo on 26/5/24.
//

import Foundation
import DesignSystem
import Localization

@MainActor
public class HomeViewModel: ObservableObject {
    struct Tab: Hashable {
        let title: String
        let asset: ImageAsset
        let type: HomeTab
        
        func hash(into hasher: inout Hasher) {
            hasher.combine(type)
        }
        
        static func == (lhs: HomeViewModel.Tab, rhs: HomeViewModel.Tab) -> Bool {
            lhs.type == rhs.type
        }
    }
    
    private var model: HomeModel = .init(tabs: [.home, .products]) {
        didSet {
            tabs = model.tabs.map { tab in
                switch tab {
                case .home:
                    return Tab(title: LocalizedString.walletTab,
                               asset: AssetType.walletIcon,
                               type: tab)
                case .products:
                    return Tab(title: LocalizedString.productsTab,
                               asset: AssetType.productsIcon,
                               type: tab)
                }
            }
        }
    }
    
    @Published var tabs: [Tab] = []
    
    init(model: HomeModel) {
        self.model = model
        
        tabs = model.tabs.map { tab in
            switch tab {
            case .home:
                return Tab(title: LocalizedString.walletTab,
                           asset: AssetType.walletIcon,
                           type: tab)
            case .products:
                return Tab(title: LocalizedString.productsTab,
                           asset: AssetType.productsIcon,
                           type: tab)
            }
        }
    }
}
