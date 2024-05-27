//
//  GetCompanySpec.swift
//
//
//  Created by Arturo Murillo on 27/5/24.
//

import Quick
import Nimble
import XCTest
@testable import HomeFeature
import Network

final class GetCompanySpec: AsyncSpec {
    override static func spec() {
        describe("\(GetCompany.self) Spec") {
            var apiClient: ApiClientMock!
            var dataSource: CompanyRemoteDataSource!
            var sut: GetCompany!
            
            beforeEach {
                apiClient = ApiClientMock()
                dataSource = .init(apiClient: apiClient,
                                   companyModelMapper: CompanyModelMapper(),
                                   companyErrorMapper: CompanyErrorMapper()
                )
                sut = .init(dataSource: dataSource)
            }
            
            afterEach {
                sut = nil
                apiClient = nil
                dataSource = nil
            }
            
            context("Execute") {
                it("Should return valid model") {
                    apiClient.callBack = TestDouble.success
                    let response = await sut.execute()
                    expect(try response.get()).toNot(throwError())
                    expect(try response.get()).to(equal(TestDouble.company))
                }
                
                it("Should return valid error") {
                    apiClient.callBack = TestDouble.networkError
                    let response = await sut.execute()
                    expect(try response.get()).to(throwError(CompanyError.noConnection))
                }
            }
        }
    }
}

extension GetCompanySpec {
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
        static let success: () -> Result<CompanyDataModel, Error> = {
            .success(companyDataModel)
        }
        static let error: () -> Result<CompanyDataModel, Error> = { .failure(ApiClientMockError.network)
        }
        static let networkError: () -> Result<CompanyDataModel, Error> = { .failure(NetworkError.noConnection)
        }
    }
}
