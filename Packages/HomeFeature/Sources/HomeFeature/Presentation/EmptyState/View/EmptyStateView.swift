//
//  ProductsEmptyStateView.swift
//
//
//  Created by Arturo Murillo on 26/5/24.
//

import SwiftUI
import DesignSystem

struct EmptyStateView: View {
    let viewModel: EmptyStateViewModelPresentation
    
    enum Constants {
        static let verticalSpacing: CGFloat = 10
    }
    
    var body: some View {
        VStack(spacing: Constants.verticalSpacing) {
            Spacer()
            viewModel.backgroundImage.swiftUIImage
                .resizable()
                .aspectRatio(contentMode: .fit)
                .frame(height: 180)
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
        }
        .padding()
    }
}
