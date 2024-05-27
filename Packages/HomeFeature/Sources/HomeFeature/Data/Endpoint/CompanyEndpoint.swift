//
//  WalletEndpoint.swift
//
//
//  Created by Arturo Murillo on 26/5/24.
//

import Foundation
import Network

enum CompanyEndpoint: Endpoint {
    case getCompany(APIConfiguration)
    
    var scheme: String {
        switch self {
        case .getCompany(let configuration):
            return configuration.scheme
        }
    }
    
    var baseURL: String {
        switch self {
        case .getCompany(let configuration):
            return configuration.baseURL
        }
    }
    
    var path: String {
        "/api/company"
    }
    
    var method: RequestMethod {
        switch self {
        case .getCompany:
            return .get
        }
    }
}
