//
//  CompanyErrorMapperSpec.swift
//  
//
//  Created by Arturo Murillo on 27/5/24.
//

import Quick
import Nimble
import XCTest
@testable import HomeFeature
import Network

final class CompanyErrorMapperSpec: QuickSpec {
    override static func spec() {
        describe("\(CompanyErrorMapper.self) Spec") {
            var sut: CompanyErrorMapper!

            beforeEach {
                sut = .init()
            }
            
            afterEach {
                sut = nil
            }

            context("Map") {
                it("Should return generic error on random error") {
                    expect(sut.map(ApiClientMockError.noCallback)).to(equal(CompanyError.generic))
                }
                
                it("Should return connection error") {
                    expect(sut.map(NetworkError.noConnection)).to(equal(CompanyError.noConnection))
                }
                
                it("Should return generic error on any other error") {
                    expect(sut.map(NetworkError.badURL)).to(equal(CompanyError.generic))
                }
            }
        }
    }
}
