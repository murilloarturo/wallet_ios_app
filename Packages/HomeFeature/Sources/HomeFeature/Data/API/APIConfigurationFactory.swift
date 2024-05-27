//
//  APIConfigurationFactory.swift
//
//
//  Created by Arturo Murillo on 26/5/24.
//

import Foundation

protocol APIConfigurationFactoring {
    static func build(for environment: APIEnvironment) -> APIConfiguration
}

struct APIConfigurationFactory: APIConfigurationFactoring {
    static func build(for environment: APIEnvironment) -> APIConfiguration {
        .init(scheme: scheme(for: environment),
              baseURL: baseURL(for: environment))
    }
}

private extension APIConfigurationFactory {
    static func scheme(for environment: APIEnvironment) -> String {
        switch environment {
        case .local:
            return "http"
        }
    }
    
    static func baseURL(for environment: APIEnvironment) -> String {
        switch environment {
        case .local:
            return "127.0.0.1"
        }
    }
}
