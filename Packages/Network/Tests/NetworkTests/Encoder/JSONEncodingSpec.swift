//
//  JSONEncodingSpec.swift
//
//
//  Created by Arturo Murillo on 25/5/24.
//

import Quick
import Nimble
import XCTest
@testable import Network

final class JSONEncodingSpec: QuickSpec {
    override static func spec() {
        describe("\(JSONEncoding.self) Spec") {
            var sut: JSONEncoding!
            
            beforeEach {
                sut = JSONEncoding()
            }
            
            afterEach {
                sut = nil
            }
            
            describe("JSON Encoding") {
                it("Should return valid Data") {
                    var result: Data?
                    expect(result = try sut.encode(parameters: Constants.json)).toNot(throwError(NetworkError.unableToEncode))
                    let resultUnwrapped: Data = try XCTUnwrap(result)
                    let deserializedObject = try JSONSerialization.jsonObject(with: resultUnwrapped, options: .mutableContainers)
                    let json = try XCTUnwrap(deserializedObject as? [String: Any])
                    expect(json.keys).to(equal(Constants.json.keys))
                }
            }
        }
    }
}

extension JSONEncodingSpec {
    enum Constants {
        static let json: [String: Any] = [
            "name": "Arturo Murillo",
            "age": 33,
            "isStudent": false,
            "courses": ["DataBases", "Algorithms"],
            "address": [
                "street": "123 Main St",
                "city": "Anytown"
            ],
            "birthday": "2024/01/01"
        ]
    }
}
