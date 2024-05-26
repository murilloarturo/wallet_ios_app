//
//  ProductsEmptyStateView.swift
//
//
//  Created by Arturo Murillo on 26/5/24.
//

import SwiftUI
import DesignSystem

struct ProductsEmptyStateView: View {
    @State var viewModel: EmptyStateViewModel
    
    @MainActor public static func buildDefault() -> Self {
        .init(viewModel: EmptyStateViewModel.buildDefault())
    }
    
    init(viewModel: EmptyStateViewModel) {
        self.viewModel = viewModel
    }
    
    var body: some View {
        VStack(spacing: 10) {
            Spacer()
            viewModel.backgroundImage.swiftUIImage
                .padding(.bottom)
            
            Text(viewModel.title)
                .multilineTextAlignment(.center)
                .font(FontType.title2.font)
                .foregroundColor(ColorType.black.swiftUIColor)
            
            Text(viewModel.subtitle)
                .multilineTextAlignment(.center)
                .font(FontType.body.font)
                .foregroundColor(ColorType.gray.swiftUIColor)
            
            Spacer()
            Spacer()
        }
        .padding()
    }
}
