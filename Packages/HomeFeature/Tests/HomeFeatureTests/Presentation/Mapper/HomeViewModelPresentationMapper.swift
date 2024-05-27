//
//  HomeViewModelPresentationMapper.swift
//
//
//  Created by Arturo Murillo on 27/5/24.
//

import Quick
import Nimble
import XCTest
@testable import HomeFeature
import DesignSystem

final class HomeViewModelPresentationMapperSpec: QuickSpec {
    override static func spec() {
        describe("\(HomeViewModelPresentationMapper.self) Spec") {
            var sut: HomeViewModelPresentationMapper!
            
            beforeEach {
                sut = .init(screenSize: TestDouble.screenSize)
            }
            
            afterEach {
                sut = nil
            }
            
            context("Map") {
                it("Should return valid view model") {
                    let model = setupState(isViewExpanded: false, selectedTab: .home)
                    let viewModel = sut.map(model)
                    let expectation = TestDouble.happyPathResult
                    expect(viewModel).to(equal(expectation))
                }
                
                it("Should return valid model for expanded view") {
                    let model = setupState(isViewExpanded: true, selectedTab: .home)
                    let viewModel = sut.map(model)
                    let expectation = TestDouble.screenExpanded
                    expect(viewModel).to(equal(expectation))
                }
                
                it("Should return valid model for products tab") {
                    let model = setupState(isViewExpanded: true, selectedTab: .products)
                    let viewModel = sut.map(model)
                    let expectation = TestDouble.productsTabResult
                    expect(viewModel).to(equal(expectation))
                }
            }
            
            func setupState(isViewExpanded: Bool, selectedTab: HomeTab) -> HomeViewModel.State {
                return HomeViewModel.State(selectedTab: selectedTab,
                                           tabs: [.home, .products],
                                           isLoading: false,
                                           isViewExpanded: isViewExpanded,
                                           company: .init(name: "Hola Mundo",
                                                          wallets: [.init(id: "1",
                                                                          name: "USD",
                                                                          iconURL: "https://www.google.com",
                                                                          amount: .init(amount: 100000)),
                                                                    .init(id: "2",
                                                                          name: "EUR",
                                                                          iconURL: "https://www.google.com",
                                                                          amount: .init(amount: 100000)),
                                                                    .init(id: "3",
                                                                          name: "GBP",
                                                                          iconURL: "https://www.google.com",
                                                                          amount: .init(amount: 100000)),
                                                                    .init(id: "4",
                                                                          name: "VEF",
                                                                          iconURL: "https://www.google.com",
                                                                          amount: .init(amount: 100000)),
                                                                    .init(id: "5",
                                                                          name: "COP",
                                                                          iconURL: "https://www.google.com",
                                                                          amount: .init(amount: 100000)),
                                                                    .init(id: "6",
                                                                          name: "KRW",
                                                                          iconURL: "https://www.google.com",
                                                                          amount: .init(amount: 100000)),
                                                                    .init(id: "7",
                                                                          name: "JPY",
                                                                          iconURL: "https://www.google.com",
                                                                          amount: .init(amount: 100000)),
                                                                    .init(id: "9",
                                                                          name: "Other",
                                                                          iconURL: "https://www.google.com",
                                                                          amount: .init(amount: 100000)),
                                                          ]),
                                           error: nil)
            }
        }
    }
}

