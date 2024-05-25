//
//  MockEndpoint.swift
//  
//
//  Created by Arturo Murillo on 25/5/24.
//

import Foundation
@testable import Network

enum MockEndpoint: Endpoint {
    case fake
    case encodeError
    
    var scheme: String {
        return "https"
    }
    var baseURL: String {
        return "apple.com"
    }
    
    var path: String {
        return "/test"
    }
    var method: RequestMethod {
        switch self {
        case .fake:
            return .get
        case .encodeError:
            return .post
        }
    }
    var queryItems: [String: Any]? {
        return ["id": 0]
    }
    var body: [String: Any]? {
        switch self {
        case .fake:
            return [:]
        case .encodeError:
            let invalidString = String(bytes: [0xD8, 0x00] as [UInt8],
                                       encoding: String.Encoding.utf16BigEndian)!
            return ["key": invalidString]
        }
    }
    var headers: [String: String]? {
        return ["Authorization": "Bearer beer"]
    }
}
