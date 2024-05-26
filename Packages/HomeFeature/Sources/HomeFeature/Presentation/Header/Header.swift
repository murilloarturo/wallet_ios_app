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
    let subtitle: String
    let shrinked: Bool
    
    var body: some View {
        ZStack {
            
            LinearGradient(gradient: Gradient(colors: [ColorType.gradientStart.swiftUIColor, ColorType.gradientEnd.swiftUIColor]),
                           startPoint: .init(x: 0, y: 0),
                           endPoint: .bottom)
            
        }
        .overlay(alignment: .bottomTrailing) {
            AssetType.homeBackground.swiftUIImage
                .alignmentGuide(.bottom) { d in
                    return shrinked ? d.height * 0.6 : d.height * 1.1
                }
        }
        .overlay(alignment: .topTrailing, content: {
            AssetType.cloud.swiftUIImage
                .alignmentGuide(.top) { d in
                    return shrinked ? -d.height * 3 : -d.height * 8
                }
        })
        .overlay(alignment: .leading, content: {
            VStack(alignment: .leading, spacing: 10) {
                Text(title)
                    .font(FontType.largeTitle.font)
                    .foregroundColor(ColorType.white.swiftUIColor)
                
                Text(subtitle)
                    .font(FontType.headline.font)
                    .foregroundColor(ColorType.white.swiftUIColor)
            }
            .animation(.easeInOut.delay(shrinked ? 0.5 : 0),
                       value: shrinked)
            .padding(.leading)
            .offset(x: 0, y: 20)
        })
        .ignoresSafeArea()
    }
}

#Preview {
    Header(title: "Welcome", subtitle: "Company name", shrinked: false)
}
