//
//  MockURLProtocol.swift
//
//
//  Created by Arturo Murillo on 25/5/24.
//

import Foundation

class MockURLProtocol: URLProtocol {
    static var requestHandler: ((URLRequest) throws -> (HTTPURLResponse, Data))?
    
    override class func canInit(with request: URLRequest) -> Bool {
        return true
    }
    
    override class func canonicalRequest(for request: URLRequest) -> URLRequest {
        return request
    }
    
    override func stopLoading() { }
    
    override func startLoading() {
        guard let handler = MockURLProtocol.requestHandler else {
            client?.urlProtocol(self, didFailWithError: FakeError.noMock)
            client?.urlProtocolDidFinishLoading(self)
            return
        }
        do {
            let (response, data)  = try handler(request)
            client?.urlProtocol(self, didReceive: response, cacheStoragePolicy: .notAllowed)
            client?.urlProtocol(self, didLoad: data)
            client?.urlProtocolDidFinishLoading(self)
        } catch  {
            client?.urlProtocol(self, didFailWithError: error)
            client?.urlProtocolDidFinishLoading(self)
        }
    }
}

extension HTTPURLResponse {
    convenience init(statusCode: Int) {
        let url = URL(string: "https://google.com")!
        self.init(url: url, statusCode: statusCode, httpVersion: nil, headerFields: nil)!
    }
}

enum FakeError: Error {
    case whatever
    case noMock
}

extension FakeError: LocalizedError {
    var errorDescription: String? {
        return "Error mocking"
    }
}
