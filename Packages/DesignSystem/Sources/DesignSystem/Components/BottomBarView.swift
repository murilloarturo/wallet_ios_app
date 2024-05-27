//
//  BottomBarView.swift
//
//
//  Created by Arturo Murillo on 25/5/24.
//

import SwiftUI

public struct BottomBarView: View {
    public struct Item: Hashable {
        let title: String
        let asset: ImageAsset
        
        public init(title: String, asset: ImageAsset) {
            self.title = title
            self.asset = asset
        }
        
        public func hash(into hasher: inout Hasher) {
            hasher.combine(title)
        }
        
        public static func == (lhs: BottomBarView.Item, rhs: BottomBarView.Item) -> Bool {
            lhs.title == rhs.title
        }
    }
    @Binding var selectedIndex: Int
    let items: [Item]
    
    public init(selectedIndex: Binding<Int>, items: [Item]) {
        self._selectedIndex = selectedIndex
        self.items = items
    }
    
    public var body: some View {
        HStack {
            Spacer()
            ForEach(Array(items.enumerated()), id: \.element) { index, item in
                BottomBarButtonView(index: index,
                                    selectedIndex: $selectedIndex,
                                    text: item.title,
                                    config: .main(image: item.asset))
                
                if index < items.count - 1 {
                    Spacer()
                }
            }
            Spacer()
        }
        .padding(.bottom)
        .background(ColorType.cardBackground.swiftUIColor)
        .cornerRadius(10)
    }
}
