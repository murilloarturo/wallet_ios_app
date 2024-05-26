//
//  WalletView.swift
//  
//
//  Created by Arturo Murillo on 25/5/24.
//

import SwiftUI
import DesignSystem

struct WalletView: View {
    var body: some View {
        GeometryReader { geometry in
                    ZStack {
                        
                        LinearGradient(gradient: Gradient(colors: [ColorType.gradientStart.swiftUIColor, ColorType.gradientEnd.swiftUIColor]),
                                       startPoint: .init(x: 0, y: 0),
                                       endPoint: .bottom)
                        
                        AssetType.homeBackground.swiftUIImage
                            .resizable()
                            .aspectRatio(1.2, contentMode: .fill)
                            .padding(EdgeInsets(top: 100, leading: 0, bottom: 0, trailing: 0 ))
                        
                        Text("Welcome")
                    }
                    .frame(width: geometry.size.width, height: geometry.size.height * 0.4)
                }
        .edgesIgnoringSafeArea(.all)
    }
}
