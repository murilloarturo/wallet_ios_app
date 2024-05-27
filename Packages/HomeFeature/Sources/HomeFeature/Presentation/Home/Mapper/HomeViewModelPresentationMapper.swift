//
//  WalletViewModelMapper.swift
//
//
//  Created by Arturo Murillo on 26/5/24.
//

import UIKit
import Foundation
import Common
import Localization
import DesignSystem

final class HomeViewModelPresentationMapper: Mapping {
    typealias Mapper = any Mapping<Input, Output>
    enum Constants {
        enum Currency {
            static let usd = "usd";
            static let eur = "eur";
            static let gbp = "gbp";
            static let vef = "vef";
            static let cop = "cop";
            static let krw = "krw";
            static let jpy = "jpy";
            static let empty = "";
        }
        enum Container {
            static let topPadding: CGFloat = 40
            static let initialHeight: CGFloat = 500
        }
    }
    
    let screenSize: CGSize
    
    static func buildDefault() -> Self {
        .init(screenSize: UIScreen.main.bounds.size)
    }
    
    init(screenSize: CGSize) {
        self.screenSize = screenSize
    }
    
    func map(_ input: HomeViewModel.State) -> HomeViewModelPresentation {
        let tabs = input.tabs.map { mapTab($0) }
        let isExpanded = input.error != nil || input.selectedTab == .products || input.isViewExpanded
        let topSpace = getContainerHeight(expanded: isExpanded)
        let title = input.selectedTab == .home ? LocalizedString.homeTitle : LocalizedString.productsTab
        let subtitle = input.selectedTab == .home ? input.company?.name : nil
        let containerHeight = isExpanded ? screenSize.height * 0.7 : 400
        return .init(isLoading: input.isLoading,
                     title: title,
                     subtitle: subtitle,
                     tabs: tabs,
                     showHomeTab: input.selectedTab == .home,
                     showProductsTab: input.selectedTab == .products,
                     topSpace: topSpace,
                     showProfileButton: input.selectedTab == .home,
                     containerHeight: containerHeight,
                     wallet: mapWallet(input), 
                     emptyState: getEmptyState(input))
    }
    
    private func getEmptyState(_ input: HomeViewModel.State) -> EmptyStateViewModelPresentation? {
        switch input.selectedTab {
        case .home:
            if input.isLoading {
                return .init(backgroundImage: AssetType.emptyState,
                             title: LocalizedString.loading,
                             subtitle: LocalizedString.loadingSubtitle)
            } else if input.error != nil {
                return .init(backgroundImage: AssetType.emptyState,
                             title: LocalizedString.genericError,
                             subtitle: LocalizedString.genericErrorSubtitle)
            } else {
                return nil
            }
        case .products:
            return .init(backgroundImage: AssetType.emptyState,
                         title: LocalizedString.comingSoon,
                         subtitle: LocalizedString.workInProgress)
        }
    }
    
    private func getContainerHeight(expanded: Bool) -> CGFloat {
        let screenHeight = UIScreen.main.bounds.height
        if expanded {
            return screenHeight * 0.15
        } else {
            return screenHeight - Constants.Container.initialHeight
        }
    }
    
    private func mapTab(_ input: HomeTab) -> HomeViewModelPresentation.Tab {
        switch input {
        case .home:
            return .init(title: LocalizedString.walletTab,
                         asset: AssetType.walletIcon,
                         type: input)
        case .products:
            return .init(title: LocalizedString.productsTab,
                         asset: AssetType.productsIcon,
                         type: input)
        }
    }
    
    private func mapWallet(_ input: HomeViewModel.State) -> WalletViewModelPresentation {
        var items: [WalletViewModelPresentation.Item] = []
        var itemsCount: Int = input.company?.wallets.count ?? 0
        if !input.isViewExpanded {
            itemsCount = 3
        }
        for index in 0...itemsCount - 1 {
            guard let model = input.company?.wallets[safe: index] else { break }
            items.append(WalletViewModelPresentation.Item(id: model.id,
                                                          name: model.name.uppercased(),
                                                          description: mapDescription(model.name),
                                                          iconURL: URL(string: model.iconURL),
                                                          amount: "\(model.amount.amount)"))
        }
        
        input.company?.wallets.forEach({ model in
            
        })
        return .init(title: LocalizedString.yourCurrencies,
                     viewAllButtonTitle: input.isViewExpanded && input.selectedTab == .home ? LocalizedString.viewLess : LocalizedString.viewAll,
                     items: items)
    }
    
    private func mapDescription(_ input: String) -> String {
        switch input.lowercased() {
        case Constants.Currency.usd:
            return LocalizedString.usdCurrency
        case Constants.Currency.eur:
            return LocalizedString.eurCurrency
        case Constants.Currency.gbp:
            return LocalizedString.gbpCurrency
        case Constants.Currency.vef:
            return LocalizedString.vefCurrency
        case Constants.Currency.cop:
            return LocalizedString.copCurrency
        case Constants.Currency.krw:
            return LocalizedString.krwCurrency
        case Constants.Currency.jpy:
            return LocalizedString.jpyCurrency
        default:
            return Constants.Currency.empty
        }
    }
}
