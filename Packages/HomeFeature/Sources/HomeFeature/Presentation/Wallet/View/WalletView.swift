//
//  WalletView.swift
//
//
//  Created by Arturo Murillo on 26/5/24.
//

import SwiftUI
import DesignSystem
import Localization

struct WalletView: View {
    var viewModel: WalletViewModelPresentation
    @Binding var expand: Bool
    
    enum Constants {
        
    }
    
    var body: some View {
        VStack(alignment: .leading) {
            HStack {
                Text(viewModel.title)
                    .font(FontType.headline.font)
                    .foregroundColor(ColorType.black.swiftUIColor)
                Spacer()
                Button(action: {
                    withAnimation(.easeInOut(duration: 0.5)) {
                        expand.toggle()
                    }
                }, label: {
                    Text(viewModel.viewAllButtonTitle)
                        .font(FontType.body.font)
                        .foregroundColor(ColorType.blue.swiftUIColor)
                        .transition(.opacity.animation(.easeInOut(duration: 0.5)))
                        .id(viewModel.viewAllButtonTitle)
                })
            }
            .padding(EdgeInsets(top: 30, leading: 20, bottom: 0, trailing: 20))
            
            List {
                ForEach(viewModel.items, id: \.self) { item in
                    HStack {
                        AsyncImage(url: item.iconURL) { image in
                            image.resizable()
                        } placeholder: {
                            ColorType.gray.swiftUIColor
                        }
                        .aspectRatio(contentMode: .fill)
                        .frame(width: 32, height: 32)
                        .clipShape(Circle())
                        VStack(alignment: .leading) {
                            Text(item.name)
                                .font(FontType.body.font)
                                .foregroundColor(ColorType.black.swiftUIColor)
                            Text(item.description)
                                .font(FontType.subheadline.font)
                                .foregroundColor(ColorType.darkGray.swiftUIColor)
                        }
                        Spacer()
                        Text(item.amount)
                            .font(FontType.title3.font)
                            .foregroundColor(ColorType.black.swiftUIColor)
                    }
                    .padding()
                    .background(ColorType.cardBackground.swiftUIColor)
                    .cornerRadius(8, corners: .allCorners)
                }
                .listRowSeparator(.hidden)
                .addCardShadow()
                .listRowBackground(Color.clear)
            }
            .listStyle(PlainListStyle())
            .clearBackground()
            .hideScrollIndicator()
            .padding(.bottom, expand ? 20 : 0)
            .enableScroll(isEnabled: expand)
        }
    }
}
