//
//  CompanyRemoteDataSourceSpec.swift
//
//
//  Created by Arturo Murillo on 27/5/24.
//

import Quick
import Nimble
import XCTest
@testable import HomeFeature
import Network

final class CompanyRemoteDataSourceSpec: AsyncSpec {
    override static func spec() {
        describe("\(CompanyRemoteDataSource.self) Spec") {
            var sut: CompanyRemoteDataSource!
            var apiClient: ApiClientMock!
            
            beforeEach {
                apiClient = ApiClientMock()
                sut = .init(apiClient: apiClient,
                            companyModelMapper: CompanyModelMapper(),
                            companyErrorMapper: CompanyErrorMapper()
                )
            }
            
            afterEach {
                apiClient = nil
                sut = nil
            }
            
            context("Fetch Company") {
                it("Should return valid model") {
                    apiClient.callBack = TestDouble.success
                    let result = await sut.getCompany()
                    expect(try result.get()).toNot(throwError())
                    expect(try result.get()).to(equal(TestDouble.company))
                }
                
                it("Should return default company error") {
                    apiClient.callBack = TestDouble.error
                    let result = await sut.getCompany()
                    expect(try result.get()).to(throwError(CompanyError.generic))
                }
                
                it("Should return no connection error") {
                    apiClient.callBack = TestDouble.networkError
                    let result = await sut.getCompany()
                    expect(try result.get()).to(throwError(CompanyError.noConnection))
                }
            }
        }
    }
}

extension CompanyRemoteDataSourceSpec {
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
