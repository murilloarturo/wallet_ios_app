//
//  APIClient.swift
//
//
//  Created by Arturo Murillo on 26/5/24.
//

import Foundation
import Network

protocol APIClienting {
    func fetchCompany() async throws -> Result<CompanyDataModel, Error>
}

final class APIClient {
    private let apiConfiguration: APIConfiguration
    private let networkManager: NetworkClient

    init(networkManager: NetworkClient,
         environment: APIEnvironment,
         apiConfigurationFactory: APIConfigurationFactoring.Type) {
        self.networkManager = networkManager
        self.apiConfiguration = apiConfigurationFactory.build(for: environment)
    }

    static func buildDefault() -> Self {
        .init(networkManager: NetworkManager.buildDefault(loggingEnabled: true),
              environment: .local,
              apiConfigurationFactory: APIConfigurationFactory.self)
    }
}

extension APIClient: APIClienting {
    func fetchCompany() async throws -> Result<CompanyDataModel, Error> {
        let endpoint = CompanyEndpoint.getCompany(apiConfiguration)
        return try await networkManager.asyncRequest(endpoint: endpoint)
    }
}
