//
//  WalletViewModel.swift
//
//
//  Created by Arturo Murillo on 26/5/24.
//

import SwiftUI
import DesignSystem

struct WalletViewModelPresentation: Equatable {
    struct Item: Hashable {
        let id: String
        let name: String
        let description: String
        let iconURL: URL?
        let amount: String
        
        func hash(into hasher: inout Hasher) {
            hasher.combine(id)
        }
        
        public static func == (lhs: Item, rhs: Item) -> Bool {
            lhs.id == rhs.id
        }
    }
    
    let title: String
    let viewAllButtonTitle: String
    let items: [Item]
}
