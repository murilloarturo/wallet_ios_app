//
//  NetworkManagerSpec.swift
//
//
//  Created by Arturo Murillo on 25/5/24.
//

import Quick
import Nimble
import XCTest
@testable import Network

final class NetworkManagerSpec: AsyncSpec {
    override static func spec() {
        describe("\(NetworkManager.self) Spec") {
            var sut: NetworkManager!
            var urlSession: URLSession!
            
            beforeEach {
                let sessionConfiguration = URLSessionConfiguration.ephemeral
                sessionConfiguration.protocolClasses = [MockURLProtocol.self]
                urlSession = URLSession(configuration: sessionConfiguration)
                sut = NetworkManager(session: urlSession,
                                     customDecoder: JSONDecoder(),
                                     loggingEnabled: false,
                                     timeout: 10)
            }
            
            afterEach {
                sut = nil
                urlSession = nil
            }
            
            describe("Request") {
                it("Should return success") {
                    setup(statusCode: 200)
                    let serviceResult: Result<ClassMock, Error> = try await sut.asyncRequest(endpoint: MockEndpoint.fake)
                    expect(try serviceResult.get()).toNot(throwError())
                    expect(try serviceResult.get()).to(equal(ClassMock(id: 1)))
                }
                
                it("Should return unable to decode data error") {
                    setup(statusCode: 200)
                    let serviceResult: Result<Bool, Error> = try await sut.asyncRequest(endpoint: MockEndpoint.fake)
                    expect(try serviceResult.get()).to(throwError(NetworkError.unableToDecode))
                }
                
                it("Should return authentication error") {
                    setup(statusCode: 401)
                    let serviceResult: Result<ClassMock, Error> = try await sut.asyncRequest(endpoint: MockEndpoint.fake)
                    expect(try serviceResult.get()).to(throwError(NetworkError.authentication))
                }
                
                it("Should return bad request error") {
                    setup(statusCode: 501)
                    let serviceResult: Result<ClassMock, Error> = try await sut.asyncRequest(endpoint: MockEndpoint.fake)
                    expect(try serviceResult.get()).to(throwError(NetworkError.badRequest))
                }
                
                it("Should return outdated error") {
                    setup(statusCode: 600)
                    let serviceResult: Result<ClassMock, Error> = try await sut.asyncRequest(endpoint: MockEndpoint.fake)
                    expect(try serviceResult.get()).to(throwError(NetworkError.outdated))
                }
                
                it("Should return request failed error") {
                    setup(statusCode: 300)
                    let serviceResult: Result<ClassMock, Error> = try await sut.asyncRequest(endpoint: MockEndpoint.fake)
                    expect(try serviceResult.get()).to(throwError(NetworkError.failed))
                }
                
                it("Should return no connection error") {
                    setupError(FakeError.whatever)
                    let serviceResult: Result<ClassMock, Error> = try await sut.asyncRequest(endpoint: MockEndpoint.fake)
                    expect(try serviceResult.get()).to(throwError(NetworkError.noConnection))
                }
            }
            
            func setup(statusCode: Int) {
                MockURLProtocol.requestHandler = { request in
                    let exampleData =
                            """
                            {"id":1}
                            """
                        .data(using: .utf8)!
                    let response = HTTPURLResponse(statusCode: statusCode)
                    return (response, exampleData)
                }
            }
            
            func setupError(_ error: Error) {
                MockURLProtocol.requestHandler = { request in
                    throw error
                }
                
            }
        }
    }
}
