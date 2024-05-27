//
//  Header.swift
//
//
//  Created by Arturo Murillo on 26/5/24.
//

import SwiftUI
import DesignSystem

struct Header: View {
    let title: String
    let subtitle: String?
    let shrinked: Bool
    
    enum Constants {
        static let verticalSpacing: CGFloat = 10
        static let verticalOffset: CGFloat = 30
    }
    
    var body: some View {
        ZStack {
            LinearGradient(gradient: Gradient(colors: [ColorType.gradientStart.swiftUIColor, 
                                                       ColorType.gradientEnd.swiftUIColor]),
                           startPoint: .zero,
                           endPoint: .bottom)
            
        }
        .overlay(alignment: .bottomTrailing) {
            AssetType.homeBackground.swiftUIImage
                .resizable()
                .frame(maxWidth: .infinity)
                .aspectRatio(contentMode: .fit)
                .alignmentGuide(.bottom) { d in
                    return shrinked ? d.height * 1 : d.height * 0.6
                }
        }
        .overlay(alignment: .topTrailing, content: {
            AssetType.cloud.swiftUIImage
                .alignmentGuide(.top) { d in
                    return shrinked ? -d.height * 8 : -d.height * 5
                }
        })
        .overlay(alignment: .leading, content: {
            VStack(alignment: .leading, spacing: Constants.verticalSpacing) {
                Text(title)
                    .designSystemFontAndColor(font: .largeTitle,
                                              color: ColorType.white.swiftUIColor)
                
                if let subtitle {
                    Text(subtitle)
                        .designSystemFontAndColor(font: .headline,
                                                  color: ColorType.white.swiftUIColor)
                }
            }
            .animation(.easeInOut,
                       value: shrinked)
            .padding(.leading)
            .offset(x: 0, y: Constants.verticalOffset)
        })
        .ignoresSafeArea()
        .bounceAnimation(key: shrinked)
    }
}
