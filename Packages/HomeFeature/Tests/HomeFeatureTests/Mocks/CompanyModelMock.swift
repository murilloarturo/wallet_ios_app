//
//  CompanyModelMock.swift
//
//
//  Created by Arturo Murillo on 27/5/24.
//

@testable import HomeFeature

struct CompanyModelMocks {
    static let company = CompanyModel(name: "Hello", 
                                      wallets: [.init(id: "0",
                                                      name: "My Wallet",
                                                      iconURL: "https://www.google.com",
                                                      amount: .init(amount: 100))])
}
