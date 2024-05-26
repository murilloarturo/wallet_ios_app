//
//  HomeView.swift
//
//
//  Created by Arturo Murillo on 25/5/24.
//

import SwiftUI
import Localization
import DesignSystem

public struct HomeView: View {
    @State var viewModel: HomeViewModel
    @State private var selectedIndex: Int = 0
    @State private var offset: CGPoint = CGPoint(x: 0, y: 0)
    @State private var topSpace: CGFloat
    
    enum Constants {
        static let topPadding: CGFloat = 40
    }
    
    var isShowingHome: Bool {
        selectedIndex == 0
    }
    
    @MainActor public static func buildDefault() -> Self {
        .init(viewModel: HomeViewModel(model: .init(tabs: [.home, .products])),
              selectedIndex: 0)
    }
    
    init(viewModel: HomeViewModel, selectedIndex: Int) {
        self.viewModel = viewModel
        self.selectedIndex = selectedIndex
        self.topSpace = UIScreen.main.bounds.height * 0.4
    }

    public var body: some View {
        ZStack(alignment: .top) {
            GeometryReader { proxy in
                ZStack(alignment: .top) {
                    Header(title: isShowingHome ? LocalizedString.homeTitle : LocalizedString.productsTab, 
                           subtitle: isShowingHome ? "Arturo" : "",
                           shrinked: !isShowingHome)
                        .frame(width: UIScreen.main.bounds.width,
                               height: max(0, topSpace + Constants.topPadding + offset.y))
                        .opacity(Double(max((topSpace + self.offset.y) / topSpace, 0)))
                    
                    OffsetScrollView(showsIndicators: false, offset: self.$offset) {
                        VStack(alignment: .leading, spacing: 5, content: {
                            Rectangle()
                                .frame(width: 0, height: topSpace)
                            ContentView(selectedIndex: $selectedIndex)
                        })
                    }
                    .frame(width: proxy.size.width, height: nil, alignment: .topLeading)
                }
            }
            VStack {
                Spacer()
                BottomBarView(selectedIndex: $selectedIndex,
                              items: viewModel.tabs.map({ tab in
                    BottomBarView.Item(title: tab.title,
                                       asset: tab.asset)
                }))
                .shadow(color: .black.opacity(0.25),
                        radius: 10, x: 0, y: 5)
            }
            .ignoresSafeArea()
        }
        .overlay(alignment: .topLeading) {
            GeometryReader(content: { geometry in
                Button(action: {
                    
                }) {
                    AssetType.profileIcon.swiftUIImage
                }
                .padding()
                .opacity(isShowingHome ? 1 : 0)
            })
        }
        .background(ColorType.background.swiftUIColor)
        .onChange(of: selectedIndex) { newValue in
            withAnimation(.spring(duration: 0.8, bounce: 0.2)) {
                if newValue == 0 {
                    topSpace = UIScreen.main.bounds.height * 0.4
                } else {
                    topSpace = UIScreen.main.bounds.height * 0.15
                }
            }
        }
    }
}

struct ContentView: View {
    @Binding var selectedIndex: Int
    
    var body: some View {
        VStack {
            if selectedIndex == 0 {
                Color.red.frame(height: 200)
            } else {
                ProductsEmptyStateView.buildDefault()
                    .frame(maxWidth: .infinity, minHeight: UIScreen.main.bounds.height * 0.8)
            }
        }
        
        .background(ColorType.background.swiftUIColor)
        .cornerRadius(24, corners: [.topLeft, .topRight])
        .shadow(color: .black.opacity(0.5),
                radius: 10, x: 0, y: -3)
        .mask(Rectangle().padding(.top, -20))
        .transition(.fade)
    }
}

extension AnyTransition {
    static var fade: AnyTransition {
        AnyTransition.opacity
                    .combined(with: .scale(scale: 0, anchor: .center))
                    .animation(.default)
    }
}

struct OffsetScrollView<Content>: View where Content: View {
    let content: Content
    let axes: Axis.Set
    let showsIndicators: Bool
    @State var initialOffset: CGPoint?
    @Binding var offset: CGPoint
    
    public init(_ axes: Axis.Set = .vertical, 
                showsIndicators: Bool = true,
                offset: Binding<CGPoint> = .constant(.zero),
                @ViewBuilder content: () -> Content) {
        self.axes = axes
        self.showsIndicators = showsIndicators
        self._offset = offset
        self.content = content()
    }
    
    public var body: some View {
        ScrollView(axes, showsIndicators: showsIndicators) {
            VStack(alignment: .leading, spacing: 0) {
                GeometryReader { geometry in
                    Run {
                        let globalOrigin = geometry.frame(in: .global).origin
                        self.initialOffset = self.initialOffset ?? globalOrigin
                        let initialOffset = (self.initialOffset ?? .zero)
                        let offset = CGPoint(x: globalOrigin.x - initialOffset.x, y: globalOrigin.y - initialOffset.y)
                        self.$offset.wrappedValue = offset
                    }
                }.frame(width: 0, height: 0)

                content
            }
            .background(Color.clear)
        }
    }
}

struct Run: View {
    let block: () -> Void

    var body: some View {
        DispatchQueue.main.async(execute: block)
        return AnyView(EmptyView())
    }
}

struct CornerRadiusStyle: ViewModifier {
    var radius: CGFloat
    var corners: UIRectCorner
    
    struct CornerRadiusShape: Shape {

        var radius = CGFloat.infinity
        var corners = UIRectCorner.allCorners

        func path(in rect: CGRect) -> Path {
            let path = UIBezierPath(roundedRect: rect, byRoundingCorners: corners, cornerRadii: CGSize(width: radius, height: radius))
            return Path(path.cgPath)
        }
    }

    func body(content: Content) -> some View {
        content
            .clipShape(CornerRadiusShape(radius: radius, corners: corners))
    }
}

extension View {
    func cornerRadius(_ radius: CGFloat, corners: UIRectCorner) -> some View {
        ModifiedContent(content: self, modifier: CornerRadiusStyle(radius: radius, corners: corners))
    }
}
