//
//  HomeView.swift
//
//
//  Created by Arturo Murillo on 25/5/24.
//

import SwiftUI
import Localization
import DesignSystem
import Common

public struct HomeView: View {
    private let screenSize: CGSize
    @StateObject var viewModel: HomeViewModel
    
    enum Constants {
        static let topPadding: CGFloat = 40
        static let contentPadding: CGFloat = -20
        static let cornerRadius: CGFloat = 24
        static let verticalSpacing: CGFloat = 5
    }
    
    
    public static func buildDefault() -> Self {
        .init(viewModel: .buildDefault(),
              screenSize: UIScreen.main.bounds.size)
    }
    
    public init(viewModel: @autoclosure @escaping () -> HomeViewModel,
                screenSize: CGSize) {
        _viewModel = StateObject(wrappedValue: viewModel())
        self.screenSize = screenSize
    }
    
    private var containerContentView: some View {
        VStack {
            if let emptyState = viewModel.presentation.emptyState {
                EmptyStateView(viewModel: emptyState)
            } else {
                WalletView(viewModel: viewModel.presentation.wallet,
                           expand: $viewModel.isContainerExpanded)
            }
        }
        .frame(maxWidth: .infinity,
               minHeight: viewModel.presentation.containerHeight)
        .background(ColorType.background.swiftUIColor)
        .cornerRadius(Constants.cornerRadius, corners: [.topLeft, .topRight])
        .addTopContainerShadow()
        .mask(Rectangle().padding(.top, Constants.contentPadding))
        .transition(.fade)
    }
    
    private var topSpace: CGFloat {
        viewModel.presentation.topSpace
    }
    
    private var scrollViewOffset: CGPoint {
        viewModel.scrollViewOffset
    }
    
    private var bodyStack: some View {
        ZStack(alignment: .top) {
            Header(title: viewModel.presentation.title,
                   subtitle: viewModel.presentation.subtitle,
                   shrinked: !viewModel.isContainerExpanded)
            .frame(width: screenSize.width,
                   height: max(.zero, topSpace + Constants.topPadding + scrollViewOffset.y))
            .opacity(Double(max((topSpace + scrollViewOffset.y) / topSpace, .zero)))
            
            OffsetScrollView(showsIndicators: false, offset: $viewModel.scrollViewOffset) {
                VStack(alignment: .leading, spacing: Constants.verticalSpacing, content: {
                    Rectangle()
                        .frame(width: .zero, height: topSpace)
                    containerContentView
                })
            }
            .frame(width: screenSize.width,
                   alignment: .topLeading)
        }
        .overlay(alignment: .top) {
            VStack {
                if viewModel.presentation.isLoading {
                    ProgressView()
                        .progressViewStyle(.circular)
                        .offset(CGSize(width: 0.0, height: 20.0))
                }
            }
        }
    }
    
    public var body: some View {
        ZStack(alignment: .top) {
            bodyStack
            
            VStack {
                Spacer()
                BottomBarView(selectedIndex: $viewModel.selectedTabIndex,
                              items: viewModel.presentation.tabs.map({ tab in
                    BottomBarView.Item(title: tab.title,
                                       asset: tab.asset)
                }))
                .addContainerShadow()
            }
            .ignoresSafeArea()
        }
        .overlay(alignment: .topLeading) {
            Button(action: {
                
            }) {
                AssetType.profileIcon.swiftUIImage
            }
            .padding()
            .opacity(viewModel.presentation.showProfileButton ? 1 : 0)
        }
        .background(ColorType.background.swiftUIColor)
        .onAppear(perform: {
            Task {
                await viewModel.fetchCompany()
            }
        })
        .bounceAnimation(key: viewModel.presentation)
    }
}