extension HomeViewModelPresentationMapperSpec {
    private enum TestDouble {
        static let screenSize = CGSize(width: 1000, height: 1000)
        static let happyPathResult = HomeViewModelPresentation(isLoading: false,
                                                               title: "Welcome",
                                                               subtitle: "Hola Mundo",
                                                               tabs: [.init(title: "Home",
                                                                            asset: AssetType.walletIcon,
                                                                            type: .home),
                                                                      .init(title: "Products",
                                                                            asset: AssetType.productsIcon,
                                                                            type: .products)],
                                                               showHomeTab: true,
                                                               showProductsTab: false,
                                                               topSpace: 352.0,
                                                               showProfileButton: true,
                                                               containerHeight: 400.0,
                                                               wallet: .init(title: "Your currencies",
                                                                             viewAllButtonTitle: "View all",
                                                                             items: [.init(id: "1",
                                                                                           name: "USD",
                                                                                           description: "United States Dollar",
                                                                                           iconURL: URL(string: "https://www.google.com"),
                                                                                           amount: "100000.0"),
                                                                                     .init(id: "2",
                                                                                           name: "EUR",
                                                                                           description: "Euro",
                                                                                           iconURL: URL(string: "https://www.google.com"),
                                                                                           amount: "100000.0"),
                                                                                     .init(id: "3",
                                                                                           name: "GBP",
                                                                                           description: "Pound sterling",
                                                                                           iconURL: URL(string: "https://www.google.com"),
                                                                                           amount: "100000.0"),
                                                                             ]),
                                                               emptyState: nil)
        static let screenExpanded = HomeViewModelPresentation(isLoading: false,
                                                              title: "Welcome",
                                                              subtitle: "Hola Mundo",
                                                              tabs: [.init(title: "Home",
                                                                           asset: AssetType.walletIcon,
                                                                           type: .home),
                                                                     .init(title: "Products",
                                                                           asset: AssetType.productsIcon,
                                                                           type: .products)],
                                                              showHomeTab: true,
                                                              showProductsTab: false,
                                                              topSpace: 127.8,
                                                              showProfileButton: true,
                                                              containerHeight: 700.0,
                                                              wallet: .init(title: "Your currencies",
                                                                            viewAllButtonTitle: "View less",
                                                                            items: [.init(id: "1",
                                                                                          name: "USD",
                                                                                          description: "United States Dollar",
                                                                                          iconURL: URL(string: "https://www.google.com"),
                                                                                          amount: "100000.0"),
                                                                                    .init(id: "2",
                                                                                          name: "EUR",
                                                                                          description: "Euro",
                                                                                          iconURL: URL(string: "https://www.google.com"),
                                                                                          amount: "100000.0"),
                                                                                    .init(id: "3",
                                                                                          name: "GBP",
                                                                                          description: "Pound sterling",
                                                                                          iconURL: URL(string: "https://www.google.com"),
                                                                                          amount: "100000.0"),
                                                                                    .init(id: "4",
                                                                                          name: "VEF",
                                                                                          description: "Venezuelan Bolívar",
                                                                                          iconURL: URL(string: "https://www.google.com"),
                                                                                          amount: "100000.0"),
                                                                                    .init(id: "5",
                                                                                          name: "COP",
                                                                                          description: "Colombian peso",
                                                                                          iconURL: URL(string: "https://www.google.com"),
                                                                                          amount: "100000.0"),
                                                                                    .init(id: "6",
                                                                                          name: "KRW",
                                                                                          description: "South Korean won",
                                                                                          iconURL: URL(string: "https://www.google.com"),
                                                                                          amount: "100000.0"),
                                                                                    .init(id: "7",
                                                                                          name: "JPY",
                                                                                          description: "Japanese Yen",
                                                                                          iconURL: URL(string: "https://www.google.com"),
                                                                                          amount: "100000.0"),
                                                                                    .init(id: "9",
                                                                                          name: "OTHER",
                                                                                          description: "",
                                                                                          iconURL: URL(string: "https://www.google.com"),
                                                                                          amount: "100000.0"),
                                                                            ]),
                                                              emptyState: nil)
        static let productsTabResult = HomeViewModelPresentation(isLoading: false,
                                                                 title: "Products",
                                                                 subtitle: nil,
                                                                 tabs: [.init(title: "Home",
                                                                              asset: AssetType.walletIcon,
                                                                              type: .home),
                                                                        .init(title: "Products",
                                                                              asset: AssetType.productsIcon,
                                                                              type: .products)],
                                                                 showHomeTab: false,
                                                                 showProductsTab: true,
                                                                 topSpace: 127.8,
                                                                 showProfileButton: false,
                                                                 containerHeight: 700.0,
                                                                 wallet: .init(title: "Your currencies",
                                                                               viewAllButtonTitle: "View all",
                                                                               items: [.init(id: "1",
                                                                                             name: "USD",
                                                                                             description: "United States Dollar",
                                                                                             iconURL: URL(string: "https://www.google.com"),
                                                                                             amount: "100000.0"),
                                                                                       .init(id: "2",
                                                                                             name: "EUR",
                                                                                             description: "Euro",
                                                                                             iconURL: URL(string: "https://www.google.com"),
                                                                                             amount: "100000.0"),
                                                                                       .init(id: "3",
                                                                                             name: "GBP",
                                                                                             description: "Pound sterling",
                                                                                             iconURL: URL(string: "https://www.google.com"),
                                                                                             amount: "100000.0"),
                                                                                       .init(id: "4",
                                                                                             name: "VEF",
                                                                                             description: "Venezuelan Bolívar",
                                                                                             iconURL: URL(string: "https://www.google.com"),
                                                                                             amount: "100000.0"),
                                                                                       .init(id: "5",
                                                                                             name: "COP",
                                                                                             description: "Colombian peso",
                                                                                             iconURL: URL(string: "https://www.google.com"),
                                                                                             amount: "100000.0"),
                                                                                       .init(id: "6",
                                                                                             name: "KRW",
                                                                                             description: "South Korean won",
                                                                                             iconURL: URL(string: "https://www.google.com"),
                                                                                             amount: "100000.0"),
                                                                                       .init(id: "7",
                                                                                             name: "JPY",
                                                                                             description: "Japanese Yen",
                                                                                             iconURL: URL(string: "https://www.google.com"),
                                                                                             amount: "100000.0"),
                                                                                       .init(id: "9",
                                                                                             name: "OTHER",
                                                                                             description: "",
                                                                                             iconURL: URL(string: "https://www.google.com"),
                                                                                             amount: "100000.0"),
                                                                               ]),
                                                                 emptyState: .init(backgroundImage: AssetType.emptyState, title: "Coming soon", subtitle: "We are currently working in more features to offer the best experience"))
    }
}

