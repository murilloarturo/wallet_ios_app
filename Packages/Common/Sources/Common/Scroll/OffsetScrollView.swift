//
//  OffsetScrollView.swift
//
//
//  Created by Arturo Murillo on 26/5/24.
//

import SwiftUI

public struct OffsetScrollView<Content>: View where Content: View {
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
