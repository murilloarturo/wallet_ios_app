//
//  CompanyModelMapperError.swift
//  
//
//  Created by Arturo Murillo on 27/5/24.
//

import Quick
import Nimble
import XCTest
@testable import HomeFeature
import Network

final class CompanyModelMapperSpec: QuickSpec {
    override static func spec() {
        describe("\(CompanyModelMapper.self) Spec") {
            var sut: CompanyModelMapper!

            beforeEach {
                sut = .init()
            }
            
            afterEach {
                sut = nil
            }

            context("Map") {
                it("Should return valid model") {
                    let model = sut.map(TestDouble.companyDataModel)
                    expect(model).to(equal(TestDouble.company))
                }
            }
        }
    }
}

extension CompanyModelMapperSpec {
    private enum TestDouble {
        static let companyDataModel = CompanyDataModel(name: "Hello",
                                                       wallets: [WalletDataModel(accountId: "0",
                                                                                 iconURL: "https://www.google.com",
                                                                                 amount: AmountDataModel(amount: 100,
                                                                                                         currency: "USD"),
                                                                                 creditType: "credit",
                                                                                 dateTime: "Hoy")])
        static let company = CompanyModel(name: "Hello",
                                          wallets: [.init(id: "0",
                                                          name: "USD",
                                                          iconURL: "https://www.google.com",
                                                          amount: .init(amount: 100))])
    }
}
