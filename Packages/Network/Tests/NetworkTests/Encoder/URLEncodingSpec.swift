//
//  URLEncodingSpec.swift
//
//
//  Created by Arturo Murillo on 25/5/24.
//

import Quick
import Nimble
import XCTest
@testable import Network

final class URLEncodingSpec: QuickSpec {
    override static func spec() {
        describe("\(URLEncoding.self) Spec") {
            var sut: URLEncoding!
            
            beforeEach {
                sut = URLEncoding()
            }
            
            afterEach {
                sut = nil
            }
            
            describe("JSON Encoding") {
                it("Should return valid query parameters") {
                    var result: [URLQueryItem]?
                    expect(result = sut.encode(parameters: Constants.queryParameters)).toNot(throwError())
                    expect(result?.count).to(equal(3))
                    expect(result?.map { $0.name }).to(equal(Constants.queryParameters.map { $0.key }))
                }
            }
        }
    }
}

extension URLEncodingSpec {
    enum Constants {
        static let queryParameters: [String: Any] = [
            "id": "1",
            "name": "Arturo Murillo",
            "birthday": "2024/01/01"
        ]
    }
}
