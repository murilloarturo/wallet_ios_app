//
//  ApiClientMock.swift
//
//
//  Created by Arturo Murillo on 27/5/24.
//

@testable import HomeFeature
import Network

enum ApiClientMockError: Error {
    case noCallback
    case network
}

class ApiClientMock: APIClienting {
    var called = false
    var calledCount = 0
    var callBack: (() -> Result<CompanyDataModel, Error>)? = nil
    
    func fetchCompany() async throws -> Result<CompanyDataModel, Error> {
        called = true
        calledCount += 1
        if let callBack {
            return callBack()
        } else {
            return .failure(ApiClientMockError.noCallback)
        }
    }
}
