//
//  BottomBarButtonView.swift
//
//
//  Created by Arturo Murillo on 25/5/24.
//

import SwiftUI

public struct BottomBarButtonView: View {
    public struct Config {
        let fontType: FontType
        let image: ImageAsset
        let selectedColor: Color
        let unSelectedColor: Color
        
        static func main(image: ImageAsset) -> Config {
            .init(fontType: FontType.caption2,
                  image: image,
                  selectedColor: ColorType.blue.swiftUIColor,
                  unSelectedColor: ColorType.darkGray.swiftUIColor)
        }
    }
    
    let index: Int
    @Binding var selectedIndex: Int
    let text: String
    let config: Config
    
    public init(index: Int,
                selectedIndex: Binding<Int>,
                text: String,
                config: Config) {
        self.index = index
        self._selectedIndex = selectedIndex
        self.config = config
        self.text = text
    }
    
    public var body: some View {
        let foregroundColor = selectedIndex == index ? config.selectedColor : config.unSelectedColor
        Button(action: {
            withAnimation(.easeInOut(duration: 0.5)) {
                selectedIndex = index
            }
        }) {
            VStack {
                config.image.swiftUIImage
                    .renderingMode(.template)
                    .foregroundColor(foregroundColor)
                    .frame(width: 20, height: 20)
                Text(text)
                    .font(config.fontType.font)
            }
            .foregroundColor(foregroundColor)
            .padding()
        }
    }
}
