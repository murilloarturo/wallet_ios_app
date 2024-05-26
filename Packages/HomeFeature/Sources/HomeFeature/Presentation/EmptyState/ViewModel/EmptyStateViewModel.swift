//
//  EmptyStateViewModel.swift
//
//
//  Created by Arturo Murillo on 26/5/24.
//

import Foundation
import DesignSystem
import Localization

@MainActor
class EmptyStateViewModel: ObservableObject {
    @Published var backgroundImage: ImageAsset
    @Published var title: String
    @Published var subtitle: String
    
    static func buildDefault() -> Self {
        .init(backgroundImage: AssetType.emptyState, 
              title: LocalizedString.comingSoon,
              subtitle: LocalizedString.workInProgress)
    }
    
    required init(backgroundImage: ImageAsset,
         title: String,
         subtitle: String) {
        self.backgroundImage = backgroundImage
        self.title = title
        self.subtitle = subtitle
    }
}
