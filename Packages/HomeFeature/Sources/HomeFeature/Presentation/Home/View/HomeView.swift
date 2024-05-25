//
//  HomeView.swift
//
//
//  Created by Arturo Murillo on 25/5/24.
//

import SwiftUI

public struct HomeView: View {
    public init() {
        
    }
    
    public var body: some View {
        TabView {
            WalletView()
                .tabItem { Label("Wallet", systemImage: "list.dash") }
            
            ProductView()
                .tabItem { Label("Product", systemImage: "square.and.pencil") }
            
        }
    }
}

#Preview {
    HomeView()
}
