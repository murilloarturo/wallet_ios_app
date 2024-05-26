//
//  WalletAppApp.swift
//  WalletApp
//
//  Created by Arturo Murillo on 25/5/24.
//

import SwiftUI
import HomeFeature

@main
struct WalletApp: App {
    var body: some Scene {
        WindowGroup {
            HomeView.buildDefault()
        }
    }
}
