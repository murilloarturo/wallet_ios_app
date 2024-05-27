//
//  CompanyEndpointSpec.swift
//  
//
//  Created by Arturo Murillo on 27/5/24.
//

import Quick
import Nimble
import XCTest
@testable import HomeFeature
import Network

final class CompanyEndpointSpec: QuickSpec {
    override static func spec() {
        describe("\(CompanyEndpoint.self) Spec") {
            var sut: CompanyEndpoint!

            beforeEach {
                sut = .getCompany(.init(scheme: TestDouble.scheme,
                                        baseURL: TestDouble.baseURL))
            }
            
            afterEach {
                sut = nil
            }

            context("Initialization") {
                it("scheme should be correct") {
                    expect(sut.scheme).to(equal(TestDouble.scheme))
                }
                
                it("baseUrl should be correct") {
                    expect(sut.baseURL).to(equal(TestDouble.baseURL))
                }
                
                it("port should be correct") {
                    expect(sut.port).to(equal(TestDouble.port))
                }

                it("path should be correct") {
                    expect(sut.path).to(equal(TestDouble.path))
                }

                it("httpMethod should be correct") {
                    expect(sut.method).to(equal(TestDouble.httpMethod))
                }

                it("parameters should be correct") {
                    expect(sut.queryItems).to(beNil())
                }
                
                it("body parameters should be correct") {
                    expect(sut.body).to(beNil())
                }

                it("headers should be correct") {
                    expect(sut.headers).to(beNil())
                }
            }
        }
    }
}

extension CompanyEndpointSpec {
    private enum TestDouble {
        static let scheme = "http"
        static let baseURL = "127.0.0.1"
        static let port = 8080
        static let path = "/api/company"
        static let httpMethod = RequestMethod.get
    }
}
